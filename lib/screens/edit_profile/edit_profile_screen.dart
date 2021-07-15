import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';
import 'package:wuphf_chat/screens/edit_profile/cubit/editprofile_cubit.dart';

class EditProfileArgs {
  final User user;

  EditProfileArgs({@required this.user});
}

class EditProfileScreen extends StatelessWidget {
  static const String routeName = '/edit-profile-screen';

  static Route route({@required EditProfileArgs args}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => BlocProvider<EditProfileCubit>(
        create: (context) => EditProfileCubit(
          user: args.user,
          authRepository: context.read<AuthRepository>(),
          userRepository: context.read<UserRepository>(),
        ),
        child: EditProfileScreen(),
      ),
    );
  }

  const EditProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state.status == EditProfileStatus.error) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text('${state.error}')),
              );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [Text(state.email)],
              ),
            ),
          );
        },
      ),
    );
  }
}
