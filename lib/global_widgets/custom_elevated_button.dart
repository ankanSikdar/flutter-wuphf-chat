import 'package:flutter/material.dart';
import 'package:wuphf_chat/config/configs.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function onTap;
  final Color buttonColor;
  final String title;
  final Color titleColor;

  const CustomElevatedButton({
    Key key,
    @required this.onTap,
    @required this.buttonColor,
    @required this.title,
    @required this.titleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          title,
          style: TextStyle(color: titleColor),
        ),
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(
            Size(MediaQuery.of(context).size.width * 0.35, 50.0),
          ),
          elevation: MaterialStateProperty.all<double>(4.0),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(ThemeConfig.borderRadius),
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
        ),
      ),
    );
  }
}