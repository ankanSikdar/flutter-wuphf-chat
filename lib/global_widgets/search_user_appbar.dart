import 'package:flutter/material.dart';
import 'package:wuphf_chat/config/configs.dart';

class SearchUserAppBar extends StatelessWidget {
  final String title;
  final TextEditingController textEditingController;
  final bool suffixActive;
  final Function search;
  final Function stopSearch;

  const SearchUserAppBar({
    Key key,
    @required this.title,
    @required this.textEditingController,
    @required this.suffixActive,
    @required this.search,
    @required this.stopSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300.0,
      collapsedHeight: 120.0,
      floating: false,
      pinned: true,
      backgroundColor: Colors.white,
      stretch: true,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.all(16.0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.left,
            ),
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                fillColor: Colors.grey[200],
                filled: true,
                hintText: 'Search for users...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ThemeConfig.borderRadius),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 4.0,
                ),
                errorStyle: Theme.of(context).textTheme.bodyText1.apply(
                      color: Theme.of(context).errorColor,
                    ),
                suffixIcon: suffixActive
                    ? IconButton(
                        icon: Icon(Icons.close),
                        onPressed: stopSearch,
                      )
                    : null,
              ),
              style: Theme.of(context).textTheme.bodyText1,
              onChanged: search,
              textInputAction: TextInputAction.search,
            ),
          ],
        ),
      ),
    );
  }
}
