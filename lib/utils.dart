import 'dart:math';

import 'package:built_collection/built_collection.dart';

final _random = Random();

extension RandomElements<E> on BuiltSet<E> {
  E randomElement() {
    return elementAt(_random.nextInt(length));
  }
}