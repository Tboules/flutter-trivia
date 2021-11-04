import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool navigate;
  const CustAppBar({Key? key, required this.title, this.navigate = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1024) {
          return AppBar(
            title: Text(title),
            automaticallyImplyLeading: navigate,
          );
        } else {
          return AppBar(
            title: Text(title),
            automaticallyImplyLeading: navigate,
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
                child: GestureDetector(
                  child: const Icon(
                    FontAwesomeIcons.user,
                    color: Colors.white70,
                  ),
                ),
              )
            ],
          );
        }
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
