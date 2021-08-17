import 'package:flutter/material.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';

class DevLink extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final String label;

  const DevLink({
    Key key,
    @required this.onPressed,
    @required this.icon,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomElevatedButton(
        icon: icon,
        buttonColor: Colors.white,
        titleColor: Theme.of(context).primaryColor,
        title: label,
        onTap: onPressed,
        size: Size(MediaQuery.of(context).size.width * 0.6, 50.0),
      ),
    );
  }
}
