import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/screens/app_details/bloc/appdetails_bloc.dart';
import 'package:wuphf_chat/screens/view_profile/widgets/profile_picture.dart';

class AppDetailsScreen extends StatelessWidget {
  static const String routeName = '/app-details-screen';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => BlocProvider<AppDetailsBloc>(
        create: (context) => AppDetailsBloc(),
        child: AppDetailsScreen(),
      ),
    );
  }

  const AppDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDetailsBloc, AppDetailsState>(
      builder: (context, state) {
        if (state.status == AppDetailsStatus.loaded) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                TwoTextAppBar(
                    title: 'App Details',
                    subtitle: 'Version: ${state.version}'),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfilePictureWidget(
                          imageUrl:
                              'https://firebasestorage.googleapis.com/v0/b/wuphf-chat-flutter.appspot.com/o/images%2Ficon%2Fapp_icon.png?alt=media&token=447b203c-6c1c-4971-86b2-b6d4329ce563',
                          isClipped: false,
                        ),
                        SizedBox(height: 32.0),
                        Text('${state.appName}',
                            style: Theme.of(context).textTheme.headline4),
                        Text(
                          '${state.packageName}',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (state.status == AppDetailsStatus.error) {
          return Center(
            child: Text('Something went wrong!'),
          );
        }
        return LoadingIndicator();
      },
    );
  }
}
