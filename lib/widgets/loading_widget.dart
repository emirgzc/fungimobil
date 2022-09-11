import 'package:flutter/material.dart';

import '../constants/style.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.4),
      child: const Center(
        child: CircularProgressIndicator(
          color: Style.secondaryColor,
        ),
      ),
    );
  }
}
