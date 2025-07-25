import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/widgets/button/custom_elevated_button.dart';
import '../provider/log_in_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(logInProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          // show snack bar on error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.red.shade400,
            ),
          );
        },
      );
    });

    final logInState = ref.watch(logInProvider);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 0.5,
                        blurRadius: 1,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Divider(color: Colors.grey),
                      ),

                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator:
                            (val) =>
                                val != null && val.contains('@')
                                    ? null
                                    : 'Invalid email',
                        onSaved: (val) => _email = val!.trim(),
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        validator:
                            (val) =>
                                val != null && val.length >= 6
                                    ? null
                                    : 'Min 6 chars',
                        onSaved: (val) => _password = val!.trim(),
                      ),

                      const SizedBox(height: 30),
                      CustomElevatedButton(
                        icon: Icons.login,
                        buttonColor: Colors.grey.shade600,
                        label:
                            logInState.isLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(8),
                                )
                                : const Text(
                                  'Log In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await ref
                                .read(logInProvider.notifier)
                                .signIn(_email, _password);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
