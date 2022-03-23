import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsbm_navi_clear/db/location_api.dart';

import 'root_event.dart';
import 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  RootBloc(BuildContext context) : super(RootState.initialState) {
    getFromWhereLocations();
  }

  List<String> fromWhereList = [];
  List<String> toWhereList = [];

  void getFromWhereLocations() async {
    fromWhereList = await LocationApi().getAllNavigationFromWhere();
    toWhereList = await LocationApi().getAllNavigationToWhere();
    add(InitEvent(fromWhereList, toWhereList));
  }

  @override
  Stream<RootState> mapEventToState(RootEvent event) async* {
    switch (event.runtimeType) {
      case InitEvent:
        final data = event as InitEvent;
        yield state.clone(
            query: "",
            toWhere: '',
            isSelectedAgain: true,
            fromWhereList: data.fromWhereList,
            toWhereList: data.toWhereList);
        break;

      case SearchCategory:
        final data = event as SearchCategory;
        yield state.clone(
          query: data.query,
          toWhere: '',
          isSelectedAgain: true,
          fromWhereList: state.fromWhereList,
          toWhereList: state.toWhereList,
        );
        break;

      case NavigateFromWhere:
        final data = event as NavigateFromWhere;
        yield state.clone(
          query: '',
          toWhere: data.toWhere,
          isSelectedAgain: false,
          fromWhereList: state.fromWhereList,
          toWhereList: state.toWhereList,
        );
        break;
    }
  }
}
