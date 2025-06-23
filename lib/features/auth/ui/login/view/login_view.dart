// Login Screen
import 'package:carbon_root_analytics/config/dependencies.dart';
import 'package:carbon_root_analytics/features/auth/ui/login/view_model/login_view_model.dart';
import 'package:carbon_root_analytics/features/navigation_console/view/widgets/responsive_padding.dart';
import 'package:carbon_root_analytics/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final validationMode = useState(AutovalidateMode.disabled);
    final emailController = useTextEditingController(
      text: "testuser@gmail.com",
    );
    final passwordController = useTextEditingController(text: "12345678");

    // Listen to the login state changes and show a snackbar on error
    // navigate to console if success
    ref.listen<LoginState>(loginViewModelProvider, (previous, next) {
      if (previous != next && next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    return Scaffold(
      body: ResponsivePadding(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Form(
            key: formKey,
            autovalidateMode: validationMode.value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                Consumer(
                  builder: (context, ref, child) {
                    final loginState = ref.watch(loginViewModelProvider);
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton(
                        onPressed: loginState.isLoading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  ref
                                      .read(loginViewModelProvider.notifier)
                                      .login(
                                        emailController.text.trim(),
                                        passwordController.text,
                                      );
                                } else {
                                  validationMode.value =
                                      AutovalidateMode.always;
                                }
                              },
                        child: loginState.isLoading
                            ? const CircularProgressIndicator()
                            : const Text('Login'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    context.go(Routes.register);
                  },
                  child: const Text("Don't have an account? Sign up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
