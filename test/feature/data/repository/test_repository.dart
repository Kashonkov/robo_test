import 'package:dime_flutter/dime_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robo_test/feature/domain/repository/feature_repository.dart';
import 'package:robo_test/core/string_extension.dart';

import '../../../widget_test.dart';

void testRepository(){
  group('Test repository', (){
    test('`Data from web should be fetch correctly, excluding countries with empty code or name`', () async{
      dimeReset();
      initSuccessDime();
      
      final FeatureRepository repository = dimeGet();

      final convertedData = await repository.getItems();

      expect(convertedData.data!.isNotEmpty, true);
      expect(convertedData.data!.where((element) => element.code.isNullOrEmpty || element.name.isNullOrEmpty).length, 0);
    });
    
  });
}