// Login Screen
import 'package:carbon_root_analytics/config/dependencies.dart';
import 'package:carbon_root_analytics/features/auth/ui/register/view_model/register_view_model.dart';
import 'package:carbon_root_analytics/features/navigation_console/view/widgets/responsive_padding.dart';
import 'package:carbon_root_analytics/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterView extends HookConsumerWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final validationMode = useState(AutovalidateMode.disabled);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    // Access the login provider to get the current state
    final registerState = ref.watch(registerViewModelProvider);

    // Listen to the login state changes and show a snackbar on error
    // navigate to console if success
    ref.listen<RegisterState>(registerViewModelProvider, (previous, next) {
      if (next.errorMessage != null) {
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
                  'Register a new User!',
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

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    onPressed: registerState.isLoading
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              ref
                                  .read(registerViewModelProvider.notifier)
                                  .register(
                                    emailController.text.trim(),
                                    passwordController.text,
                                  );
                            } else {
                              validationMode.value = AutovalidateMode.always;
                            }
                          },
                    child: registerState.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Register'),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    context.go(Routes.login);
                  },
                  child: const Text("Already have an account? Login here!"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
