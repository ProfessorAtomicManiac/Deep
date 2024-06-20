import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WaterSettingsPage extends StatelessWidget {
  const WaterSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Timer(),
            const Text("Time Until Water"),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  child: Text("Reset"),
                  onPressed: () {},
                  //onPressed: () => setState(() => _currentText = "$_mins:$_secs"),
                ),
                TextButton(child: const Text("Start"), onPressed: () => {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Timer extends StatefulWidget {
  const Timer({
    super.key,
  });

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  int _mins = 0;
  int _secs = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _handleInput(_controller);
    });
  }

  void _handleInput(TextEditingController controller) {
    final RegExp nonNumbers = RegExp(r"([^\d])");
    final RegExp sixToNine = RegExp(r"([6-9])");
    String text = controller.text.replaceAll(nonNumbers, "");
    if (text.length > 4) text = text.substring(0, 4);
    var minutes = text.length > 2 ? text.substring(0, 2) : text;
    var seconds = text.length > 2 ? text.substring(2) : "";
    if (seconds.length == 1) {
      seconds = seconds.replaceAll(sixToNine, "");
    }
    seconds = (seconds == "") ? "" : ":$seconds";
    text = "$minutes$seconds";
    controller.value = controller.value.copyWith(
      text: text,
      selection:
          TextSelection(baseOffset: text.length, extentOffset: text.length),
      composing: TextRange.empty,
    );
  }

  void _handleSubmit(BuildContext context, String value) {
    // includes the ":"
    if (value.length == 5) {
      _mins = int.tryParse(value.substring(0, 2))!;
      _secs = int.tryParse(value.substring(3, 5))!;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Invalid Time Dumbass"),
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = "${_mins.toString().padLeft(2, '0')}:${_secs.toString().padLeft(2, '0')}";
    return SizedBox(
      width: 50,
      child: TextField(
        controller: _controller,
        onSubmitted: (value) {
          _handleSubmit(context, value);
        },
      ),
    );
  }
}
