

import 'package:bvvm/bvvm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:observable_value/observable_value.dart';

class FakeBloc extends Bloc {
  final ValueKey<int> key;
  FakeBloc( { required this.key });
}

void main() {

  setUp(() => null);


  group("bloc_tests", () {

    test("bindValue sets initialValue test", () {
        FakeBloc bloc = FakeBloc(
          key: const ValueKey(2)
        );

        TextEditingController textController = TextEditingController();

        ObservableValue<String?> viewModelValue = ObservableValue(
          defaultValue: '',
        );


        /// Test initialization expectations
        expect(viewModelValue.value, isEmpty);

        expect(textController.text, isEmpty);

        bloc.bind(
          source: textController,
          observer: viewModelValue,
        );

        textController.text = 'test';

        expect(viewModelValue.value, equals( 'test' ));


    });



    test("bindValue onValueChanged called test", () {
      FakeBloc bloc = FakeBloc(
          key: const ValueKey(2)
      );

      ObservableValue<String?> viewModelValue = ObservableValue(
        defaultValue: null,
      );

      TextEditingController textController = TextEditingController();

      /// Test initialization expectations
      expect(viewModelValue.value, isNull);

      expect(textController.text, isEmpty);

      int callCount = 0;

      void onValueChanged() {
        callCount ++;
      }

      bloc.bind(
        source: textController,
        observer: viewModelValue,
        onValueEmitted: onValueChanged
      );

      textController.text = "Hello, World!";

      expect(callCount, equals(1));

      textController.text = "Hello, Planet!";

      expect(callCount, equals(2));

    });




  });
}