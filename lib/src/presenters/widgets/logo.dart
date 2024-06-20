import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'logo',
      child: Visibility(
        visible: Theme.of(context).brightness == Brightness.light,
        replacement: Image.asset('lib/assets/logo_mono.png'),
        child: Image.asset('lib/assets/logo.png'),
      ),
    );
  }
}
