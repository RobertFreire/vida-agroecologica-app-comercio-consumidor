import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ecommercebonito/shared/core/user_storage.dart';

import '../../constants/app_text_constants.dart';
import '../models/banca_model.dart';


class BancaRepository {
  late String userToken;
  final Dio _dio;


  BancaRepository(this._dio);

  Future<List<BancaModel>> getBancas() async {

    UserStorage userStorage = UserStorage();

    userToken = await userStorage.getUserToken();

    try {
    var response = await _dio.get('$kBaseURL/bancas', options: Options(
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $userToken"
      },
    ));

      if (response.statusCode == 200) {
      final List<BancaModel> bancas = [];

      final Map<String, dynamic> jsonData = response.data;
      if (jsonData.containsKey('bancas')) {
        final bancasJson = jsonData['bancas'];
        if (bancasJson is List && bancasJson.isNotEmpty) {
          for (var item in bancasJson) {
            final BancaModel banca = BancaModel.fromJson(item);
            bancas.add(banca);
          }
          return bancas;
        } else {
          throw Exception('Lista de "bancas" vazia ou não encontrada no JSON da resposta.');
        }
      } else {
        throw Exception('Dados de "bancas" não encontrados no JSON da resposta.');
      }
    } else {
      throw Exception('Não foi possível carregar as bancas. Código de status: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Erro ao fazer a requisição: $error');
  }
}
}