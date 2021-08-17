import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/screens/app_details/bloc/appdetails_bloc.dart';
import 'package:wuphf_chat/screens/dev_details/widgets/devlink.dart';
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

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      print('Could not launch $url');
    }
  }

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
                        SizedBox(height: 16.0),
                        Text(
                          'Made with ❤ using Flutter',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(height: 16.0),
                        DevLink(
                            onPressed: () {
                              _launchUrl(
                                  'https://github.com/ankanSikdar/flutter-wuphf-chat');
                            },
                            icon: FontAwesomeIcons.github,
                            label: 'Check Source Code'),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            InputTitle(title: 'Wuphf Meaning?'),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            'Any Office (American Sitcom) Fans? You must have already figured it out.\nFor the rest, \'Wuphf\' (pronounced \'woof\') is the name of the website developed by a character in the show as a revolutionary communication tool. Instead of getting a text or call, or message, the service purportedly sends a message to friends on all their channels, facebook, sms and twitter.  It even prints out a \'Wuphf\' on the nearest printer. So while watching that episode I thought of creating a chat app named Wuphf one day',
                            style: Theme.of(context).textTheme.subtitle1,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            InputTitle(title: 'Disclaimer'),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            'Please don\'t consider using the app as your primary chatting app. This app is purely made for learning purposes. Please treat it as so.',
                            style: Theme.of(context).textTheme.subtitle1,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 32.0),
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
