import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia_app/services/auth.dart';

class UserData extends StatelessWidget {
  UserData({Key? key}) : super(key: key);
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool bigScreen = width > 1024;

    return Container(
      margin: EdgeInsets.all(bigScreen ? 10 : 0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bigScreen ? Colors.grey[800] : null,
        borderRadius: BorderRadius.circular(bigScreen ? 4 : 0),
      ),
      child: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text(
                'user data',
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              primary: Colors.grey[width > 1024 ? 850 : 800],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
              ),
            ),
            onPressed: () {
              auth.signOut();
              Get.offAllNamed('/');
            },
            child: const Text(
              'Sign Out',
            ),
          )
        ],
      ),
    );
  }
}
