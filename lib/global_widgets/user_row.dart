import 'package:flutter/material.dart';
import 'profile_picture.dart';

class UserRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String imageUrl;
  final Function onChat;
  final Function onView;
  final bool isOnline;

  const UserRow({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.imageUrl,
    this.isOnline,
    this.onChat,
    this.onView,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onView,
                child: Stack(
                  children: [
                    ProfilePicture(imageUrl: imageUrl),
                    if (isOnline != null)
                      Positioned(
                        bottom: 3,
                        right: 3,
                        child: Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                              color: isOnline ? Colors.green : Colors.grey,
                              borderRadius: BorderRadius.circular(9),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(1, 1),
                                  color: Colors.grey,
                                )
                              ]),
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: InkWell(
                  onTap: onChat,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: Theme.of(context).textTheme.headline6,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (date != null)
                            Text(
                              date,
                              style: Theme.of(context).textTheme.overline,
                            ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.subtitle2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
