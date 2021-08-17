import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/config/configs.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton.icon(
        onPressed: () {
          context.read<AuthBloc>().add(AuthUserLogOut());
        },
        icon: FaIcon(
          FontAwesomeIcons.signOutAlt,
          color: Colors.black,
        ),
        label: Text(
          'Sign Out',
          style: TextStyle(color: Colors.black),
        ),
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(
            Size(MediaQuery.of(context).size.width * 0.8, 50.0),
          ),
          elevation: MaterialStateProperty.all<double>(4.0),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.all(16.0),
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(ThemeConfig.borderRadius),
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[200]),
        ),
      ),
    );
  }
}
