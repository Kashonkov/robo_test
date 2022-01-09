import 'package:dime_flutter/dime_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robo_test/feature/data/datasource/remote_data_source.dart';
import 'package:robo_test/feature/data/repository/feature_repository_impl.dart';
import 'package:robo_test/feature/domain/repository/feature_repository.dart';
import 'package:robo_test/feature/domain/usecase/get_items_use_case.dart';
import 'package:robo_test/feature/presentation/list/bloc/list_bloc.dart';
import 'package:robo_test/feature/presentation/list/list_page.dart';

class FeatureDimeModule extends BaseDimeModule {
  @override
  void updateInjections() {
    //region DataSource
    addSingleByCreator<RemoteDataSource>((tag) => RemoteDataSourceImpl(dimeGet()));
    //region Repository
    addSingleByCreator<FeatureRepository>((tag) => FeatureRepositoryImpl(dimeGet()));
    //region UseCase
    addCreator((tag) => GetItemsUseCase(dimeGet()));
    //regionBloc
  }
}

class ProjectsCompositionRoot {
  static Widget listPage() => BlocProvider(
      create: (_) => ListBloc(
            getItemsUseCase: dimeGet(),
          ),
      child: const ListPage());
}
