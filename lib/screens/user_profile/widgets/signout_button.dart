import 'package:flutter/material.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/config/configs.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AuthBloc>().add(AuthUserLogOut());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ThemeConfig.borderRadius),
          color: Colors.grey[200],
        ),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.exit_to_app),
              SizedBox(width: 8.0),
              Text('Sign Out'),
            ],
          ),
        ),
      ),
    );
  }
}
