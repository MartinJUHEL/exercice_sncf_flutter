import 'package:exercicedevsncf/data/services/share_prefs/login_share_pref_service.dart';
import 'package:exercicedevsncf/presentation/authentication/view_models/login_states.dart';
import 'package:exercicedevsncf/providers/authentication_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final loginViewModelProvider =
    StateNotifierProvider.autoDispose<LoginViewModel, LoginStates>(
        (ref) => LoginViewModel(ref));

class LoginViewModel extends StateNotifier<LoginStates> {
  LoginViewModel(this._ref) : super(LoginStates.init());

  final Ref _ref;

  Future<void> login(String email, String password) async {
    await _ref.read(loginProvider.notifier).setLogin(email);
    _ref.read(authenticationProvider.notifier).state = true;
  }

  void toggleShowPassword() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }
}
