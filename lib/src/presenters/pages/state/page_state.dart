import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class PageState<S extends StatefulWidget, C extends Cubit> extends State<S> {
  C get controller => Modular.get<C>();
}
