import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:robo_test/feature/domain/entity/country.dart';

class DetailPage extends StatelessWidget {
  final Country item;

  const DetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            item.name,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Table(
              children: [
                _createRow(
                  context,
                  AppLocalizations.of(context)!.code,
                  [item.code],
                ),
                if (item.emojiU != null)
                  _createRow(
                    context,
                    AppLocalizations.of(context)!.flag,
                    [item.emojiU!],
                  ),
                if (item.capital != null)
                  _createRow(
                    context,
                    AppLocalizations.of(context)!.capital,
                    [item.capital!],
                  ),
                if (item.currency != null)
                  _createRow(
                    context,
                    AppLocalizations.of(context)!.currency,
                    [item.currency!],
                  ),
                if (item.languages != null && item.languages!.isNotEmpty)
                  _createRow(
                    context,
                    AppLocalizations.of(context)!.languages,
                    item.languages!.map((e) => e.name).toList(),
                  ),
                if (item.states != null && item.states!.isNotEmpty)
                  _createRow(
                    context,
                    AppLocalizations.of(context)!.states,
                    item.states!.map((e) => e.name).toList(),
                  )
              ],
            ),
          ),
        ),
      );

  // final String? currency;
  // final List<Language>? languages;
  // final List<CountryState>? states;

  TableRow _createRow(BuildContext context, String title, List<String> values) {
    return TableRow(
      children: <Widget>[
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.top,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: values
                  .map((e) => Text(
                        e,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1,
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
