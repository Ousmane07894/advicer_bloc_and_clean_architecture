import 'package:advicer/data/datasources/advice_remote_datasource.dart';
import 'package:advicer/data/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/advice_entity.dart';
import '../../domain/failures/failures.dart';
import '../../domain/repositories/advice_repo.dart';

class AdviceRepoImpl implements AdviceRepo {
  final AdviceRemoteDatasource adviceRemoteDatasource;

  AdviceRepoImpl({required this.adviceRemoteDatasource});

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDatasource() async {
    try {
      final result = await adviceRemoteDatasource.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
