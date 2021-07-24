import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wuphf_chat/config/configs.dart';
import 'package:wuphf_chat/screens/screens.dart';
import 'package:wuphf_chat/helper/time_helper.dart';

import 'bloc/liveuser_bloc.dart';

class ChattingAppBar extends StatelessWidget {
  const ChattingAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveUserBloc, LiveUserState>(
      builder: (context, state) {
        if (state.status == LiveUserStatus.loaded) {
          final user = state.user;
          return SliverAppBar(
            elevation: 2.0,
            shadowColor: Colors.grey[500],
            backgroundColor: Colors.white,
            toolbarHeight: 100,
            floating: true,
            pinned: true,
            forceElevated: true,
            automaticallyImplyLeading: false,
            leadingWidth: 35.0,
            titleSpacing: 0.0,
            title: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  ViewProfileScreen.routeName,
                  arguments: ViewProfileScreenArgs(user: user),
                );
              },
              child: Container(
                child: Row(
                  children: [
                    SizedBox(width: 8.0),
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ThemeConfig.smallDpRadius),
                        color: Colors.grey[200],
                      ),
                      padding: EdgeInsets.all(3.0),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(ThemeConfig.smallDpRadius),
                        child: CachedNetworkImage(
                          imageUrl: user.profileImageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Container(color: Colors.grey),
                          errorWidget: (context, url, error) =>
                              Container(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.displayName,
                            style: Theme.of(context).textTheme.headline5,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8.0),
                          user.presence
                              ? Row(
                                  children: [
                                    Icon(Icons.circle,
                                        size: 15, color: Colors.green),
                                    SizedBox(width: 2.0),
                                    Text(
                                      'Online',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(color: Colors.green),
                                    ),
                                  ],
                                )
                              : Text(
                                  user.lastSeen.forLastSeen(),
                                  style: Theme.of(context).textTheme.subtitle1,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.navigate_before,
              ),
            ),
          );
        }
        return SliverAppBar(
          elevation: 2.0,
          shadowColor: Colors.grey[500],
          backgroundColor: Colors.white,
          toolbarHeight: 100,
          floating: true,
          pinned: true,
          forceElevated: true,
          automaticallyImplyLeading: false,
          leadingWidth: 35.0,
          titleSpacing: 0.0,
          title: Text(state.status == LiveUserStatus.error
              ? '${state.error}'
              : 'Loading...'),
        );
      },
    );
  }
}
