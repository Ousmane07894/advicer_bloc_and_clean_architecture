import 'package:dartz/dartz.dart';

import '../entities/advice_entity.dart';
import '../failures/failures.dart';
import '../repositories/advice_repo.dart';

class AdviceUseCases {
  final AdviceRepo adviceRepo;

  AdviceUseCases({required this.adviceRepo});

  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepo.getAdviceFromDatasource();
    //return left(CacheFailure());
  }
}
