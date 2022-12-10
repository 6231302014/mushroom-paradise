import 'package:flutter/material.dart';
import 'package:paradise_chat/features/presentation/widgets/theme/style.dart';

class ContainerButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const ContainerButtonWidget({Key? key,required this.title,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: greenColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          '$title',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
