import 'package:easy_localization/easy_localization.dart';
import 'package:exercicedevsncf/app/app_text_styles.dart';
import 'package:exercicedevsncf/app/color_schemes.g.dart';
import 'package:exercicedevsncf/data/services/share_prefs/login_share_pref_service.dart';
import 'package:exercicedevsncf/models/weather.dart';
import 'package:exercicedevsncf/presentation/home/view_models/home_view_model.dart';
import 'package:exercicedevsncf/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget _buildDrawer(
    HomeViewModel vm,
    bool useUserLocation,
  ) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Center(
            child: Text('app_name'.tr()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                Text('use_location'.tr()),
                Switch(
                    value: useUserLocation,
                    onChanged: (value) {
                      vm.toggleLocation();
                    }),
              ],
            ),
          ),
          ListTile(
            title: Text('logout'.tr()),
            leading: const Icon(Icons.logout),
            onTap: () => vm.logout(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController controller = usePageController();
    final notifier = ref.watch(homeViewModelProvider);
    final login = ref.watch(loginProvider);
    final vm = ref.read(homeViewModelProvider.notifier);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('${'welcome'.tr()} $login'),
          ),
          drawer: Drawer(
            child: _buildDrawer(
              vm,
              notifier.useUserLocation,
            ),
          ),
          body: (() {
            if (notifier.status == StandardStateStatus.loading) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (notifier.status == StandardStateStatus.error) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(notifier.error ?? 'problem'.tr(),
                      style: TextStyle(color: lightColorScheme.error)),
                ),
              );
            } else {
              return PageView.builder(
                  controller: controller,
                  itemCount: notifier.forecast.length,
                  itemBuilder: (BuildContext context, int i) {
                    var forecastByDay = notifier.forecast;
                    int day = forecastByDay.keys.elementAt(i);
                    if (forecastByDay[day] == null) {
                      return Center(
                        child: Text(notifier.error ?? 'problem'.tr(),
                            style: TextStyle(color: lightColorScheme.error)),
                      );
                    } else {
                      return RefreshIndicator(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 8,
                            child: ListView.builder(
                                itemCount: forecastByDay[day]!.length + 1,
                                itemBuilder: (BuildContext context, int j) {
                                  if (j == 0) {
                                    // return the header
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        DateFormat.yMMMMd('fr_FR').format(
                                            forecastByDay[day]![0].dtTxt),
                                        style: AppTextStyles.title,
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }
                                  j -= 1;
                                  Weather weather =
                                      forecastByDay[day]![j].weather[0];
                                  return ListTile(
                                    leading: Image.network(
                                        'http://openweathermap.org/img/wn/${weather.icon}@2x.png'),
                                    title: Text(DateFormat.Hm('fr_FR')
                                        .format(forecastByDay[day]![j].dtTxt)),
                                    subtitle:
                                        Text('${forecastByDay[day]?[j].temp}°'),
                                    trailing: Text(
                                        '${weather.main} : ${weather.description}'),
                                  );
                                }),
                          ),
                        ),
                        onRefresh: () => vm.getForecastByDay(
                            notifier.location.lat, notifier.location.lon,
                            forceRefresh: true),
                      );
                    }
                  });
            }
          }())),
    );
  }
}
