import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'infra/infra.dart';
import 'presentation_layer/modules.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i
      ..addLazySingleton(() => Dio())
      ..addLazySingleton<IHttpClient>(HttpClient.new);
  }

  @override
  void routes(RouteManager r) {
    r
      ..module(Modular.initialRoute, module: SplashModule())
      ..module('/home', module: HomeModule());
  }
}
