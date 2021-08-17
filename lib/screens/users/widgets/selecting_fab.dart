import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wuphf_chat/config/configs.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';

class SelectingFAB extends StatelessWidget {
  final Function onCreate;
  final Function onCancel;
  const SelectingFAB({
    Key key,
    @required this.onCreate,
    @required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomElevatedButton(
          icon: FontAwesomeIcons.folderPlus,
          onTap: onCreate,
          buttonColor: Colors.white,
          title: 'Create a Group',
          titleColor: Theme.of(context).primaryColor,
        ),
        CustomElevatedButton(
          icon: FontAwesomeIcons.times,
          onTap: onCancel,
          buttonColor: Colors.white,
          title: 'Cancel',
          titleColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
