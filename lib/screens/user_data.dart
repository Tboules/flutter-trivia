import 'package:flutter/material.dart';

class UserData extends StatelessWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool bigScreen = width > 1024;

    return Container(
      margin: EdgeInsets.all(bigScreen ? 10 : 0),
      decoration: BoxDecoration(
        color: bigScreen ? Colors.grey[800] : null,
        borderRadius: BorderRadius.circular(bigScreen ? 4 : 0),
      ),
      child: const Center(
        child: Text(
          'user data',
        ),
      ),
    );
  }
}
