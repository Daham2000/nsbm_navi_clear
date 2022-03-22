import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'root_event.dart';
import 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  RootBloc(BuildContext context) : super(RootState.initialState);

  @override
  Stream<RootState> mapEventToState(RootEvent event) async* {
    switch (event.runtimeType) {
      case SearchCategory:
        final data = event as SearchCategory;
        yield state.clone(query: data.query, toWhere: '');
        break;

      case NavigateFromWhere:
        final data = event as NavigateFromWhere;
        yield state.clone(query: '', toWhere: data.toWhere);
        break;
    }
  }
}
