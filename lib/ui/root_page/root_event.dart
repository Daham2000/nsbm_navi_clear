import 'package:flutter/cupertino.dart';

@immutable
abstract class RootEvent {}

class InitEvent extends RootEvent {
  final List<String> fromWhereList;
  final List<String> toWhereList;

  InitEvent(this.fromWhereList, this.toWhereList);
}

class SearchCategory extends RootEvent {
  final String query;

  SearchCategory(this.query);
}

class NavigateFromWhere extends RootEvent {
  final String toWhere;

  NavigateFromWhere(this.toWhere);
}
