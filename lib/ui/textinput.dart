import 'package:flutter/material.dart';
import 'package:softcatala/colors.dart';

class TextInput extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  TextInput({
    Key? key,
    required this.isInput,
    required this.textController,
  }) : super(key: key);
  final TextEditingController textController;
  final bool isInput;
  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool _visible = true;

  toggleVisibility() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget.textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textController,
      showCursor: widget.isInput,
      enabled: _visible,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(0.1)),
          borderSide: BorderSide(
            color: SoftcatalaColors.grey,
            style: BorderStyle.solid,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(0.1)),
          borderSide: BorderSide(
            color: SoftcatalaColors.grey,
            style: BorderStyle.solid,
          ),
        ),
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      readOnly: !widget.isInput,
      autocorrect: widget.isInput,
    );
  }
}
