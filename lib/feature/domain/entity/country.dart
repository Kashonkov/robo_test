class Country {
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
}

class Language {
  final String name;

  Language(this.name);
}

class CountryState{
  final String name;

  CountryState(this.name);
}