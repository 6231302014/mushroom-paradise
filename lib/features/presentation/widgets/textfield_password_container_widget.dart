import 'package:flutter/material.dart';
import 'package:paradise_chat/features/presentation/widgets/theme/style.dart';

class TextFieldPasswordContainerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final String? hintText;

  const TextFieldPasswordContainerWidget(
      {Key? key,
      this.hintText,
      this.suffixIcon,
      this.controller,
      this.prefixIcon,
      this.keyboardType})
      : super(key: key);

  @override
  State<TextFieldPasswordContainerWidget> createState() =>
      _TextFieldPasswordContainerWidgetState();
}

class _TextFieldPasswordContainerWidgetState
    extends State<TextFieldPasswordContainerWidget> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color747480.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        obscureText: true,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
          prefixIcon: Icon(widget.prefixIcon),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                isObscureText = !isObscureText;
              });
            },
            child: Icon(widget.suffixIcon),
          ),
        ),
      ),
    );
  }
}
