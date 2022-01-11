// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dime_flutter/dime_flutter.dart';
import 'package:robo_test/core/di/core_module.dart';

import 'feature/data/repository/test_repository.dart';
import 'feature/di/feature_mock_module.dart';
import 'feature/presentation/test_list_bloc.dart';

void main() {
  testRepository();
  testListBloc();
}

initSuccessDime() {
  dimeInstall(CoreDimeModule());
  dimeInstall(FeatureSuccessDataSourceModule());
  dimeInstall(FeatureMockDimeModule());
}

initFailureDime() {
  dimeInstall(CoreDimeModule());
  dimeInstall(FeatureFailureDataSourceModule());
  dimeInstall(FeatureMockDimeModule());
}
