import 'package:flutter/material.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';

class AboutWidget extends StatelessWidget {
  final String initialValue;
  final Function onChanged;

  const AboutWidget({
    Key key,
    @required this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(title: 'About'),
        TextFormField(
          decoration: InputDecoration(
            fillColor: Colors.grey[200],
            filled: true,
            hintText: 'Write something about yourself',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.all(12.0),
            errorStyle: Theme.of(context).textTheme.bodyText2.apply(
                  color: Theme.of(context).errorColor,
                ),
          ),
          initialValue: initialValue,
          minLines: 1,
          maxLines: 4,
          style: Theme.of(context).textTheme.bodyText1,
          keyboardType: TextInputType.multiline,
          onChanged: onChanged,
          validator: (String value) {
            if (value.trim().length == 0) {
              return 'Remove whitespace';
            }
            return null;
          },
        ),
      ],
    );
  }
}
