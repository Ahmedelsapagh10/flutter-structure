import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_strucuture/core/utils/connectivity/connectivity.dart';

part 'connectivity_state.dart';

//
class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit()
      : super(
          ConnectivityStatus(
              hasConnection: ConnectivityHandler().hasConnection),
        ) {
    listen();
  }
/*
 */
  static ConnectivityCubit get(context) => BlocProvider.of(context);
  bool isInternet = false;

  listen() {
    ConnectivityHandler().start().listen((List<ConnectivityResult> results) {
      isInternet =
          !results.contains(ConnectivityResult.none) && results.isNotEmpty;
      emit(ConnectivityStatus(hasConnection: isInternet));
    });
  }
}
