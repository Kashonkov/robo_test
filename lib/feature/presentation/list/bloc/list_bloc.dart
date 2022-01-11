import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robo_test/core/usecase/usecase.dart';
import 'package:robo_test/feature/domain/usecase/get_items_use_case.dart';
import 'package:robo_test/feature/presentation/list/bloc/list_event.dart';
import 'package:robo_test/feature/presentation/list/bloc/list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final GetItemsUseCase getItemsUseCase;

  ListBloc({
    required this.getItemsUseCase
  }) : super(ListState.initial()){
    on<OnInitialEvent>((event, emit) async{
      await _loadInitial(emit);
    });
    on<OnRefreshEvent>((event, emit) async {
      await _loadInitial(emit);
    });
    on<OnQueryChangeEvent>((event, emit) async {
      await _filterList(event.query, emit);
    });

    add(OnInitialEvent());
  }

  _loadInitial(Emitter emitter) async {
    final countries = state.countries?.toList();
    emitter(state.setLoading(true).setCountries(null).setFilteredCountries(null).failure(null).setQuery(null));
    final result = await getItemsUseCase(EmptyUseCaseParams());
    if(result.isSuccessful) {
      emitter(state.setLoading(false).setCountries(result.result).setFilteredCountries(result.result));
    } else {
      emitter(state.setLoading(false).failure(result.exception?.toString()).setCountries(countries).setFilteredCountries(countries));
    }
  }

  _filterList(String? query, Emitter emitter){
    if(query == null || query.isEmpty){
      emitter(state.setQuery(query).setFilteredCountries(state.countries?.toList()));
    } else {
      final filteredCountries = state.countries!.where((element) =>
          element.name.toLowerCase().contains(query.toLowerCase())).toList();
      emitter(state.setQuery(query).setFilteredCountries(filteredCountries));
    }
  }
}