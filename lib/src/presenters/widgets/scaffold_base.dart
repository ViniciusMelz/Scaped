import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scaped/src/config/router/app_router.dart';

import 'logo.dart';

base class ScaffoldBase extends StatefulWidget {
  final Widget body;
  final List<Widget> drawer;
  const ScaffoldBase({
    required this.body,
    this.drawer = const [],
    super.key,
  });

  @override
  State<ScaffoldBase> createState() => _ScaffoldBaseState();
}

class _ScaffoldBaseState extends State<ScaffoldBase> {
  AppBar _getAppBar() {
    return AppBar(
      title: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.05,
        child: const Logo(),
      ),
      actions: [
        IconButton(
          onPressed: () => Modular.to.pushNamed(appRouter.userRoute),
          icon: const Icon(Icons.person),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.drawer.isEmpty) {
      return Scaffold(
        appBar: _getAppBar(),
        body: widget.body,
      );
    } else {
      return Scaffold(
        appBar: _getAppBar(),
        drawer: Drawer(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: widget.drawer,
              ),
            ),
          ),
        ),
        body: widget.body,
      );
    }
  }
}
