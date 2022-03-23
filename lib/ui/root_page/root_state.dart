import 'package:flutter/cupertino.dart';

@immutable
class RootState {
  final String query;
  final String toWhere;
  final bool isSelectedAgain;
  final List<String> fromWhereList;
  final List<String> toWhereList;

  RootState({
    required this.query,
    required this.toWhere,
    required this.isSelectedAgain,
    required this.fromWhereList,
    required this.toWhereList,
  });

  RootState.init()
      : this(
          query: "",
          toWhere: "",
          isSelectedAgain: false,
          fromWhereList: [],
          toWhereList: [],
        );

  RootState clone({
    required String query,
    required String toWhere,
    required bool isSelectedAgain,
    required List<String> fromWhereList,
    required List<String> toWhereList,
  }) {
    return RootState(
      query: query,
      toWhere: toWhere,
      isSelectedAgain: isSelectedAgain,
      fromWhereList: fromWhereList,
      toWhereList: toWhereList,
    );
  }

  static RootState get initialState => RootState(
        query: "",
        toWhere: "",
        isSelectedAgain: false,
        fromWhereList: [],
        toWhereList: [],
      );
}
