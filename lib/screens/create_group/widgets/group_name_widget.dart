import 'package:flutter/material.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';

class GroupNameWidget extends StatelessWidget {
  final String initialValue;
  final Function onChanged;

  const GroupNameWidget({
    Key key,
    @required this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(title: 'Group Name'),
        InputTextField(
          hintText: 'Buddies',
          textInputType: TextInputType.name,
          initialValue: initialValue,
          onChanged: onChanged,
          validator: (String value) {
            if (value.trim().isEmpty) {
              return 'Group Name cannot be empty';
            }
            if (value.trim().length < 3) {
              return 'Group Name must be at least 3 characters';
            }
            return null;
          },
        ),
      ],
    );
  }
}
