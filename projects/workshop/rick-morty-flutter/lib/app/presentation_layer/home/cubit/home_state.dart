import 'package:equatable/equatable.dart';
import 'package:rick_morty/app/domain_layer/domain_layer.dart';
import 'package:rick_morty/app/infra/infra.dart';

class HomeState extends Equatable {
  final BaseState state;

  final List<HomeCharacterEntity> characters;

  final HomeInfoEntity info;

  final int currentPage;

  final String name;

  final String status;

  final bool isLoadingMore;

  const HomeState({
    this.state = const IdleState(),
    this.characters = const [],
    this.info = const HomeInfoEntity.empty(),
    this.currentPage = 1,
    this.name = '',
    this.status = '',
    this.isLoadingMore = false,
  });

  bool get canLoadMore => currentPage < info.pages;

  HomeState copyWith({
    BaseState? state,
    List<HomeCharacterEntity>? characters,
    HomeInfoEntity? info,
    int? currentPage,
    String? name,
    String? status,
    bool? isLoadingMore,
  }) =>
      HomeState(
        state: state ?? this.state,
        characters: characters ?? this.characters,
        info: info ?? this.info,
        currentPage: currentPage ?? this.currentPage,
        name: name ?? this.name,
        status: status ?? this.status,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      );

  @override
  List<Object?> get props => [
        state,
        characters,
        info,
        currentPage,
        name,
        status,
        isLoadingMore,
      ];
}
