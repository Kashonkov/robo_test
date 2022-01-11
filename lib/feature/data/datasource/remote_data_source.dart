import 'package:graphql/client.dart';
import 'package:robo_test/core/entity/data_holder.dart';
import 'package:robo_test/core/executor/src/executor.dart';
import 'package:robo_test/feature/data/model/countries_response.dart';
import 'package:robo_test/feature/data/model/country_remote.dart';

abstract class RemoteDataSource {
  Future<DataHolder<List<CountryRemote>?>> getItemsList();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final GraphQLClient client;

  RemoteDataSourceImpl(this.client);

  @override
  Future<DataHolder<List<CountryRemote>?>> getItemsList() async {
    const String readCountries = r'''
      query ReadCountries() {
        countries {
          code
          name
        }
      }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(readCountries),
      fetchPolicy: FetchPolicy.noCache,
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      return DataHolder.withException(result.exception!);
    } else {
      final data = result.data;
      if (data != null) {
        final result = await Executor()
            .execute<CountriesResponse>(func: countriesResponseFromJson, args: data);
        return DataHolder.withData(result.countries);
      } else {
        return DataHolder.withData(null);
      }
    }
  }
}
