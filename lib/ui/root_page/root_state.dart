import 'package:flutter/cupertino.dart';

@immutable
class RootState {
  final String query;
  final String toWhere;

  RootState({
    required this.query,
    required this.toWhere,
  });

  RootState.init()
      : this(
          query: "",
          toWhere: "",
        );

  RootState clone({
    required String query,
    required String toWhere,
  }) {
    return RootState(
      query: query,
      toWhere: toWhere,
    );
  }

  static RootState get initialState => RootState(
        query: "",
        toWhere: "",
      );
}
