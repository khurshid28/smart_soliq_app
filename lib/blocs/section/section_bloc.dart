import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:smart_soliq_app/blocs/section/section_state.dart';
import 'package:smart_soliq_app/core/endpoints/endpoints.dart';
import 'package:smart_soliq_app/service/storage_service.dart';
import '../../core/network/dio_Client.dart';
import '../../export_files.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionBloc extends Cubit<SectionState> {
  DioClient dioClient = DioClient();
  SectionBloc() : super(SectionIntialState());

  Future get({
    required int id
  }) async {
    emit(SectionWaitingState());
    String? token  = StorageService().read(StorageService.access_token);
    dio.Response response = await dioClient.get("${Endpoints.section}/$id",options: dio.Options(
      headers: {
        "Authorization" :"Bearer $token"
      }
    ));
    if (kDebugMode) {
      print(response.realUri);
      print(response.statusCode);
      print(response.data);
    }

    if (response.statusCode == 200) {
      emit(SectionSuccessState(data: response.data));
    } else {
      emit(
        SectionErrorState(
          title: response.data["error"],
          message: response.data["error"],
          statusCode: response.statusCode
        ),
      );
    }

    return response.data;
  }
}
