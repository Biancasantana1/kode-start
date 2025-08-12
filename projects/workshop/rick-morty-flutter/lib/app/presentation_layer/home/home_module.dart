import 'package:flutter_modular/flutter_modular.dart';
import 'package:rick_morty/app/domain_layer/domain_layer.dart';
import 'package:rick_morty/app/presentation_layer/home/page/movie_detail_page.dart';

import '../../app_module.dart';
import '../../data_layer/data_layer.dart';
import 'cubit/home_cubit.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i
      ..addLazySingleton(HomeDataSource.new)
      ..addLazySingleton<IHomeRepository>(HomeRepository.new)
      ..addLazySingleton(GetHomeCharacterByIdUseCase.new)
      ..addLazySingleton(GetHomeCharactersUseCase.new)
      ..addLazySingleton(HomeCubit.new);
  }

  @override
  void routes(RouteManager r) {
    r
      ..child(
        Modular.initialRoute,
        child: (_) => const HomePage(),
      )
      ..child(
        '/movie_detail',
        child: (_) => MovieDetailPage(item: r.args.data),
      );
  }

  @override
  List<Module> get imports => [AppModule()];
}
