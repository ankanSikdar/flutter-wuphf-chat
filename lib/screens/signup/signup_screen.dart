import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final size = MediaQuery.of(context).size;
    return BlocConsumer<SignUpCubit, SignUpState>(
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
        if (state.status == SignUpStatus.success) {
          ScaffoldMessenger.of(context)..hideCurrentSnackBar();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      EdgeInsets.fromLTRB(24.0, size.height * 0.1, 0.0, 32.0),
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
                              style:
                                  Theme.of(context).textTheme.headline6.apply(
                                        color: Theme.of(context).primaryColor,
                                      ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                state.status == SignUpStatus.submitting ||
                        state.status == SignUpStatus.success
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CustomElevatedButton(
                            onTap: null,
                            titleColor: Colors.grey,
                            title: _userAction == UserAction.signUp
                                ? 'Creating Account'
                                : 'Signing In',
                            buttonColor: Colors.white,
                            icon: FontAwesomeIcons.spinner,
                            size: Size(size.width * 0.6, 50.0),
                          ),
                        ],
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _userAction == UserAction.signUp
                                ? CustomElevatedButton(
                                    onTap: submitForm,
                                    titleColor: Theme.of(context).primaryColor,
                                    title: size.width > 400
                                        ? 'Create Account'
                                        : 'Sign Up',
                                    buttonColor: Colors.white,
                                    icon: FontAwesomeIcons.userPlus,
                                  )
                                : CustomElevatedButton(
                                    onTap: submitForm,
                                    titleColor: Theme.of(context).primaryColor,
                                    title: 'Sign In',
                                    buttonColor: Colors.white,
                                    size: Size(size.width * 0.4, 50.0),
                                    icon: FontAwesomeIcons.signInAlt,
                                  ),
                            _userAction == UserAction.signUp
                                ? CustomElevatedButton(
                                    onTap: () {
                                      setState(() {
                                        _userAction = UserAction.login;
                                      });
                                    },
                                    titleColor: Colors.grey,
                                    title: 'Sign In?',
                                    buttonColor: Colors.white,
                                    icon: FontAwesomeIcons.signInAlt,
                                  )
                                : CustomElevatedButton(
                                    onTap: () {
                                      setState(() {
                                        _userAction = UserAction.signUp;
                                      });
                                    },
                                    titleColor: Colors.grey,
                                    title: 'Sign Up?',
                                    buttonColor: Colors.white,
                                    size: Size(size.width * 0.4, 50.0),
                                    icon: FontAwesomeIcons.userPlus,
                                  ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
