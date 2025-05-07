import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_soliq_app/blocs/rate/rate_bloc.dart';
import 'package:smart_soliq_app/blocs/rate/rate_state.dart';

import 'package:smart_soliq_app/core/network/dio_exception.dart';

import '../export_files.dart';

class RateController {
  static Future<void> getAll(BuildContext context) async {
    try {
      await BlocProvider.of<RateBloc>(context).get();
    } catch (e, track) {
      var err = e as DioExceptions;
      if (kDebugMode) {
        print("Controller Error >>$e");
        print("Controller track >>$track");
      }

      BlocProvider.of<RateBloc>(
        context,
      ).emit(RateErrorState(message: err.message, title: err.message,statusCode: 500));
    }
  }
}
