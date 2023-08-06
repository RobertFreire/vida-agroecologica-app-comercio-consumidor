import '../models/banca_model.dart';
import '../repositories/banca_repository.dart';

class BancaController {
  final BancaRepository bancaRepository;

  BancaController({required this.bancaRepository});

  Future<List<BancaModel>> getBancas() {
    return bancaRepository.getBancas();
  }
}
