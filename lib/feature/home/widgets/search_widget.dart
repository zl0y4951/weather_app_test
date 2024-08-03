import 'package:flutter/material.dart';
import 'package:weather_app_test/core/constants/colors.dart';
import 'package:weather_app_test/core/extensions/debouncer.dart';
import 'package:weather_app_test/core/models/search/search_base.dart';

class SearchWidget<T extends ISearchBase> extends StatefulWidget {
  const SearchWidget({super.key, this.search, this.onChanged});
  final Future<Iterable<ISearchBase>?> Function(String)? search;
  final ValueChanged<ISearchBase>? onChanged;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState<T extends ISearchBase> extends State<SearchWidget> {
  late final SearchController _controller = SearchController();
  final _debouncer = Debouncer<Iterable<ISearchBase>?>();
  late final FocusNode _focus = FocusNode();

  void _close() {
    Navigator.pop(context);
    _focus.unfocus();
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: _controller,
      isFullScreen: false,
      builder: (context, controller) {
        return SearchBar(
          focusNode: _focus,
          backgroundColor: const WidgetStatePropertyAll(CustomColors.light),
          elevation: const WidgetStatePropertyAll(0),
          controller: controller,
          hintText: 'Поиск',
          onTap: () {
            if (!controller.isOpen) {
              controller.openView();
            }
          },
          hintStyle:
              const WidgetStatePropertyAll(TextStyle(color: CustomColors.grey)),
        );
      },
      viewConstraints: const BoxConstraints(maxHeight: 200),
      viewBackgroundColor: CustomColors.light,
      viewElevation: 0.5,
      viewLeading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: _close,
        style:
            const ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      ),
      viewBuilder: (suggestions) {
        if (suggestions.isEmpty) {
          return const Center(
              child: Text(
            'Города по вашему запросу отсутсвуют',
            style: TextStyle(color: CustomColors.grey),
          ));
        }
        return ListView(
          children: List.from(suggestions),
        );
      },
      suggestionsBuilder: (context, controller) async {
        final choices = await _debouncer.run(
              () async {
                return await widget.search?.call(controller.text);
              },
            ) ??
            [];
        return choices.map(
          (e) => _SuggestionWidget(
            text: e.text,
            addText: e.addText,
            onTap: () {
              _close();
              widget.onChanged?.call(e);
            },
          ),
        );
      },
    );
  }
}

class _SuggestionWidget extends StatelessWidget {
  const _SuggestionWidget({required this.text, this.addText, this.onTap});
  final String text;
  final String? addText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      subtitle: addText != null ? Text(addText!) : null,
      onTap: onTap,
    );
  }
}
