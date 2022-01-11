import 'package:bloc_test/bloc_test.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dime_flutter/dime_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robo_test/core/bloc/def_state.dart';
import 'package:robo_test/feature/domain/entity/country.dart';
import 'package:robo_test/feature/presentation/list/bloc/list_bloc.dart';
import 'package:robo_test/feature/presentation/list/bloc/list_event.dart';
import 'package:robo_test/feature/presentation/list/bloc/list_state.dart';

import '../../core/const.dart';
import '../../widget_test.dart';

const _testQuery = "Us";

final filteredCountries = [
  Country(
    code: "AT",
    name: "Austria",
  ),
  Country(
    code: "AU",
    name: "Australia",
  ),
];

void testListBloc() {
  group('ListBloc', () {
    blocTest(
      "Test Bloc when error occurs on back",
      setUp: () async {
        dimeReset();
        initFailureDime();
      },
      build: () => ListBloc(getItemsUseCase: dimeGet()),
      expect: () => [
        ListState.initial(),
        ListState((b) => b
          ..error = const BlocStateError("Exception: this is test exception")
          ..isLoading = false),
      ],
    );
  });

  blocTest(
    "Test Bloc when data successfully fetched, query and refresh works fine",
    setUp: () async {
      dimeReset();
      initSuccessDime();
    },
    build: () => ListBloc(getItemsUseCase: dimeGet()),
    wait: const Duration(seconds: 6),
    act: (ListBloc b) async{
      await Future.delayed(const Duration(seconds: 3));
      b.add(OnRefreshEvent());
      await Future.delayed(const Duration(seconds: 2));
      b.add(OnQueryChangeEvent(_testQuery));
      b.add(OnQueryChangeEvent(null));
    },
    expect: () => [
      ListState.initial(),
      ListState((b) => b
        ..error = null
        ..countries = BuiltList<Country>.from(mockCountries).toBuilder()
        ..filteredCountries = BuiltList<Country>.from(mockCountries).toBuilder()
        ..isLoading = false),
      ListState.initial(),
      ListState((b) => b
        ..countries = BuiltList<Country>.from(mockCountries).toBuilder()
        ..filteredCountries = BuiltList<Country>.from(mockCountries).toBuilder()
        ..isLoading = false),
      ListState((b) => b
        ..query = _testQuery
        ..countries = BuiltList<Country>.from(mockCountries).toBuilder()
        ..filteredCountries = BuiltList<Country>.from(filteredCountries).toBuilder()
        ..isLoading = false),
      ListState((b) => b
        ..countries = BuiltList<Country>.from(mockCountries).toBuilder()
        ..filteredCountries = BuiltList<Country>.from(mockCountries).toBuilder()
        ..isLoading = false),
    ],
  );
}
