import 'package:bvvm/src/view_model.dart';
import 'package:bvvm/src/bloc.dart';
import 'package:flutter/widgets.dart';

class BVVMProvider< W extends Widget > extends InheritedWidget {

  final Bloc< W > bloc;
  final W view;
  final ViewModel< W > viewModel;

  const BVVMProvider( {
    required this.bloc,
    required this.view,
    required this.viewModel,
    super.key,
  } ): super(
    child: view,
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}