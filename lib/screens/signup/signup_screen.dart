import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wuphf_chat/screens/signup/widgets/inkwell_button.dart';

import 'package:wuphf_chat/screens/signup/widgets/input_text_field.dart';
import 'package:wuphf_chat/screens/signup/widgets/input_title.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = 'signup-screen';

  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(
                  24.0, MediaQuery.of(context).size.height * 0.1, 0.0, 32.0),
              child: Text(
                'Sign up',
                style: Theme.of(context).textTheme.headline3.apply(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Column(
                  children: [
                    EmailWidget(),
                    SizedBox(height: 16.0),
                    UsernameWidget(),
                    SizedBox(height: 16.0),
                    PasswordWidget(),
                    SizedBox(height: 32.0),
                    Row(
                      children: [
                        InkWellButton(
                          onTap: () {},
                          buttonColor: Theme.of(context).primaryColor,
                          title: 'Create Account',
                          titleColor: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EmailWidget extends StatelessWidget {
  const EmailWidget({
    Key key,
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
        ),
      ],
    );
  }
}

class UsernameWidget extends StatelessWidget {
  const UsernameWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(title: 'Username'),
        InputTextField(
          hintText: 'something unique',
          textInputType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(title: 'Password'),
        InputTextField(
          hintText: '8+ characters',
          textInputType: TextInputType.emailAddress,
          obscureText: true,
        ),
      ],
    );
  }
}
