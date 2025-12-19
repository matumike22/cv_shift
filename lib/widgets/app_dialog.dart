import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'liquid_container.dart';

class AppDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final String? buttonText1;
  final String? buttonText2;
  final Color? textColor;

  final void Function()? action1, action2;

  const AppDialog({
    super.key,
    this.title,
    this.content,
    this.buttonText1,
    this.buttonText2,
    this.action1,
    this.textColor,
    this.action2,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: LiquidContainer(
        height: 200,
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (title != null)
              Text(
                title!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor ?? Colors.white,
                ),
              ),
            if (title != null) const SizedBox(height: 10),
            if (content != null)
              Text(
                content!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: _buildButtons(context),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildButtons(BuildContext context) {
    final buttons = <Widget>[];

    if (buttonText1 != null) {
      buttons.add(
        TextButton(
          onPressed: action1 ?? () => Navigator.of(context).pop(true),
          child: Text(buttonText1!), // Return 'true' on press
        ),
      );
    }

    if (buttonText2 != null) {
      buttons.add(
        TextButton(
          onPressed: action2 ?? () => Navigator.of(context).pop(false),
          child: Text(buttonText2!), // Return 'false' on press
        ),
      );
    }

    return buttons;
  }
}

void showLoadingDialog(BuildContext context, String? message, {Key? key}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Material(
        color: Colors.transparent,
        child: LiquidContainer(
          height: 200,
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingAnimationWidget.beat(
                color: Colors.purple.shade100,
                size: 50,
              ),
              if (message != null) ...[
                const SizedBox(height: 20),
                Text(message, style: const TextStyle(fontSize: 16)),
              ],
            ],
          ),
        ),
      );
    },
  );
}

Future<void> showConfirmationDialog(
  BuildContext context,
  String content, {
  String? title,
  String buttonText1 = 'Yes',
  String buttonText2 = 'No',
  void Function()? action1,
  void Function()? action2,
}) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AppDialog(
      title: title,
      content: content,
      buttonText1: buttonText1,
      buttonText2: buttonText2,
      action1: action1,
      action2: action2,
    ),
  );
}

void showErrorDialog(BuildContext context, String content) {
  showDialog(
    context: context,
    builder: (context) => AppDialog(
      title: 'Error',
      content: content,
      textColor: Colors.red,
      buttonText1: 'OK',
    ),
  );
}
