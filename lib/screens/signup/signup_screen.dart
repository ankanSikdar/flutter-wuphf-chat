import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/repositories/repositories.dart';
import 'package:wuphf_chat/screens/screens.dart';
import 'package:wuphf_chat/screens/signup/cubit/signup_cubit.dart';
import 'package:wuphf_chat/screens/signup/widgets/widgets.dart';

enum UserAction {
  signUp,
  login,
}

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup-screen';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => BlocProvider<SignUpCubit>(
        create: (context) => SignUpCubit(
          authRepository: context.read<AuthRepository>(),
        ),
        child: SignUpScreen(),
      ),
    );
  }

  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  UserAction _userAction = UserAction.signUp;
  final _formKey = GlobalKey<FormState>();

  void submitForm() {
    if (context.read<SignUpCubit>().state.status == SignUpStatus.submitting) {
      return;
    }
    if (!_formKey.currentState.validate()) {
      return;
    }
    if (_userAction == UserAction.signUp) {
      context.read<SignUpCubit>().singUpWithCredentials();
    } else if (_userAction == UserAction.login) {
      context.read<SignUpCubit>().loginWithCredentials();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state.status == SignUpStatus.error) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('${state.error}')),
                );
              context.read<SignUpCubit>().reset();
              _formKey.currentState.reset();
            }
            if (state.status == SignUpStatus.submitting) {
              _formKey.currentState.deactivate();
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text('Checking...'),
                  ),
                );
            }
            if (state.status == SignUpStatus.success) {
              ScaffoldMessenger.of(context)..hideCurrentSnackBar();
            }
          },
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EmailWidget(
                        onChanged: context.read<SignUpCubit>().emailChanged,
                      ),
                      SizedBox(height: 16.0),
                      if (_userAction == UserAction.signUp)
                        DisplayNameWidget(
                          onChanged:
                              context.read<SignUpCubit>().displayNameChanged,
                        ),
                      if (_userAction == UserAction.signUp)
                        SizedBox(height: 16.0),
                      PasswordWidget(),
                      SizedBox(height: 16.0),
                      if (_userAction == UserAction.login)
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(ForgotPasswordScreen.routeName);
                          },
                          child: Text(
                            'Forgot Password ?',
                            style: Theme.of(context).textTheme.headline6.apply(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ),
                      SizedBox(height: 32.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _userAction == UserAction.signUp
                              ? CustomElevatedButton(
                                  onTap: submitForm,
                                  buttonColor: Theme.of(context).primaryColor,
                                  title: 'Create Account',
                                  titleColor: Colors.white,
                                )
                              : CustomElevatedButton(
                                  onTap: submitForm,
                                  buttonColor: Theme.of(context).primaryColor,
                                  title: 'Sign In',
                                  titleColor: Colors.white,
                                  size: Size(
                                      MediaQuery.of(context).size.width * 0.4,
                                      50.0),
                                ),
                          _userAction == UserAction.signUp
                              ? CustomElevatedButton(
                                  onTap: () {
                                    setState(() {
                                      _userAction = UserAction.login;
                                    });
                                  },
                                  buttonColor: Colors.grey,
                                  title: 'Sign In?',
                                  titleColor: Colors.white,
                                )
                              : CustomElevatedButton(
                                  onTap: () {
                                    setState(() {
                                      _userAction = UserAction.signUp;
                                    });
                                  },
                                  buttonColor: Colors.grey,
                                  title: 'Sign Up?',
                                  titleColor: Colors.white,
                                  size: Size(
                                      MediaQuery.of(context).size.width * 0.4,
                                      50.0),
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
      ),
    );
  }
}
