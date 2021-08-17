import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 16.0),
        child: CustomElevatedButton(
          onTap: () {
            context.read<AuthBloc>().add(AuthUserLogOut());
          },
          icon: FontAwesomeIcons.signOutAlt,
          title: 'Sign Out',
          titleColor: Colors.grey[600],
          buttonColor: Colors.white,
          size: Size(MediaQuery.of(context).size.width * 0.8, 50.0),
        ));
  }
}
