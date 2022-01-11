import 'package:dime_flutter/dime_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robo_test/feature/data/datasource/remote_data_source.dart';
import 'package:robo_test/feature/data/repository/feature_repository_impl.dart';
import 'package:robo_test/feature/domain/repository/feature_repository.dart';
import 'package:robo_test/feature/domain/usecase/get_items_use_case.dart';
import 'package:robo_test/feature/presentation/list/bloc/list_bloc.dart';
import 'package:robo_test/feature/presentation/list/list_page.dart';

import '../data/datasource/failing_remote_data_source.dart';
import '../data/datasource/success_remote_data_source.dart';

class FeatureMockDimeModule extends BaseDimeModule {
  @override
  void updateInjections() {
    //region Repository
    addSingleByCreator<FeatureRepository>((tag) => FeatureRepositoryImpl(dimeGet()));
    //region UseCase
    addCreator((tag) => GetItemsUseCase(dimeGet()));
    //regionBloc
  }
}

class FeatureSuccessDataSourceModule extends BaseDimeModule{
  @override
  void updateInjections() {
    //region DataSource
    addSingleByCreator<RemoteDataSource>((tag) => SuccessRemoteDataSource());
  }
}

class FeatureFailureDataSourceModule extends BaseDimeModule{
  @override
  void updateInjections() {
    //region DataSource
    addSingleByCreator<RemoteDataSource>((tag) => FailingRemoteDataSource());
  }
}