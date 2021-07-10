import 'package:flutter/material.dart';
import 'package:wuphf_chat/screens/signup/widgets/inkwell_button.dart';
import 'package:wuphf_chat/screens/signup/widgets/input_text_field.dart';
import 'package:wuphf_chat/screens/signup/widgets/input_title.dart';

enum UserAction {
  signUp,
  login,
}

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup-screen';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => SignUpScreen(),
    );
  }

  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  UserAction _userAction = UserAction.signUp;
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
                _userAction == UserAction.signUp ? 'Sign up' : 'Sign In',
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
                    if (_userAction == UserAction.signUp) DisplayNameWidget(),
                    if (_userAction == UserAction.signUp)
                      SizedBox(height: 16.0),
                    PasswordWidget(),
                    SizedBox(height: 32.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _userAction == UserAction.signUp
                            ? InkWellButton(
                                onTap: () {
                                  print(_formKey.currentState.validate());
                                },
                                buttonColor: Theme.of(context).primaryColor,
                                title: 'Create Account',
                                titleColor: Colors.white,
                              )
                            : InkWellButton(
                                onTap: () {
                                  print(_formKey.currentState.validate());
                                },
                                buttonColor: Theme.of(context).primaryColor,
                                title: 'Sign In',
                                titleColor: Colors.white,
                              ),
                        _userAction == UserAction.signUp
                            ? InkWellButton(
                                onTap: () {
                                  setState(() {
                                    _userAction = UserAction.login;
                                  });
                                },
                                buttonColor: Colors.grey,
                                title: 'Sign In?',
                                titleColor: Colors.white,
                              )
                            : InkWellButton(
                                onTap: () {
                                  setState(() {
                                    _userAction = UserAction.signUp;
                                  });
                                },
                                buttonColor: Colors.grey,
                                title: 'Sign Up?',
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
          onChanged: (String value) {},
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

class DisplayNameWidget extends StatelessWidget {
  const DisplayNameWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(title: 'Display Name'),
        InputTextField(
          hintText: 'Your Name',
          textInputType: TextInputType.name,
          onChanged: (String value) {},
          validator: (String value) {
            if (value.trim().isEmpty) {
              return 'Name cannot be empty';
            }
            if (!RegExp(r"^[a-zA-Z][a-zA-Z ]+").hasMatch(value)) {
              return 'Please enter a valid full name';
            }
            if (value.trim().length < 3) {
              return 'Name must be atleast 3 characters';
            }
            return null;
          },
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
          hintText: '5+ characters',
          textInputType: TextInputType.visiblePassword,
          obscureText: true,
          onChanged: (String value) {},
          validator: (String value) {
            if (value.trim().isEmpty) {
              return 'Password cannot be empty';
            }
            if (value.trim().length < 6) {
              return 'Password must be atleast 5+ characters';
            }
            return null;
          },
        ),
      ],
    );
  }
}
