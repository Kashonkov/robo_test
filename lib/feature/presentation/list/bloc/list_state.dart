import 'package:built_value/built_value.dart';
import 'package:robo_test/core/bloc/def_state.dart';
import 'package:robo_test/feature/domain/entity/country.dart';

part 'list_state.g.dart';

abstract class ListState
    with DefState<ListState>
    implements Built<ListState, ListStateBuilder> {

  List<Country>? get countries;

  String? get query;

  List<Country>? get filteredCountries;

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
      ..countries = countries);
  }

  ListState setFilteredCountries(List<Country>? countries){
    return rebuild((b) =>
    b
      ..filteredCountries = countries);
  }

  ListState setQuery(String? query){
    return rebuild((b) =>
    b
      ..query = query);
  }
}