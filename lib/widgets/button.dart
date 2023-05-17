import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Color textColor;
  final String text;
  final Color color;
  final VoidCallback? onPressedOperations;
  final double width;
  final double height;
  final String? image;

  const Button({
    super.key,
    required this.text,
    required this.color,
    required this.onPressedOperations,
    required this.width,
    required this.height,
    required this.textColor,
    this.image,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  late Widget addImageButton;

  void addImageButtonControl(image, textColor) {
    if (image != null) {
      addImageButton = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            image,
            height: 25,
            width: 25,
          ),
          const Padding(padding: EdgeInsets.only(left: 20)),
          Text(widget.text, style: TextStyle(color: textColor))
        ],
      );
    } else {
      addImageButton = Text(widget.text, style: TextStyle(color: textColor));
    }
  }

  @override
  Widget build(BuildContext context) {
    addImageButtonControl(widget.image, widget.textColor);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.grey,
        elevation: 5.0,
        color: widget.color,
        child: MaterialButton(
          minWidth: widget.width,
          height: widget.height,
          onPressed: widget.onPressedOperations,
          child: addImageButton,
        ),
      ),
    );
  }
}
