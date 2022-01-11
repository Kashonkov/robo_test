import 'package:robo_test/core/entity/data_holder.dart';
import 'package:robo_test/core/string_extension.dart';
import 'package:robo_test/feature/data/datasource/remote_data_source.dart';
import 'package:robo_test/feature/domain/entity/country.dart';
import 'package:robo_test/feature/domain/repository/feature_repository.dart';

class FeatureRepositoryImpl implements FeatureRepository {
  final RemoteDataSource dataSource;

  FeatureRepositoryImpl(this.dataSource);

  @override
  Future<DataHolder<List<Country>?>> getItems() async {
    final result = await dataSource.getItemsList();
    return result.transform((data) =>
        data?.where((element) => element.code.isNotNullOrEmpty && element.name.isNotNullOrEmpty).map((e) => e.toEntity()).toList());
  }
}
