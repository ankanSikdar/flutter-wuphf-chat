import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';
import 'package:wuphf_chat/screens/edit_profile/cubit/editprofile_cubit.dart';
import 'package:wuphf_chat/screens/edit_profile/widgets/widgets.dart';

class EditProfileArgs {
  final User user;

  EditProfileArgs({@required this.user});
}

class EditProfileScreen extends StatefulWidget {
  static const String routeName = '/edit-profile-screen';

  static Route route({@required EditProfileArgs args}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => BlocProvider<EditProfileCubit>(
        create: (context) => EditProfileCubit(
          user: args.user,
          authRepository: context.read<AuthRepository>(),
          userRepository: context.read<UserRepository>(),
          storageRepository: context.read<StorageRepository>(),
        ),
        child: EditProfileScreen(),
      ),
    );
  }

  const EditProfileScreen({Key key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formkey = GlobalKey<FormState>();

  void _submitForm() {
    if (context.read<EditProfileCubit>().state.status ==
        EditProfileStatus.submitting) {
      return;
    }
    if (!_formkey.currentState.validate()) {
      return;
    }
    context.read<EditProfileCubit>().submitForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TwoTextAppBar(
              title: 'Edit Profile', subtitle: 'Edit your details here'),
          BlocConsumer<EditProfileCubit, EditProfileState>(
            listener: (context, state) {
              if (state.status == EditProfileStatus.error) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text('${state.error}')),
                  );
                context.read<EditProfileCubit>().reset();
              }
              if (state.status == EditProfileStatus.submitting) {
                _formkey.currentState.deactivate();
              }
              if (state.status == EditProfileStatus.success) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text('Profile Updated')),
                  );
              }
            },
            builder: (context, state) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ChangeProfilePicture(
                          imageUrl: state.profileImageUrl,
                          onChanged: (File file) {
                            context
                                .read<EditProfileCubit>()
                                .profileImageChanged(file);
                          },
                        ),
                        SizedBox(height: 24.0),
                        EmailWidget(
                          initialValue: state.email,
                          onChanged:
                              context.read<EditProfileCubit>().emailChanged,
                        ),
                        SizedBox(height: 16.0),
                        DisplayNameWidget(
                          initialValue: state.displayName,
                          onChanged: context
                              .read<EditProfileCubit>()
                              .displayNameChanged,
                        ),
                        SizedBox(height: 16.0),
                        AboutWidget(
                          initialValue: state.bio,
                          onChanged:
                              context.read<EditProfileCubit>().bioChanged,
                        ),
                        SizedBox(height: 16.0),
                        CustomElevatedButton(
                          onTap: state.status == EditProfileStatus.submitting
                              ? null
                              : () {
                                  _submitForm();
                                },
                          titleColor: Theme.of(context).primaryColor,
                          title: state.status == EditProfileStatus.submitting
                              ? 'Submitting...'
                              : 'Submit',
                          buttonColor: Colors.white,
                          icon: FontAwesomeIcons.save,
                          size: Size(
                              MediaQuery.of(context).size.width * 0.8, 50.0),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
