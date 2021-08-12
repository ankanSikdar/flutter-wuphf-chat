import 'package:flutter/material.dart';

import 'input_text_field.dart';
import 'input_title.dart';

class DisplayNameWidget extends StatelessWidget {
  final String initialValue;
  final Function onChanged;

  const DisplayNameWidget({
    Key key,
    @required this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(title: 'Display Name'),
        InputTextField(
          hintText: 'Your Name',
          textInputType: TextInputType.name,
          initialValue: initialValue,
          onChanged: onChanged,
          validator: (String value) {
            if (value.trim().isEmpty) {
              return 'Name cannot be empty';
            }
            if (!RegExp(r"^[a-zA-Z][a-zA-Z ]+").hasMatch(value)) {
              return 'Please enter a valid full name';
            }
            if (value.trim().length < 3) {
              return 'Name must be at least 3 characters';
            }
            return null;
          },
        ),
      ],
    );
  }
}
