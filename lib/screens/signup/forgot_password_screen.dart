import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/global_widgets/email_widget.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

import 'cubit/signup_cubit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgot-password-screen';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => BlocProvider<SignUpCubit>(
        create: (context) => SignUpCubit(
          authRepository: context.read<AuthRepository>(),
        ),
        child: ForgotPasswordScreen(),
      ),
    );
  }

  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  void _reset() {
    _formKey.currentState.reset();
    context.read<SignUpCubit>().reset();
  }

  void _onSubmit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('Checking...')),
      );

    await context.read<SignUpCubit>().sendPasswordResetMail();

    if (context.read<SignUpCubit>().state.status != SignUpStatus.error) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text('Check your mail to reset password')),
        );
      _reset();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status == SignUpStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('${state.error}')),
            );
          _reset();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0,
                        MediaQuery.of(context).size.height * 0.1, 0.0, 32.0),
                    child: Text(
                      'Send Mail',
                      style: Theme.of(context).textTheme.headline3.apply(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                  EmailWidget(
                    onChanged: context.read<SignUpCubit>().emailChanged,
                  ),
                  SizedBox(height: 32.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWellButton(
                        onTap: _onSubmit,
                        buttonColor: Theme.of(context).primaryColor,
                        title: 'Send Code',
                        titleColor: Colors.white,
                      ),
                      InkWellButton(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        buttonColor: Colors.grey,
                        title: 'Go Back',
                        titleColor: Colors.white,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
