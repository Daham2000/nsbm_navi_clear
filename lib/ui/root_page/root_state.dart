import 'package:flutter/cupertino.dart';

@immutable
class RootState {
  final String query;

  RootState({
    required this.query,
  });

  RootState.init()
      : this(
          query: "",
        );

  RootState clone({
    required String query,
  }) {
    return RootState(
      query: query,
    );
  }

  static RootState get initialState => RootState(
        query: "",
      );
}
