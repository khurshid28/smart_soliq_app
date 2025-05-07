import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_soliq_app/blocs/section/section_bloc.dart';
import 'package:smart_soliq_app/blocs/test/test_bloc.dart';
import 'package:smart_soliq_app/blocs/test/test_state.dart';

import 'package:smart_soliq_app/core/network/dio_exception.dart';

import '../export_files.dart';

class TestController {

static Future<void> getByid(BuildContext context,{required int id}) async {
    try {
      await BlocProvider.of<TestBloc>(context).get(id : id);
    } catch (e, track) {
      if (kDebugMode) {
        print("Controller Error >>$e");
        print("Controller track >>$track");
      }
      var err = e as DioExceptions;

      BlocProvider.of<TestBloc>(
        context,
      ).emit(TestErrorState(message: err.message, title: err.message,statusCode: 500));
    }
  }

}
