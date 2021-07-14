import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final String name;
  final Color color;

  const SettingsWidget({
    Key key,
    @required this.onTap,
    @required this.icon,
    @required this.name,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: color,
      child: Container(
        padding: EdgeInsets.all(4.0),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              child: Icon(icon, size: 32),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.navigate_next),
          ],
        ),
      ),
    );
  }
}
