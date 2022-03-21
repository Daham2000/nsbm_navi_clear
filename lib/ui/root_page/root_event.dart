import 'package:flutter/cupertino.dart';

@immutable
abstract class RootEvent {}

class SearchCategory extends RootEvent {
  final String query;

  SearchCategory(this.query);
}
