import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:robo_test/feature/domain/entity/country.dart';

part 'country_remote.g.dart';

@JsonSerializable()
class CountryRemote {
  final String? code;
  final String? name;
  final String? emojiU;
  final String? capital;
  final String? currency;
  final List<LanguageRemote>? languages;
  final List<StateRemote>? states;


  CountryRemote({
    this.name,
    this.code,
    this.capital,
    this.currency,
    this.languages,
    this.states,
    this.emojiU,
  });

  factory CountryRemote.fromJson(Map<String, dynamic> json) => _$CountryRemoteFromJson(json);

  Country toEntity() {
    if (name == null || code == null) {
      throw Exception("Unsupported country");
    }
    String? flag;
    if (emojiU != null) {
      final runes = emojiU!.split(" ");
      final r = runes.map((e) => e.substring(2)).map((e) => int.parse(e, radix: 16));
      flag = String.fromCharCodes(r);
    }
    return Country(
      code: code!,
      name: name!,
      emojiU: flag,
      capital: capital,
      currency: currency,
      languages: languages?.map((e) => Language(e.name)).toList(),
      states: states?.map((e) => CountryState(e.name)).toList(),
    );
  }
}

@JsonSerializable()
class LanguageRemote {
  final String name;

  LanguageRemote(this.name);

  factory LanguageRemote.fromJson(Map<String, dynamic> json) => _$LanguageRemoteFromJson(json);
}

@JsonSerializable()
class StateRemote {
  final String name;

  StateRemote(this.name);

  factory StateRemote.fromJson(Map<String, dynamic> json) => _$StateRemoteFromJson(json);
}