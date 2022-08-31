
import 'package:bvvm/bvvm.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
class FakeViewModel<T extends Widget> extends ViewModel<T> {
  final ValueKey<int> key;
  FakeViewModel( { required this.key });
}

class FakeBloc<T extends Widget> extends Bloc<T> {
  final ValueKey<int> key;
  FakeBloc( { required this.key });
}

void main() {

  group( 'BVVMProvider Tests', () {

    testWidgets('BVVMProvider Update Should Notify Test', (tester) async {
      await tester.pumpWidget(
        BVVMProvider<Container>(
          viewModel: FakeViewModel(
            key: const ValueKey( 1 ),
          ),
          bloc: FakeBloc(
            key: const ValueKey( 1 ),
          ),
          view: Container(),
        ),
      );

      var e = tester.element( find.byType( BVVMProvider<Container> ) );
      expect( e.widget, isA<BVVMProvider<Container>>() );
      var ap = e.widget as BVVMProvider<Container>;

      expect( ap.updateShouldNotify( ap ), isTrue );
    });

    testWidgets('BVVMProvider Provides ViewModel Test', (tester) async {

      await tester.pumpWidget(
        BVVMProvider<Container>(
          viewModel: FakeViewModel(
            key: const ValueKey( 1 ),
          ),
          bloc: FakeBloc(
            key: const ValueKey( 1 ),
          ),
          view: Container(),
        ),
      );

      expect(
        () => ViewModel.of<FakeViewModel>(tester.element(find.byType(Container))),
        isNotNull,
        reason: 'ViewModel should not be null.',
      );

      expect(
        () => ViewModel.maybeOf<FakeViewModel>(tester.element(find.byType(Container))),
        isNotNull,
        reason: 'ViewModel should not be null.',
      );
    });

    testWidgets('BVVMProvider Provides Bloc Test', (tester) async {

      await tester.pumpWidget(
        BVVMProvider<Container>(
          viewModel: FakeViewModel(
            key: const ValueKey( 1 ),
          ),
          bloc: FakeBloc(
            key: const ValueKey( 1 ),
          ),
          view: Container(),
        ),
      );

      expect(
            () => Bloc.of(tester.element(find.byType(Container))),
        isNotNull,
        reason: 'Bloc should not be null.',
      );

      expect(
            () => Bloc.maybeOf(tester.element(find.byType(Container))),
        isNotNull,
        reason: 'Bloc should not be null.',
      );
    });
  });
}