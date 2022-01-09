import 'package:flutter/material.dart';
import 'package:robo_test/feature/di/feature_module.dart';
import 'package:robo_test/feature/domain/entity/country.dart';
import 'package:robo_test/feature/presentation/detail/detail_page.dart';

class Routes {
  static const String list = "list";
  static const String detail = "detail";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case list:
        return _MainPageRoute(page: ProjectsCompositionRoot.listPage());
      case detail:
        final item = (settings.arguments as Country);
        return _MainPageRoute(page: DetailPage(item: item));
      default:
        throw UnsupportedError("unknown root: ${settings.name}");
    }
  }
}

const _heroAnimationDuration = 300;

class _MainPageRoute<T> extends PageRouteBuilder<T> {
  _MainPageRoute({required Widget page, RouteSettings? settings})
      : super(
          opaque: true,
          transitionDuration: const Duration(milliseconds: _heroAnimationDuration),
          pageBuilder: (_, __, ___) => page,
          settings: settings,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}
