import 'dart:convert';

import 'package:robo_test/core/entity/data_holder.dart';
import 'package:robo_test/feature/data/datasource/remote_data_source.dart';
import 'package:robo_test/feature/data/model/countries_response.dart';
import 'package:robo_test/feature/data/model/country_remote.dart';
import 'package:robo_test/feature/domain/entity/country.dart';

class SuccessRemoteDataSource implements RemoteDataSource {
  @override
  Future<DataHolder<List<CountryRemote>?>> getItemsList() async {
    await Future.delayed(const Duration(seconds: 1));
    final js = json.decode(jsonString);
    final countries = CountriesResponse.fromJson(js);
    return DataHolder.withData(countries.countries);
  }
}

const jsonString = r'''
{
    "__typename": "Query",
    "countries": [
      {
        "__typename": "Country",
        "code": "AE",
        "name": "United Arab Emirates"
      },
      {
        "__typename": "Country",
        "code": "AF",
        "name": "Afghanistan"
      },
      {
        "__typename": "Country",
        "code": "AT",
        "name": "Austria"
      },
      {
        "__typename": "Country",
        "code": "AU",
        "name": "Australia"
      },
      {
        "__typename": "Country",
        "code": "AW",
        "name": "Aruba"
      },
      {
        "__typename": "Country",
        "code": "CH",
        "name": "Switzerland"
      },
      {
        "__typename": "Country",
        "code": "CL",
        "name": "Chile"
      },
      {
        "__typename": "Country",
        "code": "CM",
        "name": "Cameroon"
      },
      {
        "__typename": "Country",
        "code": "MO",
        "name": "Macao"
      },
      {
        "__typename": "Country",
        "code": "MP",
        "name": "Northern Mariana Islands"
      },
      {
        "__typename": "Country",
        "code": "NA",
        "name": "Namibia"
      },
      {
        "__typename": "Country",
        "code": "NC",
        "name": "New Caledonia"
      },
      {
        "__typename": "Country",
        "code": "NE",
        "name": "Niger"
      },
      {
        "__typename": "Country",
        "code": "NL",
        "name": "Netherlands"
      },
      {
        "__typename": "Country",
        "code": "NO",
        "name": "Norway"
      },
      {
        "__typename": "Country",
        "code": "NP",
        "name": "Nepal"
      },
      {
        "__typename": "Country",
        "code": "TW",
        "name": "Taiwan"
      },
      {
        "__typename": "Country",
        "code": "TZ",
        "name": "Tanzania"
      },
      {
        "__typename": "Country",
        "code": "US",
        "name": "United States"
      },
      {
        "__typename": "Country",
        "code": "",
        "name": ""
      }
    ]
}
    ''';