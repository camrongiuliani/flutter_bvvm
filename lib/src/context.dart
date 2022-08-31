import 'package:bvvm/src/provider.dart';
import 'package:bvvm/src/bloc.dart';
import 'package:bvvm/src/view_model.dart';
import 'package:element_tree_child_locator/element_tree_child_locator.dart';
import 'package:flutter/material.dart';

extension BVVMContextExt on BuildContext {

  B findAncestorBlocOfType<B extends Bloc>([bool listen = false, bool searchDown = false]) {

    if ( searchDown ) {
      listen = false;
    }

    Element? match;

    bool matcher( element ) {
      return element is InheritedElement && element.widget is BVVMProvider && (element.widget as BVVMProvider).bloc is B;
    }

    if ( searchDown ) {
      match = findFirstChildElementsMatching( matcher );
    } else {
      bool visitor( Element element ) {
        if ( matcher( element ) ) {
          match = element;
          return false;
        }
        return true;
      }

      visitAncestorElements( visitor );
    }

    assert( match != null, 'No $B found in context' );

    if ( listen ) {
      dependOnInheritedElement( match as InheritedElement );
    }

    return ( match!.widget as BVVMProvider ).bloc as B;
  }

  V findAncestorViewModelOfType<V extends ViewModel>([bool listen = true, bool searchDown = false]) {

    if ( searchDown ) {
      listen = false;
    }

    Element? match;

    bool matcher( element ) {
      return element is InheritedElement && element.widget is BVVMProvider && (element.widget as BVVMProvider).viewModel is V;
    }

    if ( searchDown ) {
      match = findFirstChildElementsMatching( matcher );
    } else {
      bool visitor( Element element ) {
        if ( matcher( element ) ) {
          match = element;
          return false;
        }
        return true;
      }

      visitAncestorElements( visitor );
    }

    assert( match != null, 'No $V found in context' );

    if ( listen ) {
      dependOnInheritedElement( match as InheritedElement );
    }

    return ( match!.widget as BVVMProvider ).viewModel as V;
  }

}