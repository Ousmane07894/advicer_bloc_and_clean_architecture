import 'package:advicer/application/pages/advice/cubit/advicer_cubit.dart';
import 'package:advicer/data/datasources/advice_remote_datasource.dart';
import 'package:advicer/data/repositories/advice_repo_impl.dart';
import 'package:advicer/domain/repositories/advice_repo.dart';
import 'package:advicer/domain/usecases/advice_usecases.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.I;

Future<void> init() async {
  // ! application layer

  sl.registerFactory(() => AdvicerCubit(adviceUseCases: sl()));

  // ! domain layout
  sl.registerFactory(() => AdviceUseCases(adviceRepo: sl()));

  // ! data layer
  sl.registerFactory<AdviceRepo>(
      () => AdviceRepoImpl(adviceRemoteDatasource: sl()));
  sl.registerFactory<AdviceRemoteDatasource>(
      () => AdviceRemoteDatasourceImpl(client: sl()));

  // ! externs
  sl.registerFactory(() => http.Client());
}
