import 'package:get_it/get_it.dart';
import 'package:test1/core/util/blocs/app/cubit.dart';
import 'package:test1/core/util/network/remote/dio_helper.dart';
import 'package:test1/core/util/network/repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => AppBloc(
    repository: sl(),
  ));

  sl.registerLazySingleton<DioHelper>(
        () => DioImpl(),
  );

  sl.registerLazySingleton<Repository>(
        () => RepositoryImplementation(
      dioHelper: sl(),
    ),
  );
}
