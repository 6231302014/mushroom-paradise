import 'package:flutter/material.dart';
import 'package:paradise_chat/features/presentation/widgets/theme/style.dart';

class RowTextWidget extends StatelessWidget {
  final String? title1;
  final String? title2;
  final VoidCallback? onTap;
  final MainAxisAlignment? mainAxisAlignment;

  const RowTextWidget({Key? key,this.mainAxisAlignment, this.onTap, this.title1, this.title2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return rowTextWidget();
  }

  Widget rowTextWidget() {
    return Row(
      mainAxisAlignment: mainAxisAlignment == null? MainAxisAlignment.start: mainAxisAlignment!,
      children: [
        Text("$title1"),
        InkWell(
          onTap: onTap,
          child: Text(
            '$title2',
            style: TextStyle(
              color: greenColor,
            ),
          ),
        )
      ],
    );
  }
}
