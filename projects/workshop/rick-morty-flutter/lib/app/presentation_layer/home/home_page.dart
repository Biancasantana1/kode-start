import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rick_morty/app/domain_layer/domain_layer.dart';
import 'package:rick_morty/app/infra/infra.dart';

import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';
import 'widgets/character_card.dart';
import 'widgets/character_shimmer_list.dart';
import 'widgets/search_field.dart';
import 'widgets/status_filter_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit _cubit;

  final _searchController = TextEditingController();
  final _scroll = ScrollController();

  String? _nameQuery;
  StatusFilter _statusFilter = StatusFilter.all;
  int _currentPage = 1;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _cubit = Modular.get<HomeCubit>();

    _fetch(reset: true);

    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _scroll.dispose();

    super.dispose();
  }

  String? _normalizeName(String? v) {
    final t = (v ?? '').trim();
    return t.isEmpty ? null : t;
  }

  bool get _hasNameFilter => _normalizeName(_nameQuery) != null;
  bool get _hasStatusFilter => _statusFilter != StatusFilter.all;

  Future<void> _fetch({bool reset = false, bool append = false}) async {
    if (reset) _currentPage = 1;
    await _cubit.fetch(
      page: _currentPage,
      name: _normalizeName(_nameQuery),
      status: _statusFilter.toApi(),
      append: append,
    );
  }

  void _onScroll() {
    if (!_scroll.hasClients) return;
    final max = _scroll.position.maxScrollExtent;
    final offset = _scroll.offset;
    const threshold = 280.0;
    final totalPages =
        _cubit.state.info.pages == 0 ? 1 : _cubit.state.info.pages;

    if (max - offset <= threshold &&
        !_cubit.state.isLoadingMore &&
        _cubit.state.currentPage < totalPages) {
      _currentPage = _cubit.state.currentPage + 1;
      _fetch(append: true);
    }
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      final next = value.trim();
      final prev = (_nameQuery ?? '').trim();
      if (next == prev) return;
      _nameQuery = value;
      _fetch(reset: true);
    });
  }

  void _onSearchClear() {
    _debounce?.cancel();
    _searchController.clear();
    FocusScope.of(context).unfocus();

    _nameQuery = null;
    _fetch(reset: true);
  }

  void _onStatusChanged(String? value) {
    _statusFilter = value.toStatusFilter();
    _fetch(reset: true);
  }

  Future<void> _onRefresh() => _fetch(reset: true);

  String _appliedLabel() {
    final parts = <String>[];
    final n = _normalizeName(_nameQuery);
    if (n != null) parts.add('name "$n"');
    if (_hasStatusFilter) parts.add('status ${_statusFilter.label}');
    return parts.isEmpty ? 'all characters' : parts.join(' & ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: appBarComponent(context),
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: _cubit,
        builder: (context, state) {
          final isLoading = state.state is LoadingState;
          final isFailure = state.state is FailureState;
          final items = state.characters;

          final hasAnyFilter = _hasNameFilter || _hasStatusFilter;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SearchField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                onClear: _onSearchClear,
              ),
              StatusFilterBar(
                selected: _statusFilter.toApi() ?? '',
                onChanged: _onStatusChanged,
              ),
              Expanded(
                child: Builder(
                  builder: (_) {
                    if (isLoading && items.isEmpty) {
                      return RefreshIndicator(
                        color: AppColors.primary,
                        onRefresh: _onRefresh,
                        child: const CharacterShimmerList(),
                      );
                    }
                    if (isFailure) {
                      final msg = (state.state as FailureState).message;
                      return ErrorViewComponent(
                        message: msg,
                        onRetry: () => _fetch(reset: true),
                      );
                    }
                    if (hasAnyFilter && !isLoading && items.isEmpty) {
                      final message =
                          'No results for ${_appliedLabel()}. Try clearing filters.';
                      return ErrorViewComponent(
                        message: message,
                        onRetry: () {
                          _searchController.clear();
                          FocusScope.of(context).unfocus();
                          _nameQuery = null;
                          _statusFilter = StatusFilter.all;
                          _fetch(reset: true);
                        },
                      );
                    }
                    return RefreshIndicator(
                      color: AppColors.primary,
                      onRefresh: _onRefresh,
                      child: ListView.builder(
                        controller: _scroll,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: items.length + 1,
                        itemBuilder: (_, i) {
                          if (i < items.length) {
                            final HomeCharacterEntity item = items[i];
                            return CharacterCard(item: item);
                          }
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.height),
                            child: Center(
                              child: state.isLoadingMore
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.4,
                                        color: AppColors.primary,
                                      ),
                                    )
                                  : SizedBox(height: 8.height),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
