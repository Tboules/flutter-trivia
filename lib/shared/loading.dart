import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: CircularProgressIndicator(
          color: Colors.white70,
        ),
      ),
    );
  }
}
