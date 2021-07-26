import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';

class SignInButton extends StatefulWidget {
  final bool enabled;
  final String caption;
  final VoidCallback widgetCallback;

  const SignInButton({
    Key? key,
    this.enabled = true,
    required this.caption,
    required this.widgetCallback,
  }) : super(key: key);

  @override
  _SignInButton createState() => _SignInButton();
}

class _SignInButton extends ObservingStatefulWidget<SignInButton> {
  final ButtonStyle _style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _style,
      onPressed: widget.enabled ? () => widget.widgetCallback() : null,
      child: Text(widget.caption),
    );
  }
}
