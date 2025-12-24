import 'package:cryptox_app/features/core/network/dio_client.dart';
import 'package:cryptox_app/features/crypto/data/models/crypto_model.dart';
import 'package:cryptox_app/features/crypto/data/repositories/crypto_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

final cryptoRepositoryProvider = Provider<CryptoRepository>((ref) {
  final dioClient = ref.read(dioClientProvider);
  return CryptoRepository(dioClient);
});

final cryptoProvider = FutureProvider<List<CryptoModel>>((ref) {
  final repository = ref.read(cryptoRepositoryProvider);
  return repository.getCryptos();
});
