import 'dart:async';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

abstract class Component {

  final UniqueKey _uk;

  final EventBus bus;

  final GetIt injector;

  bool initialized = false;

  ValueNotifier<bool> progress = ValueNotifier( false );

  Component( { EventBus? customBus } )
      : bus = customBus ?? EventBus(),
        _uk = UniqueKey(),
        injector = GetIt.asNewInstance();

  @visibleForTesting
  void debugPrintUniqueKey() {
    if ( kDebugMode ) {
      print( _uk.toString() );
    }
  }

  @mustCallSuper
  FutureOr<void> init() async {
   initialized = true;
  }

  Future<void> dispose() async {}

  void emit( event ) => bus.fire( event );

}

typedef ComponentBuilderFunc = Component Function();

class ComponentBuilder<T extends Component> {

  final Type type;

  final bool syncBus;

  final ComponentBuilderFunc builderFunc;

  ComponentBuilder(this.builderFunc, { this.syncBus = true }) : type = T;

  T build() => builderFunc() as T;
}