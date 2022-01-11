import 'package:robo_test/core/entity/data_holder.dart';
import 'package:robo_test/feature/data/datasource/remote_data_source.dart';
import 'package:robo_test/feature/data/model/country_remote.dart';

import '../../../core/const.dart';

class FailingRemoteDataSource implements  RemoteDataSource{
  @override
  Future<DataHolder<List<CountryRemote>?>> getItemsList() async{
    try{
      alwaysFailFunction();
      return DataHolder.withData([]);
    } catch(e){
      return DataHolder.withException(e as Exception);
    }
  }
}