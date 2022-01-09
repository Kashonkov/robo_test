import 'package:robo_test/core/usecase/usecase.dart';
import 'package:robo_test/feature/domain/entity/country.dart';
import 'package:robo_test/feature/domain/repository/feature_repository.dart';

class GetItemsUseCase implements UseCase<List<Country>?, EmptyUseCaseParams>{
  final FeatureRepository repository;

  GetItemsUseCase(this.repository);

  @override
  Future<UseCaseResult<List<Country>?>> call(EmptyUseCaseParams params) async{
    final data = await repository.getItems();

    if(data.hasException){
      return UseCaseResult.error(data.exception!);
    } else {
      return UseCaseResult.successful(data.data);
    }
  }
}
