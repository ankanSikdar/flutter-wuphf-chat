import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  final bool obscureText;

  const InputTextField({
    Key key,
    @required this.hintText,
    @required this.textInputType,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.grey[200],
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 4.0,
        ),
      ),
      style: Theme.of(context).textTheme.bodyText1,
      keyboardType: textInputType,
      obscureText: obscureText,
    );
  }
}
