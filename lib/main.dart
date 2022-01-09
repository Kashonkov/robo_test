import 'package:dime_flutter/dime_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:robo_test/core/colors.dart';
import 'package:robo_test/core/executor/src/executor.dart';
import 'package:robo_test/core/routes.dart';
import 'package:robo_test/feature/di/feature_module.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/di/core_module.dart';

final mainNavigatorKey = GlobalKey<NavigatorState>();

NavigatorState? get mainNavigator => mainNavigatorKey.currentState;

BuildContext get mainContext => mainNavigator!.context;

void main() {
  initDime();
  Executor().warmUp(isolatesCount: 1);
  runApp(const TestApp());
}


initDime() {
  dimeInstall(CoreDimeModule());
  dimeInstall(FeatureDimeModule());
}


class TestApp extends StatefulWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  State createState() =>  TestAppState();
}


class TestAppState extends State<TestApp> {
  final TextTheme defaultTheme = Typography.material2018(platform: defaultTargetPlatform).englishLike;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: AppColors.surface));
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en', ''),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        applyElevationOverlayColor: false,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          primaryVariant: AppColors.primaryVariant,
          secondary: AppColors.secondary,
          secondaryVariant: AppColors.secondaryVariant,
          surface: AppColors.surface,
          background: AppColors.background,
          error: AppColors.error,
          onPrimary: AppColors.onPrimary,
          onSecondary: AppColors.onSecondary,
          onSurface: AppColors.onSurface,
          onBackground: AppColors.onBackground,
          onError: AppColors.onError,
        ),
        textTheme: TextTheme(
          headline1: defaultTheme.headline1!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 36,
            height: 1.22,
            fontFamily: 'Roboto',
            color: AppColors.textColor,
          ),
          headline2: defaultTheme.headline2!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 30,
            height: 1.22,
            fontFamily: 'Roboto',
            color: AppColors.textColor,
          ),
          headline3: defaultTheme.headline3!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 21,
            height: 1.14,
            fontFamily: 'Roboto',
            color: AppColors.textColor,
          ),
          headline4: defaultTheme.headline4!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            height: 1.22,
            fontFamily: 'Roboto',
            color: AppColors.textColor,
          ),
          bodyText1: defaultTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            letterSpacing: 0,
            fontFamily: 'Roboto',
          ),
          bodyText2: defaultTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            letterSpacing: 0,
            fontFamily: 'Roboto',
          ),
          button: defaultTheme.button!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            letterSpacing: 0,
            fontFamily: 'Roboto',
          ),
          subtitle1: defaultTheme.subtitle1!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 1.22,
            fontFamily: 'Roboto',
            color: AppColors.textColor,
          ),
          caption: defaultTheme.caption!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            fontFamily: 'Roboto',
            color: AppColors.optional2,
          ),
        ),
        dividerTheme: const DividerThemeData(color: AppColors.dividerColor, thickness: 1.0),
      ),
      title: '',
      debugShowCheckedModeBanner: false,
      navigatorKey: mainNavigatorKey,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.list,
    );
  }
}
