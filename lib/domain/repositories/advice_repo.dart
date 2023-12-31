import 'package:advicer/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/advice_entity.dart';

abstract class AdviceRepo {
  Future<Either<Failure, AdviceEntity>> getAdviceFromDatasource();
}
