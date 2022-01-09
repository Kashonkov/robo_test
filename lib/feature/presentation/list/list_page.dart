import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robo_test/core/routes.dart';
import 'package:robo_test/core/widget/bloc_instance_provider.dart';
import 'package:robo_test/core/widget/debounce_search.dart';
import 'package:robo_test/core/widget/local_text_provider.dart';
import 'package:robo_test/feature/domain/entity/country.dart';
import 'package:robo_test/feature/presentation/list/bloc/list_bloc.dart';
import 'package:robo_test/feature/presentation/list/bloc/list_event.dart';
import 'package:robo_test/feature/presentation/list/bloc/list_state.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListPageState();
}

class _ListPageState extends StateWithBLoc<ListBloc, ListPage> with LocaleTextProvider {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            local.countries,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        body: BlocConsumer(
            bloc: bloc,
            builder: (context, ListState state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return RefreshIndicator(
                  child: Column(
                    children: [
                      if (state.countries != null && state.countries!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: DebounceSearch(
                            listener: (query) {
                              bloc.add(OnQueryChangeEvent(query));
                            },
                            initialValue: state.query,
                          ),
                        ),
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => _buildCountryItem(context, state.filteredCountries![index]),
                            separatorBuilder: (context, index) => const Divider(),
                            itemCount: state.filteredCountries != null ? state.filteredCountries!.length : 0),
                      ),
                    ],
                  ),
                  onRefresh: () {
                    bloc.add(OnRefreshEvent());
                    return Future.value();
                  });
            },
            listenWhen: (ListState previous, ListState current) {
              return previous.error != current.error;
            },
            listener: (context, ListState state) {
              if (state.isError) {
                final snackBar = SnackBar(
                  content: Text(state.error!.errorMessage),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }),
      );

  Widget _buildCountryItem(BuildContext context, Country country) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.detail, arguments: country);
      },
      title: Row(
        children: [
          SizedBox(width: 40, child: country.emojiU != null ? Text(country.emojiU!) : null),
          Text(
            country.name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
