import 'package:flutter/material.dart';
import 'package:paradise_chat/features/presentation/widgets/theme/style.dart';

typedef TabClickListener = Function(int index);

class CustomTabBarNew extends StatefulWidget {
  final TabClickListener tabClickListener;
  final index;

  const CustomTabBarNew(
      {Key? key, this.index = 0, required this.tabClickListener})
      : super(key: key);

  @override
  _CustomTabBarNewState createState() => _CustomTabBarNewState();
}

class _CustomTabBarNewState extends State<CustomTabBarNew> {
  int _indexHolder = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(10, 207, 131, 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TabBarCustomButton(
              width: 50,
              text: "Mushroom Groups Chat",
              textColor: widget.index == 0 ? textIconColor : textIconColorGray,
              borderColor:
                  widget.index == 0 ? textIconColor : Colors.transparent,
              onTap: () {
                setState(() {
                  _indexHolder = 0;
                });
                widget.tabClickListener(_indexHolder);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TabBarCustomButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color borderColor;
  final double borderWidth;
  final Color textColor;
  final VoidCallback onTap;

  const TabBarCustomButton({
    Key? key,
    this.text = "",
    this.width = 50.0,
    this.height = 50.0,
    this.borderColor = Colors.white,
    this.borderWidth = 3.0,
    this.textColor = Colors.white,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: borderColor, width: borderWidth))),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: textColor),
        ),
      ),
    );
  }
}
