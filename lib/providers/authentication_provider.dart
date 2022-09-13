import 'package:exercicedevsncf/data/services/share_prefs/login_share_pref_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authenticationProvider = StateProvider<bool>((ref) {
  final login = ref.watch(loginProvider);
  if (login.isEmpty) {
    return false;
  } else {
    return true;
  }
});
