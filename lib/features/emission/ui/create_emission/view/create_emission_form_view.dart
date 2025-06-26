import 'package:carbon_root_analytics/config/dependencies.dart';
import 'package:carbon_root_analytics/features/emission/domain/carbon_emission.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CarbonCalculatorScreen extends ConsumerStatefulWidget {
  final String companyId;
  const CarbonCalculatorScreen({required this.companyId, super.key});

  @override
  createState() => _CarbonCalculatorScreenState();
}

class _CarbonCalculatorScreenState
    extends ConsumerState<CarbonCalculatorScreen> {
  CarbonEmission calculator = CarbonEmission(monthYear: DateTime.now());

  // Controllers for all input fields
  final Map<String, TextEditingController> controllers = {
    // Scope 1
    'gasKwh': TextEditingController(),

    'dieselGen': TextEditingController(),

    'companyCars': TextEditingController(),

    'deliveryVans': TextEditingController(),

    'forklifts': TextEditingController(),

    'refrigerant': TextEditingController(),

    // Scope 2
    'electricity': TextEditingController(),

    'tdLosses': TextEditingController(),

    // Scope 3
    'comCar': TextEditingController(),

    'comBus': TextEditingController(),

    'comTrain': TextEditingController(),

    'foodWaste': TextEditingController(),

    'recycledWaste': TextEditingController(),

    'paperReams': TextEditingController(),
  };

  // Emission factors based on UK data

  // Expansion states

  Map<String, bool> expansionStates = {
    'scope1': true,

    'scope2': false,

    'scope3': false,
  };

  @override
  void initState() {
    super.initState();

    // Add listeners to all controllers for real-time calculation

    controllers.forEach((key, controller) {
      controller.addListener(() => calculateEmissions(key));
    });
  }

  @override
  void dispose() {
    controllers.values.forEach((controller) => controller.dispose());

    super.dispose();
  }

  double getControllerValue(String key) {
    return double.tryParse(controllers[key]?.text ?? '') ?? 0.0;
  }

  void calculateEmissions(String key) {
    setState(() {
      // Scope 1 calculations
      if (key == 'gasKwh') {
        calculator = calculator.copyWith(
          gasConsumption: getControllerValue('gasKwh'),
        );
      }
      if (key == 'dieselGen') {
        calculator = calculator.copyWith(
          dieselGenConsumption: getControllerValue('dieselGen'),
        );
      }
      if (key == 'companyCars') {
        calculator = calculator.copyWith(
          companyCarDistance: getControllerValue('companyCars'),
        );
      }
      if (key == 'deliveryVans') {
        calculator = calculator.copyWith(
          deliveryVanDistance: getControllerValue('deliveryVans'),
        );
      }
      if (key == 'forklifts') {
        calculator = calculator.copyWith(
          forkliftFuelConsumption: getControllerValue('forklifts'),
        );
      }
      if (key == 'refrigerant') {
        calculator = calculator.copyWith(
          refrigerantLeakage: getControllerValue('refrigerant'),
        );
      }

      // Scope 2 calculations
      if (key == 'electricity') {
        calculator = calculator.copyWith(
          electricityConsumption: getControllerValue('electricity'),
        );
      }
      if (key == 'tdLosses') {
        calculator = calculator.copyWith(
          electricityForTdLosses: getControllerValue('tdLosses'),
        );
      }

      // Scope 3 calculations
      if (key == 'comCar') {
        calculator = calculator.copyWith(
          commuteCarDistance: getControllerValue('comCar'),
        );
      }
      if (key == 'comBus') {
        calculator = calculator.copyWith(
          commuteBusDistance: getControllerValue('comBus'),
        );
      }
      if (key == 'comTrain') {
        calculator = calculator.copyWith(
          commuteTrainDistance: getControllerValue('comTrain'),
        );
      }
      if (key == 'foodWaste') {
        calculator = calculator.copyWith(
          foodWasteAmount: getControllerValue('foodWaste'),
        );
      }
      if (key == 'recycledWaste') {
        calculator = calculator.copyWith(
          recycledWasteAmount: getControllerValue('recycledWaste'),
        );
      }
      if (key == 'paperReams') {
        calculator = calculator.copyWith(
          paperReamsCount: getControllerValue('paperReams'),
        );
      }
    });
  }

  Widget buildInputField(
    String label,
    String controllerKey,
    String unit,
    String resultKey, {
    String? resultUnit,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),

      padding: EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(12),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),

            blurRadius: 10,

            offset: Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            label,

            style: TextStyle(
              fontSize: 16,

              fontWeight: FontWeight.w500,

              color: Colors.grey[800],
            ),
          ),

          SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                flex: 2,

                child: TextFormField(
                  controller: controllers[controllerKey],

                  keyboardType: TextInputType.numberWithOptions(decimal: true),

                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],

                  decoration: InputDecoration(
                    hintText: unit,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),

                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),

                      borderSide: BorderSide(
                        color: Colors.blue[400]!,
                        width: 2,
                      ),
                    ),

                    filled: true,

                    fillColor: Colors.grey[50],
                  ),
                ),
              ),

              SizedBox(width: 16),

              Expanded(
                flex: 1,

                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),

                  decoration: BoxDecoration(
                    color: Colors.grey[100],

                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: Text(
                    '${(calculator.getEmissionByKey(controllerKey)).toStringAsFixed(2)} ${resultUnit ?? 'kg CO₂'}',

                    style: TextStyle(
                      fontSize: 14,

                      fontWeight: FontWeight.w600,

                      color: Colors.grey[700],
                    ),

                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildScopeSection({
    required String title,

    required String scopeKey,

    required Color color,

    required IconData icon,

    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        key: Key(scopeKey),

        initiallyExpanded: expansionStates[scopeKey]!,

        onExpansionChanged: (expanded) {
          setState(() {
            expansionStates[scopeKey] = expanded;
          });
        },

        backgroundColor: Colors.grey[50],

        collapsedBackgroundColor: Colors.white,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),

        title: Row(
          children: [
            Icon(icon, size: 24),

            SizedBox(width: 12),

            Expanded(
              child: Text(
                title,

                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),

        children: [
          Container(
            padding: EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: Colors.grey[50],

              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),

                bottomRight: Radius.circular(15),
              ),
            ),

            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget buildTotalResults() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),

      padding: EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,

        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: buildResultCard(
                  'Scope 1',
                  calculator.scope1Emissions.toStringAsFixed(2),
                  'kg CO₂e',
                ),
              ),

              SizedBox(width: 10),

              Expanded(
                child: buildResultCard(
                  'Scope 2',
                  calculator.scope2Emissions.toStringAsFixed(2),
                  'kg CO₂',
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: buildResultCard(
                  'Scope 3',
                  calculator.scope3Emissions.toStringAsFixed(2),
                  'kg CO₂',
                ),
              ),

              SizedBox(width: 10),

              Expanded(
                child: buildResultCard(
                  'Total',
                  calculator.totalEmissions.toStringAsFixed(2),
                  'kg CO₂e',

                  isTotal: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildResultCard(
    String title,
    String value,
    String unit, {
    bool isTotal = false,
  }) {
    return Container(
      padding: EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inverseSurface,

        borderRadius: BorderRadius.circular(10),
      ),

      child: Column(
        children: [
          Text(
            title,

            style: TextStyle(
              color: Theme.of(context).colorScheme.onInverseSurface,

              fontSize: isTotal ? 16 : 14,

              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 8),

          Text(
            value,

            style: TextStyle(
              color: Theme.of(context).colorScheme.onInverseSurface,

              fontSize: isTotal ? 22 : 18,

              fontWeight: FontWeight.w600,
            ),
          ),

          Text(
            unit,

            style: TextStyle(
              color: Theme.of(context).colorScheme.onInverseSurface,

              fontSize: 12,
            ),
          ),
        ],
      ),
    );
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

  Widget _buildMonthYear() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<int>(
              value: calculator.monthYear.month,
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
                if (value != null) {
                  setState(() {
                    calculator = calculator.copyWith(
                      monthYear: DateTime(
                        calculator.monthYear.year,
                        value,
                        calculator.monthYear.day,
                      ),
                    );
                  });
                }
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonFormField<int>(
              value: calculator.monthYear.year,
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
                if (value != null) {
                  setState(() {
                    calculator = calculator.copyWith(
                      monthYear: DateTime(
                        value,
                        calculator.monthYear.month,
                        calculator.monthYear.day,
                      ),
                    );
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch the view model state
    final emissionState = ref.watch(createEmissionViewModelProvider);

    // Listen for state changes to show success/error messages
    ref.listen<AsyncValue<CarbonEmission?>>(createEmissionViewModelProvider, (
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
        title: Text('Carbon Emission Calculator'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildMonthYear(),

            SizedBox(height: 16),
            // Scope 1
            buildScopeSection(
              title: 'Scope 1 – Direct Emissions',

              scopeKey: 'scope1',

              color: Colors.red[600]!,

              icon: Icons.local_shipping,

              children: [
                buildInputField(
                  'Gas boilers (natural gas combustion)',
                  'gasKwh',
                  'kWh',
                  'gas',
                ),

                buildInputField(
                  'Diesel/gas generators',
                  'dieselGen',
                  'Litres',
                  'dieselGen',
                ),

                buildInputField(
                  'Company cars (petrol/diesel)',
                  'companyCars',
                  'km',
                  'companyCars',
                ),

                buildInputField(
                  'Delivery vans',
                  'deliveryVans',
                  'km',
                  'deliveryVans',
                ),

                buildInputField(
                  'Forklifts & machinery',
                  'forklifts',
                  'Litres fuel',
                  'forklifts',
                ),

                buildInputField(
                  'Refrigerant leaks (R134a GWP≈1,430)',
                  'refrigerant',
                  'kg leaked',
                  'refrigerant',
                  resultUnit: 'kg CO₂e',
                ),
              ],
            ),

            // Scope 2
            buildScopeSection(
              title: 'Scope 2 – Indirect Energy Emissions',

              scopeKey: 'scope2',

              color: Colors.orange[600]!,

              icon: Icons.flash_on,

              children: [
                buildInputField(
                  'Electricity consumption',
                  'electricity',
                  'kWh',
                  'electricity',
                ),

                buildInputField(
                  'T&D losses',
                  'tdLosses',
                  'kWh lost',
                  'tdLosses',
                ),
              ],
            ),

            // Scope 3
            buildScopeSection(
              title: 'Scope 3 – Supply & Value Chain Emissions',

              scopeKey: 'scope3',

              color: Colors.green[600]!,

              icon: Icons.account_tree,

              children: [
                buildInputField(
                  'Employee commuting (car)',
                  'comCar',
                  'km',
                  'comCar',
                ),

                buildInputField(
                  'Employee commuting (bus)',
                  'comBus',
                  'km',
                  'comBus',
                ),

                buildInputField(
                  'Employee commuting (train)',
                  'comTrain',
                  'km',
                  'comTrain',
                ),
                buildInputField(
                  'Food waste (to landfill)',
                  'foodWaste',
                  'tonnes',
                  'foodWaste',
                ),
                buildInputField(
                  'Recycled waste',
                  'recycledWaste',
                  'tonnes',
                  'recycledWaste',
                ),
                buildInputField(
                  'Paper reams used',
                  'paperReams',
                  'reams',
                  'paperReams',
                ),
              ],
            ),

            // Total Results
            buildTotalResults(),

            SizedBox(height: 16),

            SizedBox(
              height: 48,
              child: FilledButton(
                onPressed: emissionState.isLoading
                    ? null
                    : () {
                        ref
                            .read(createEmissionViewModelProvider.notifier)
                            .createEmissionRecord(
                              companyId: widget.companyId,
                              emission: calculator,
                            );
                      },
                child: Text(
                  'Add ${(calculator.totalEmissions / 1000).toStringAsFixed(3)} tonnes CO₂e',

                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onInverseSurface,

                    fontSize: 18,

                    fontWeight: FontWeight.w600,
                  ),

                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
