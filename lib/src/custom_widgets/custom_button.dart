import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  CustomButton(
      {super.key,
      required this.heightPercent,
      required this.widthPercent,
      required this.action,
      required this.textButton,
      this.borderColor = Colors.black12,
      this.height,
      this.width});
  final double widthPercent;
  final double heightPercent;
  Function()? action;
  String textButton;
  Color borderColor;
  double? height;
  double? width;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(5)),
      width: widget.width ?? size.width * widget.widthPercent,
      height: widget.height ?? size.height * widget.heightPercent,
      child: Material(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        child: InkWell(
          onTap: widget.action ?? () {},
          child: Center(child: Text(widget.textButton)),
        ),
      ),
    );
  }
}
