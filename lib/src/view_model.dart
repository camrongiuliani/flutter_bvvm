

import 'package:bvvm/bvvm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class ViewModel<T extends Widget> extends Component {

  static V of<V extends ViewModel>( BuildContext context, { bool listen = false, bool searchDown = false } ) {
    return context.findAncestorViewModelOfType<V>( listen, searchDown );
  }

  static V? maybeOf<V extends ViewModel>( BuildContext? context, { bool listen = false, bool searchDown = false } ) {

    try {
      return of<V>( context!, listen: listen, searchDown: searchDown );
    } catch ( e ) {
      return null;
    }
  }

  ViewModel();
}