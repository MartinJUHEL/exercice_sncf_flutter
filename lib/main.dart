import 'package:dynamic_color/dynamic_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:exercicedevsncf/presentation/authentication/screens/login_page.dart';
import 'package:exercicedevsncf/presentation/home/screens/home_page.dart';
import 'package:exercicedevsncf/providers/authentication_provider.dart';
import 'package:exercicedevsncf/providers/sharepref_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      supportedLocales: [Locale('fr', '')],
      path: 'assets/translations',
      fallbackLocale: Locale('fr', ''),
      child: const ProviderScope(child: WeatherApp())));
}

class WeatherApp extends HookConsumerWidget {
  const WeatherApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DynamicColorBuilder(
      builder: (lightColorScheme, darkColorScheme) {
        final pref = ref.watch(sharePreferencesProvider);
        return pref.when(
            loading: () => const CircularProgressIndicator(),
            error: (e, s) => const SizedBox.shrink(),
            data: (value) => MaterialApp(
                  locale: context.locale,
                  supportedLocales: context.supportedLocales,
                  localizationsDelegates: context.localizationDelegates,
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    colorScheme: lightColorScheme ?? lightColorScheme,
                    useMaterial3: true,
                  ),
                  darkTheme: ThemeData(
                    colorScheme: darkColorScheme ?? darkColorScheme,
                    useMaterial3: true,
                  ),
                  themeMode: ThemeMode.dark,
                  home: Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      final authenticated = ref.watch(authenticationProvider);
                      if (authenticated) {
                        return const HomePage();
                      } else {
                        return LoginPage();
                      }
                    },
                  ),
                ));
      },
    );
  }
}
