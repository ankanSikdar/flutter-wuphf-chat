import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/screens/signup/cubit/signup_cubit.dart';

import 'package:wuphf_chat/global_widgets/global_widgets.dart';

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
          onChanged: context.read<SignUpCubit>().passwordChanged,
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
