This package is a starting point for the BVVM pattern.

## WIP, not production ready!

This pattern is very similar to MVVM; however, the BLoC (as the name implies) will handle all
of the business logic.

Through the use of the BVVMProvider, the bloc and view model are provided to the widget.

The constructor of the BVVMProvider handles building the bloc and view model.

The view has access to the bloc & view model via the use of the .of getter, like: 

```dart
Bloc.of( context );
ViewModel.of( context );
```

Similar to Provider, do not unsafely call the .of lookups in initState or dispose unless you pass listen: false, like:
```dart
Bloc.of( context, listen: false );
```

Both BLoCs and View Models can be located in children elements by passing searchDown:true, though this is not recommended in most cases:
```dart
Bloc.of( context, listen: false, searchDown:true );
```

To aid in getting everything setup, it is recommended to use the BBVMState class in your stateful widgets like:
```dart
class _MyPageState extends BVVMState<MyPage> { ... }
```

This will register the proper dependencies with Flutter and ensure you are working with the right instance of BLoC & ViewModel