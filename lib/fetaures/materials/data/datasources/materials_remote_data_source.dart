import 'package:dio/dio.dart';
import 'package:studentmanagement/core/errors/error_message_model.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/network/api_endpoints.dart';
import 'package:studentmanagement/fetaures/materials/data/models/fetch_materials_model.dart';
import 'package:studentmanagement/fetaures/materials/domain/parameters/fetch_material_parameter.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

abstract class MaterialRemoteDataSource {
  Future<FetchMaterialResponseModel> fetchMaterials(
    FetchMaterialParameter params,
  );
}

class MaterialRemoteDataSourceImpl implements MaterialRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<FetchMaterialResponseModel> fetchMaterials(params) async {
    print('📘 Fetch Materials Called');
    print('params ${params.toJson()}');

    try {
      /// 🔹 Get Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();
      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// 🔹 Build API URL
      final url = ApiConstants.getMaterialsPath(baseUrl);

      /// 🔹 Get Token
      final token = await SharedPreferenceHelper().getToken() ?? "";

      /// 🔹 API Call (GET or POST based on backend)
      final response = await dio.post(
        url,
        data: params.toJson(),
        options: Options(
          contentType: "application/json",
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      print('📘 Status Code: ${response.statusCode}');
      print('📘 Response Data: ${response.data}');
      print("FULL URL: $url");

      /// 🔹 Parse Response
      if (response.statusCode == 200 || response.statusCode == 201) {
        return FetchMaterialResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in fetchMaterials: $e');
      print(stacktrace);
      rethrow;
    }
  }
}
