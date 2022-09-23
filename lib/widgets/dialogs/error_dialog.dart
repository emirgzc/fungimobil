import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/style.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key? key, required this.title, required this.content, required this.onDismiss}) : super(key: key);

  final String title;
  final String content;
  final void Function(BuildContext) onDismiss;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Style.dangerColor,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(Style.defaultPadding * 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 0.1.sh,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: Style.defaultPadding,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Style.defaultPadding,
              vertical: Style.defaultPadding * 2,
            ),
            child: Column(
              children: [
                Text(
                  content,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: Style.defaultPadding,
                ),
                ElevatedButton(
                  child: const Text('Tamam'),
                  onPressed: () {
                    //  close dialog
                    Navigator.pop(context);
                    // onDismiss(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
