import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:carbon_root_analytics/config/dependencies.dart';
import 'package:carbon_root_analytics/features/company/domain/company_model.dart';
import 'package:carbon_root_analytics/utils/core/text_field_validator.dart';

class CreateCompanyView extends HookConsumerWidget {
  const CreateCompanyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final validationMode = useState(AutovalidateMode.disabled);
    final nameController = useTextEditingController();
    final industryController = useTextEditingController();
    final numberOfEmployeesController = useTextEditingController();
    final locationController = useTextEditingController();

    // Listen to the create company state changes and show a snackbar on error
    ref.listen<AsyncValue<Company?>>(createCompanyViewModelProvider, (
      previous,
      next,
    ) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
      if (next.value != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Company added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        // Navigate to the company list view
        Navigator.of(context).pop();
        ref.refresh(readCompanyViewModelProvider);
      }
    });
    return Scaffold(
      appBar: AppBar(title: const Text('Create a Company')),
      body: Center(
        child: Form(
          key: formKey,
          autovalidateMode: validationMode.value,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Company Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.business),
                  ),
                  validator: TextFieldValidator.validateName,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: industryController,
                  decoration: const InputDecoration(
                    labelText: 'Industry',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.category),
                  ),
                  validator: TextFieldValidator.validateName,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: numberOfEmployeesController,
                  decoration: const InputDecoration(
                    labelText: 'Number of Employees',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.people),
                  ),
                  keyboardType: TextInputType.number,
                  validator: TextFieldValidator.validateNumber,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  validator: TextFieldValidator.validateName,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        final userId = ref
                            .read(authStateProvider)
                            .valueOrNull
                            ?.uid;
                        if (userId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('User not authenticated'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          ref
                              .read(createCompanyViewModelProvider.notifier)
                              .createCompany(
                                userId: userId,
                                name: nameController.text.trim(),
                                industry: industryController.text.trim(),
                                numberOfEmployees:
                                    int.tryParse(
                                      numberOfEmployeesController.text.trim(),
                                    ) ??
                                    0,
                                location: locationController.text.trim(),
                              );
                        }
                      } else {
                        validationMode.value = AutovalidateMode.always;
                      }
                    },
                    child: const Text('Add Company'),
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
