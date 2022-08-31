import 'dart:async';
import 'package:bvvm/bvvm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:observable_value/observable_value.dart';

class Bloc<T extends Widget> extends Component {

  final List<ObservableValue> _observers = [];

  Bloc( { super.customBus } );

  static B of<B extends Bloc>( BuildContext context, { bool listen = false, bool searchDown = false } ) {
    return context.findAncestorBlocOfType<B>( listen, searchDown );
  }

  static B? maybeOf<B extends Bloc>( BuildContext context, { bool listen = true } ) {
    try {
      return of<B>( context, listen: listen );
    } catch ( e ) {
      return null;
    }
  }

  @override
  Future<void> dispose() async {
    for ( var obs in _observers ) {
      obs.dispose();
    }

    _observers.clear();
  }

  Future<void> unBind( ObservableValue observer ) async {
    observer.dispose();
    _observers.remove( observer );
  }

  @visibleForTesting
  void debugPrintBindCount( ObservableValue v ) {
    if ( kDebugMode ) {
      print('$runtimeType :: ObservableBinding Count = ${_observers.where((element) => element == v).length}');
    }
  }

  void bind<S>( { required ObservableValue observer, required S source, VoidCallback? onValueEmitted } ) {
    if ( observer.bind( source, onValueEmitted: onValueEmitted ) ) {
      _observers.add( observer );
    }
  }

  void bindMultiple<S>( { required S source, required List<ObservableValue> observers, VoidCallback? onValueEmitted } ) {
    for ( var observer in observers ) {
      bind<S>( observer: observer, source: source, onValueEmitted: onValueEmitted );
    }
  }
}