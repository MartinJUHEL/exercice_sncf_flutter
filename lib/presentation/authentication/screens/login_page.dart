import 'package:easy_localization/easy_localization.dart';
import 'package:exercicedevsncf/app/custom_styles.dart';
import 'package:exercicedevsncf/presentation/authentication/view_models/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookConsumerWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  void _login(String email, String password, WidgetRef ref,
      BuildContext context) async {
    await ref.read(loginViewModelProvider.notifier).login(email, password);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final notifier = ref.watch(loginViewModelProvider);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('login'.tr()),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'email_required'.tr();
                  }
                  return null;
                },
                decoration: CustomStyles.defaultTextFormFieldStyle(
                    labelTextStr: 'email'.tr(), icon: Icons.email),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  obscureText: notifier.obscurePassword,
                  decoration: CustomStyles.defaultTextFormFieldStyle(
                    labelTextStr: 'password'.tr(),
                    icon: Icons.lock,
                    suffixIcon: InkWell(
                      onTap: ref
                          .read(loginViewModelProvider.notifier)
                          .toggleShowPassword,
                      child: Icon(
                        notifier.obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 25.0,
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login(emailController.value.text.trim(),
                          passwordController.value.text.trim(), ref, context);
                    }
                  },
                  style: CustomStyles.submitPrimaryButton,
                  child: Text('validate'.tr()),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
