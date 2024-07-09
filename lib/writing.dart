import 'package:flutter/material.dart';
import 'package:productivity_gacha_app/constants.dart';

class WritingPage extends StatelessWidget {
  const WritingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // search bar
        SearchBar(),
        SizedBox(height: 20),
        Header(),
      ],
    );
  }
}

class Header extends StatefulWidget {
  const Header({
    super.key,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool sortLatest = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerTextStyle = theme.textTheme.labelLarge!.copyWith(
      color: theme.colorScheme.onSurface,
    );
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Name", style: headerTextStyle),
          const Spacer(flex: 2),
          Text("Last Modified", style: headerTextStyle),
          const SizedBox(width: 5),
          IconButton(
            icon: sortLatest
                ? const Icon(Icons.arrow_downward)
                : const Icon(Icons.arrow_upward),
            iconSize: Constants.LABEL_LARGE_FONT_SIZE,
            onPressed: () {
              setState(() => sortLatest = !sortLatest);
            },
          ),
          const Spacer(flex: 1),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class SearchBar extends StatefulWidget with Constants {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool textfieldHasText = false;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _handleInput());
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _handleInput() {
    setState(() => textfieldHasText = _controller.text.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.labelLarge!.copyWith(
      color: theme.colorScheme.onSurface,
      fontSize: Constants.DEFAULT_ICON_SIZE - 5,
    );
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: Constants.curveBorderToIcon(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            padding: Constants.alignIconToText(),
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              focusNode: focusNode,
              decoration: const InputDecoration.collapsed(
                hintText: "Search",
                border: InputBorder.none,
              ),
              controller: _controller,
              style: textStyle,
              cursorColor: theme.colorScheme.onSurface,
              
            ),
          ),
          textfieldHasText
              ? IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    setState(() => _controller.text = "");
                    focusNode.requestFocus();
                  })
              : const SizedBox(),
          IconButton(
            padding: Constants.alignIconToText(),
            icon: const Icon(Icons.sort),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
