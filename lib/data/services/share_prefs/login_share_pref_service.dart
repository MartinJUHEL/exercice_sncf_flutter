import 'package:exercicedevsncf/domain/repositories/login_share_pref_repository.dart';
import 'package:exercicedevsncf/providers/sharepref_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final loginProvider =
    StateNotifierProvider<LoginSharePrefService, String>((ref) {
  final prefs = ref.watch(sharePreferencesProvider).asData?.value;
  return LoginSharePrefService(prefs!);
});

class LoginSharePrefService extends StateNotifier<String>
    with LoginSharePrefRepository {
  LoginSharePrefService(this._sharedPreferences)
      : super(_sharedPreferences.getString('login') ?? '');

  final SharedPreferences _sharedPreferences;

  Future<bool> setLogin(String login) async {
    state = login;
    return _sharedPreferences.setString('login', login);
  }
}
