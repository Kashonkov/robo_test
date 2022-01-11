import 'package:equatable/equatable.dart';

class Country extends Equatable{
  final String code;
  final String name;
  final String? emojiU;
  final String? capital;
  final String? currency;
  final List<Language>? languages;
  final List<CountryState>? states;

  Country({
    required this.code,
    required this.name,
    this.emojiU,
    this.capital,
    this.currency,
    this.languages,
    this.states,
  });

  @override
  List<Object?> get props => [code, name];
}

class Language {
  final String name;

  Language(this.name);
}

class CountryState{
  final String name;

  CountryState(this.name);
}