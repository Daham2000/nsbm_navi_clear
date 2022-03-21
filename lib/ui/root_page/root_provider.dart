import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsbm_navi_clear/ui/root_page/root_page_view.dart';

import 'root_bloc.dart';

class RootProvider extends BlocProvider<RootBloc> {
  RootProvider({Key? key})
      : super(
          key: key,
          create: (context) => RootBloc(context),
          child: const RootView(),
        );
}
