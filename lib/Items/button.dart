import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Color textColor;
  final String text;
  final Color color;
  final VoidCallback? onPressedOperations;
  final double Width;
  final double height;
  Widget? child;
  var image = null;

  Button({
    super.key,
    required this.text,
    required this.color,
    required this.onPressedOperations,
    required this.Width,
    required this.height,
    this.image,
    required this.textColor, this.child
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
          Image.asset(image, height: 25, width: 25,),
          Padding(padding: EdgeInsets.only(left: 20)),
          Text(widget.text, style: TextStyle(color: textColor))
        ],
      );
    }
    else
      addImageButton = Text(widget.text, style: TextStyle(color: textColor));
  }



  @override
  Widget build(BuildContext context) {
    addImageButtonControl(widget.image, widget.textColor);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.grey,
        elevation: 5.0,
        color: widget.color,
        child: MaterialButton(
          minWidth: widget.Width,
          height: widget.height,
          onPressed: widget.onPressedOperations,
          child: addImageButton,
        ),
      ),
    );
  }
}

