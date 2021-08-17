import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wuphf_chat/global_widgets/global_widgets.dart';
import 'package:wuphf_chat/global_widgets/two_text_app_bar.dart';
import 'package:wuphf_chat/screens/dev_details/widgets/devlink.dart';
import 'package:wuphf_chat/screens/view_profile/widgets/profile_picture.dart';

class DevDetailsScreen extends StatelessWidget {
  static const routeName = '/dev-details-screen';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => DevDetailsScreen(),
    );
  }

  const DevDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          TwoTextAppBar(
            title: 'Developer Details',
            subtitle: 'Made with ♥ using Flutter',
          ),
          SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfilePictureWidget(
                    imageUrl:
                        'https://firebasestorage.googleapis.com/v0/b/wuphf-chat-flutter.appspot.com/o/images%2Ficon%2Fankan.jpeg?alt=media&token=469db95c-52b2-4be0-a5d7-4382cf713c33',
                  ),
                  SizedBox(height: 16.0),
                  Text('Ankan Sikdar',
                      style: Theme.of(context).textTheme.headline4),
                  SizedBox(height: 16.0),
                  Container(
                    width: double.infinity,
                    child: InputTitle(title: 'About Me'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      'Hello There! First of all I am very grateful to you for using my app.\nA little about myself... I was born in 1999 and I am an Engineer in Information Technology (2021 Batch) from Heritage Institute of Technology, Kolkata.',
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      InputTitle(title: 'My Links'),
                    ],
                  ),
                  DevLink(
                    icon: FontAwesomeIcons.github,
                    label: 'Github Account',
                    onPressed: () {},
                  ),
                  DevLink(
                    icon: FontAwesomeIcons.linkedin,
                    label: 'LinkedIn Account',
                    onPressed: () {},
                  ),
                  DevLink(
                    icon: FontAwesomeIcons.facebook,
                    label: 'Facebook Account',
                    onPressed: () {},
                  ),
                  DevLink(
                    icon: FontAwesomeIcons.twitter,
                    label: 'Twitter Account',
                    onPressed: () {},
                  ),
                  DevLink(
                    icon: FontAwesomeIcons.instagram,
                    label: 'Instagram Account',
                    onPressed: () {},
                  ),
                  DevLink(
                    icon: FontAwesomeIcons.solidEnvelope,
                    label: 'Send Email',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
