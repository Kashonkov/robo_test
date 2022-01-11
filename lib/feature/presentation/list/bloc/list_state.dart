import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:robo_test/core/bloc/def_state.dart';
import 'package:robo_test/feature/domain/entity/country.dart';

part 'list_state.g.dart';

abstract class ListState
    with DefState<ListState>
    implements Built<ListState, ListStateBuilder> {

  BuiltList<Country>? get countries;

  String? get query;

  BuiltList<Country>? get filteredCountries;

  ListState._();

  factory ListState([updates(ListStateBuilder b)]) =
  _$ListState;

  factory ListState.initial() {
    return ListState((b) =>
    b
      ..error = null
      ..isLoading = true);
  }

  ListState setCountries(List<Country>? countries){
    return rebuild((b) =>
    b
      ..countries = countries != null ? BuiltList<Country>.from(countries).toBuilder(): null);
  }

  ListState setFilteredCountries(List<Country>? countries){
    return rebuild((b) =>
    b
      ..filteredCountries = countries != null ? BuiltList<Country>.from(countries).toBuilder(): null);
  }

  ListState setQuery(String? query){
    return rebuild((b) =>
    b
      ..query = query);
  }
}