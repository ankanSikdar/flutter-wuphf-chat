import 'package:flutter/material.dart';

import 'input_text_field.dart';
import 'input_title.dart';

class EmailWidget extends StatelessWidget {
  final String initialValue;
  final Function onChanged;

  const EmailWidget({
    Key key,
    @required this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(title: 'Email'),
        InputTextField(
          hintText: 'you@example.com',
          textInputType: TextInputType.emailAddress,
          initialValue: initialValue,
          onChanged: onChanged,
          validator: (String value) {
            if (value.trim().isEmpty) {
              return "Email cannot be empty";
            }
            if (!RegExp(
                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                .hasMatch(value)) {
              return "Please Enter a valid email";
            }
            return null;
          },
        ),
      ],
    );
  }
}
