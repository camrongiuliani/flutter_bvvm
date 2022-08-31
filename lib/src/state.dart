import 'package:bvvm/src/view_model.dart';
import 'package:bvvm/src/bloc.dart';
import 'package:flutter/widgets.dart';

abstract class BVVMState<W extends StatefulWidget> extends State<W> {

  Bloc<W> get bloc => Bloc.of( context, listen: false );
  ViewModel<W> get viewModel => ViewModel.of( context, listen: false );

  @override
  void initState() {
    bloc.init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Bloc.of( context, listen: true ).init();
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    bloc.dispose();
    viewModel.dispose();
    super.deactivate();
  }
}