import 'package:json_annotation/json_annotation.dart';
import 'package:robo_test/feature/data/model/country_remote.dart';

part 'countries_response.g.dart';

@JsonSerializable()
class CountriesResponse{
  final List<CountryRemote> countries;

  CountriesResponse(this.countries);

  factory CountriesResponse.fromJson(Map<String, dynamic> json) => _$CountriesResponseFromJson(json);
}

CountriesResponse countriesResponseFromJson(Object? args) => _$CountriesResponseFromJson(args as Map<String, dynamic>);