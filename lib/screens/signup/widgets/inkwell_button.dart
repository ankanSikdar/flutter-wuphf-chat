import 'package:flutter/material.dart';

class InkWellButton extends StatelessWidget {
  final Function onTap;
  final Color buttonColor;
  final String title;
  final Color titleColor;

  const InkWellButton({
    Key key,
    @required this.onTap,
    @required this.buttonColor,
    @required this.title,
    @required this.titleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: buttonColor,
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6.apply(
                  color: titleColor,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
