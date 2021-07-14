import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Colors.deepOrange[100],
      child: Container(
        padding: EdgeInsets.all(4.0),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.edit, size: 32),
              decoration: BoxDecoration(
                color: Colors.deepOrange[100],
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                'Edit Profile',
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
