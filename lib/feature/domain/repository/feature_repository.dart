import 'package:robo_test/core/entity/data_holder.dart';
import 'package:robo_test/feature/domain/entity/country.dart';

abstract class FeatureRepository{
  Future<DataHolder<List<Country>?>> getItems();
}