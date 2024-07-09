import 'package:flutter/material.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({super.key});

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
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
    return Column(
      children: [
        // search bar

        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(25)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              Expanded(
                child: TextField(
                  focusNode: focusNode,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration.collapsed(
                    hintText: "Search",
                    border: InputBorder.none,
                  ),
                  controller: _controller,
                  //style: TextStyle(fontSize: 24),
                ),
              ),
              textfieldHasText ? IconButton(icon: const Icon(Icons.cancel), onPressed: () {
                setState(() => _controller.text = "");
                focusNode.requestFocus();
              }) : const SizedBox(),
              IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () {},
              )
            ],
          ),
        ),

        // header
      ],
    );
  }
}
