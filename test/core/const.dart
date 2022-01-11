import 'package:robo_test/feature/domain/entity/country.dart';

void alwaysFailFunction(){
  throw Exception("this is test exception");
}

final mockCountries = [
  Country(
    code: "AE",
    name: "United Arab Emirates",
  ),
  Country(
    code: "AF",
    name: "Afghanistan",
  ),
  Country(
    code: "AT",
    name: "Austria",
  ),
  Country(
    code: "AU",
    name: "Australia",
  ),
  Country(
    code: "AW",
    name: "Aruba",
  ),
  Country(
    code: "CH",
    name: "Switzerland",
  ),
  Country(
    code: "CL",
    name: "Chile",
  ),
  Country(
    code: "CM",
    name: "Cameroon",
  ),
  Country(
    code: "MO",
    name: "Macao",
  ),
  Country(
    code: "MP",
    name: "Northern Mariana Islands",
  ),
  Country(
    code: "NA",
    name: "Namibia",
  ),
  Country(
    code: "NC",
    name: "New Caledonia",
  ),
  Country(
    code: "NE",
    name: "Niger",
  ),
  Country(
    code: "NL",
    name: "Netherlands",
  ),
  Country(
    code: "NO",
    name: "Norway",
  ),
  Country(
    code: "NP",
    name: "Nepal",
  ),
  Country(
    code: "TW",
    name: "Taiwan",
  ),
  Country(
    code: "TZ",
    name: "Tanzania",
  ),
  Country(
    code: "US",
    name: "United States",
  ),
];