import 'package:flutter/material.dart';
import 'package:wuphf_chat/config/configs.dart';

class InputTextField extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  final bool obscureText;
  final Function onChanged;
  final Function validator;
  final String initialValue;

  const InputTextField({
    Key key,
    @required this.hintText,
    @required this.textInputType,
    @required this.onChanged,
    @required this.validator,
    this.initialValue,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.grey[200],
        filled: true,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConfig.borderRadius),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 4.0,
        ),
        errorStyle: Theme.of(context).textTheme.bodyText1.apply(
              color: Theme.of(context).errorColor,
            ),
      ),
      initialValue: initialValue,
      style: Theme.of(context).textTheme.bodyText2,
      keyboardType: textInputType,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
