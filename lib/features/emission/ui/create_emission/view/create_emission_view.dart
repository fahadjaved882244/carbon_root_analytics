import 'package:carbon_root_analytics/config/dependencies.dart';
import 'package:carbon_root_analytics/features/emission/domain/emission.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateEmissionView extends HookConsumerWidget {
  final String companyId;

  const CreateEmissionView({super.key, required this.companyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Form key for validation
    final formKey = useMemoized(() => GlobalKey<FormState>());

    // Text controllers using hooks
    final vehicleFuelController = useTextEditingController();
    final gasHeatingController = useTextEditingController();
    final electricityController = useTextEditingController();
    final employeeCommuteController = useTextEditingController();
    final paperUsageController = useTextEditingController();
    final cloudUsageController = useTextEditingController();

    // Date selection state
    final selectedMonth = useState<int>(DateTime.now().month);
    final selectedYear = useState<int>(DateTime.now().year);

    // Focus nodes for better UX
    final vehicleFuelFocus = useFocusNode();
    final gasHeatingFocus = useFocusNode();
    final electricityFocus = useFocusNode();
    final employeeCommuteFocus = useFocusNode();
    final paperUsageFocus = useFocusNode();
    final cloudUsageFocus = useFocusNode();

    // Watch the view model state
    final emissionState = ref.watch(createEmissionViewModelProvider);

    // Listen for state changes to show success/error messages
    ref.listen<AsyncValue<Emission?>>(createEmissionViewModelProvider, (
      previous,
      next,
    ) {
      next.whenOrNull(
        data: (emission) {
          if (emission != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Emission record created successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            // Clear form after successful creation
            _clearForm(
              vehicleFuelController,
              gasHeatingController,
              electricityController,
              employeeCommuteController,
              paperUsageController,
              cloudUsageController,
            );
            // Optionally, pop the dialog or navigate back
            Navigator.of(context).pop();
          }
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${error.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Create Emission Record'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Selection
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reporting Period',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: selectedMonth.value,
                          decoration: const InputDecoration(
                            labelText: 'Month',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.calendar_month),
                          ),
                          items: List.generate(12, (index) {
                            final month = index + 1;
                            return DropdownMenuItem(
                              value: month,
                              child: Text(_getMonthName(month)),
                            );
                          }),
                          onChanged: (value) {
                            if (value != null) selectedMonth.value = value;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: selectedYear.value,
                          decoration: const InputDecoration(
                            labelText: 'Year',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.calendar_month_outlined),
                          ),
                          items: List.generate(10, (index) {
                            final year = DateTime.now().year - index;
                            return DropdownMenuItem(
                              value: year,
                              child: Text(year.toString()),
                            );
                          }),
                          onChanged: (value) {
                            if (value != null) selectedYear.value = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Energy & Transport Section
              _buildSection(
                title: 'Scope 1',
                icon: Icons.local_gas_station,
                children: [
                  _buildNumberField(
                    controller: vehicleFuelController,
                    focusNode: vehicleFuelFocus,
                    nextFocusNode: gasHeatingFocus,
                    label: 'Vehicle Fuel',
                    unit: 'Litres',
                    icon: Icons.local_gas_station,
                    validator: _validatePositiveNumber,
                  ),
                  const SizedBox(height: 12),
                  _buildNumberField(
                    controller: gasHeatingController,
                    focusNode: gasHeatingFocus,
                    nextFocusNode: electricityFocus,
                    label: 'Gas Heating',
                    unit: 'kWh',
                    icon: Icons.local_fire_department,
                    validator: _validatePositiveNumber,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _buildSection(
                title: 'Scope 2',
                icon: Icons.electric_bolt,
                children: [
                  _buildNumberField(
                    controller: electricityController,
                    focusNode: electricityFocus,
                    label: 'Electricity',
                    unit: 'kWh',
                    icon: Icons.electrical_services,
                    validator: _validatePositiveNumber,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Operations Section
              _buildSection(
                title: 'Scope 3',
                icon: Icons.business,
                children: [
                  _buildNumberField(
                    controller: employeeCommuteController,
                    focusNode: employeeCommuteFocus,
                    nextFocusNode: paperUsageFocus,
                    label: 'Employee Commute',
                    unit: 'Km',
                    icon: Icons.commute,
                    validator: _validatePositiveNumber,
                  ),
                  const SizedBox(height: 12),
                  _buildNumberField(
                    controller: paperUsageController,
                    focusNode: paperUsageFocus,
                    nextFocusNode: cloudUsageFocus,
                    label: 'Paper Usage',
                    unit: 'Reams',
                    icon: Icons.description,
                    validator: _validatePositiveInteger,
                    isInteger: true,
                  ),
                  const SizedBox(height: 12),
                  _buildNumberField(
                    controller: cloudUsageController,
                    focusNode: cloudUsageFocus,
                    label: 'Cloud Usage',
                    unit: 'Hours',
                    icon: Icons.cloud,
                    validator: _validatePositiveNumber,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: emissionState.isLoading
                      ? null
                      : () => _submitForm(
                          context,
                          ref,
                          formKey,
                          companyId,
                          selectedMonth.value,
                          selectedYear.value,
                          vehicleFuelController,
                          gasHeatingController,
                          electricityController,
                          employeeCommuteController,
                          paperUsageController,
                          cloudUsageController,
                        ),
                  icon: emissionState.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.save),
                  label: Text(
                    emissionState.isLoading
                        ? 'Creating...'
                        : 'Create Emission Record',
                    style: const TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.green.shade700),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildNumberField({
    required TextEditingController controller,
    required FocusNode focusNode,
    FocusNode? nextFocusNode,
    required String label,
    required String unit,
    required IconData icon,
    required String? Function(String?) validator,
    bool isInteger = false,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.numberWithOptions(decimal: !isInteger),
      textInputAction: nextFocusNode != null
          ? TextInputAction.next
          : TextInputAction.done,
      inputFormatters: [
        if (isInteger)
          FilteringTextInputFormatter.digitsOnly
        else
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      decoration: InputDecoration(
        labelText: '$label ($unit)',
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
        suffixText: unit,
      ),
      validator: validator,
      onFieldSubmitted: (_) {
        if (nextFocusNode != null) {
          nextFocusNode.requestFocus();
        }
      },
    );
  }

  String? _validatePositiveNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final number = double.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }
    if (number < 0) {
      return 'Value must be positive';
    }
    return null;
  }

  String? _validatePositiveInteger(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final number = int.tryParse(value);
    if (number == null) {
      return 'Please enter a valid whole number';
    }
    if (number < 0) {
      return 'Value must be positive';
    }
    return null;
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  void _clearForm(
    TextEditingController vehicleFuelController,
    TextEditingController gasHeatingController,
    TextEditingController electricityController,
    TextEditingController employeeCommuteController,
    TextEditingController paperUsageController,
    TextEditingController cloudUsageController,
  ) {
    vehicleFuelController.clear();
    gasHeatingController.clear();
    electricityController.clear();
    employeeCommuteController.clear();
    paperUsageController.clear();
    cloudUsageController.clear();
  }

  void _submitForm(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<FormState> formKey,
    String companyId,
    int month,
    int year,
    TextEditingController vehicleFuelController,
    TextEditingController gasHeatingController,
    TextEditingController electricityController,
    TextEditingController employeeCommuteController,
    TextEditingController paperUsageController,
    TextEditingController cloudUsageController,
  ) {
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Hide keyboard
    FocusScope.of(context).unfocus();

    ref
        .read(createEmissionViewModelProvider.notifier)
        .createEmissionRecord(
          companyId: companyId,
          month: month,
          year: year,
          vehicleFuelLitres: double.parse(vehicleFuelController.text),
          gasHeatingKWh: double.parse(gasHeatingController.text),
          electricityKWh: double.parse(electricityController.text),
          employeeCommuteKm: double.parse(employeeCommuteController.text),
          paperUsageReams: int.parse(paperUsageController.text),
          cloudUsageHours: double.parse(cloudUsageController.text),
        );
  }
}
