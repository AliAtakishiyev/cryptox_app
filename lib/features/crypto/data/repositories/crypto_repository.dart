import 'package:cryptox_app/features/core/network/api_endpoints.dart';
import 'package:cryptox_app/features/core/network/api_exception.dart';
import 'package:cryptox_app/features/core/network/dio_client.dart';
import 'package:cryptox_app/features/crypto/data/models/crypto_model.dart';
import 'package:dio/dio.dart';

class CryptoRepository {
  final Dio _dio;

  CryptoRepository(DioClient client) : _dio = client.dio;

  Future<List<CryptoModel>> getCryptos() async {
    try {
      final response = await _dio.get(
        ApiEndpoints.cryptoMarkets,
        queryParameters: {
          'vs_currency': 'usd',
          'order': 'market_cap_desc',
          'per_page': 10,
          'page': 1,
        },
      );

      final List data = response.data;

      return data.map((json) => CryptoModel.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to load cryptos');
    }
  }
}
