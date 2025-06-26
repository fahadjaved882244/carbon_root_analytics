import 'package:carbon_root_analytics/features/emission/domain/carbon_emission.dart';
import 'package:carbon_root_analytics/features/emission/ui/read_emission/view_model/read_emission_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GenerateReportTab extends ConsumerStatefulWidget {
  const GenerateReportTab({super.key});

  @override
  createState() => _GenerateReportTabState();
}

class _GenerateReportTabState extends ConsumerState<GenerateReportTab> {
  String selectedScope = 'All Scopes';
  String selectedCategory = 'All Categories';
  String selectedMonth = 'All Months';
  String selectedYear = 'All Years';

  // Emission factors
  static const Map<String, Map<String, double>> emissionFactors = {
    'scope1': {
      'gas': 0.1829, // kg CO₂/kWh
      'dieselGen': 2.68, // kg CO₂/L
      'companyCars': 0.238, // kg CO₂/km
      'deliveryVans': 0.220, // kg CO₂/km
      'forklifts': 2.68, // kg CO₂/L
      'refrigerant': 1430, // GWP for R134a
    },
    'scope2': {
      'electricity': 0.207, // kg CO₂/kWh
      'tdLosses': 0.0183, // kg CO₂/kWh
    },
    'scope3': {
      'comCar': 0.171, // kg CO₂/km
      'comBus': 0.082, // kg CO₂/km
      'comTrain': 0.041, // kg CO₂/km
      'foodWaste': 3.3, // kg CO₂/tonne
      'recycledWaste': 0.021, // kg CO₂/tonne
      'paperReams': 3.29, // kg CO₂/ream
    },
  };

  // Category mappings
  final Map<String, Map<String, dynamic>> categoryMappings = {
    'Gas Consumption': {
      'scope': 'Scope 1',
      'unit': 'kWh',
      'field': 'gasConsumption',
      'factor': 0.1829,
    },
    'Diesel Generator': {
      'scope': 'Scope 1',
      'unit': 'L',
      'field': 'dieselGenConsumption',
      'factor': 2.68,
    },
    'Company Cars': {
      'scope': 'Scope 1',
      'unit': 'km',
      'field': 'companyCarDistance',
      'factor': 0.238,
    },
    'Delivery Vans': {
      'scope': 'Scope 1',
      'unit': 'km',
      'field': 'deliveryVanDistance',
      'factor': 0.220,
    },
    'Forklifts': {
      'scope': 'Scope 1',
      'unit': 'L',
      'field': 'forkliftFuelConsumption',
      'factor': 2.68,
    },
    'Refrigerant': {
      'scope': 'Scope 1',
      'unit': 'kg',
      'field': 'refrigerantLeakage',
      'factor': 1430,
    },
    'Electricity': {
      'scope': 'Scope 2',
      'unit': 'kWh',
      'field': 'electricityConsumption',
      'factor': 0.207,
    },
    'T&D Losses': {
      'scope': 'Scope 2',
      'unit': 'kWh',
      'field': 'electricityForTdLosses',
      'factor': 0.0183,
    },
    'Commute Car': {
      'scope': 'Scope 3',
      'unit': 'km',
      'field': 'commuteCarDistance',
      'factor': 0.171,
    },
    'Commute Bus': {
      'scope': 'Scope 3',
      'unit': 'km',
      'field': 'commuteBusDistance',
      'factor': 0.082,
    },
    'Commute Train': {
      'scope': 'Scope 3',
      'unit': 'km',
      'field': 'commuteTrainDistance',
      'factor': 0.041,
    },
    'Food Waste': {
      'scope': 'Scope 3',
      'unit': 'tonnes',
      'field': 'foodWasteAmount',
      'factor': 3.3,
    },
    'Recycled Waste': {
      'scope': 'Scope 3',
      'unit': 'tonnes',
      'field': 'recycledWasteAmount',
      'factor': 0.021,
    },
    'Paper Reams': {
      'scope': 'Scope 3',
      'unit': 'reams',
      'field': 'paperReamsCount',
      'factor': 3.29,
    },
  };

  List<String> get scopeOptions => [
    'All Scopes',
    'Scope 1',
    'Scope 2',
    'Scope 3',
  ];
  List<String> get categoryOptions => [
    'All Categories',
    ...categoryMappings.keys,
  ];
  List<String> get monthOptions => [
    'All Months',
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
  List<String> get yearOptions => ['All Years', '2025', '2024'];

  List<Map<String, dynamic>> getFilteredData(List<CarbonEmission> emissions) {
    List<Map<String, dynamic>> reportData = [];

    for (String category in categoryMappings.keys) {
      final categoryInfo = categoryMappings[category]!;

      // Apply scope filter
      if (selectedScope != 'All Scopes' &&
          categoryInfo['scope'] != selectedScope) {
        continue;
      }

      // Apply category filter
      if (selectedCategory != 'All Categories' &&
          category != selectedCategory) {
        continue;
      }

      double totalUnits = 0;
      double totalEmissions = 0;
      int dataPointsCount = 0;

      for (CarbonEmission emission in emissions) {
        // Apply year filter
        if (selectedYear != 'All Years' &&
            emission.monthYear.year.toString() != selectedYear) {
          continue;
        }

        // Apply month filter
        if (selectedMonth != 'All Months') {
          int monthIndex = monthOptions.indexOf(selectedMonth);
          if (emission.monthYear.month != monthIndex) {
            continue;
          }
        }

        double value = _getFieldValue(emission, categoryInfo['field']);
        totalUnits += value;
        totalEmissions += value * categoryInfo['factor'];
        if (value > 0) dataPointsCount++;
      }

      if (totalUnits > 0 || selectedCategory == category) {
        reportData.add({
          'category': category,
          'scope': categoryInfo['scope'],
          'unit': categoryInfo['unit'],
          'totalUnits': totalUnits,
          'totalEmissions': totalEmissions,
          'emissionFactor': categoryInfo['factor'],
          'dataPoints': dataPointsCount,
        });
      }
    }

    return reportData;
  }

  double _getFieldValue(CarbonEmission emission, String fieldName) {
    switch (fieldName) {
      case 'gasConsumption':
        return emission.gasConsumption;
      case 'dieselGenConsumption':
        return emission.dieselGenConsumption;
      case 'companyCarDistance':
        return emission.companyCarDistance;
      case 'deliveryVanDistance':
        return emission.deliveryVanDistance;
      case 'forkliftFuelConsumption':
        return emission.forkliftFuelConsumption;
      case 'refrigerantLeakage':
        return emission.refrigerantLeakage;
      case 'electricityConsumption':
        return emission.electricityConsumption;
      case 'electricityForTdLosses':
        return emission.electricityForTdLosses;
      case 'commuteCarDistance':
        return emission.commuteCarDistance;
      case 'commuteBusDistance':
        return emission.commuteBusDistance;
      case 'commuteTrainDistance':
        return emission.commuteTrainDistance;
      case 'foodWasteAmount':
        return emission.foodWasteAmount;
      case 'recycledWasteAmount':
        return emission.recycledWasteAmount;
      case 'paperReamsCount':
        return emission.paperReamsCount;
      default:
        return 0.0;
    }
  }

  void _clearAllFilters() {
    setState(() {
      selectedScope = 'All Scopes';
      selectedCategory = 'All Categories';
      selectedMonth = 'All Months';
      selectedYear = 'All Years';
    });
  }

  void _generateReport() {
    // Handle report generation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Report generated successfully!')),
    );
  }

  void _downloadReport() {
    // Handle report download
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Report download started!')));
  }

  @override
  Widget build(BuildContext context) {
    final dataState = ref.watch(readEmissionViewModelProvider);

    final filteredData = getFilteredData(dataState.valueOrNull ?? []);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: dataState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'Error loading emissions data: $error',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.red),
          ),
        ),
        data: (data) {
          if (data.isEmpty) {
            return Center(
              child: Text(
                'No emissions data available for this company.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Generate Report',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _downloadReport,
                      icon: const Icon(Icons.download, color: Colors.white),
                      label: const Text(
                        'Download Report',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8BC34A),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Filters Row
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        'Scope',
                        selectedScope,
                        scopeOptions,
                        (value) {
                          setState(() => selectedScope = value!);
                        },
                      ),
                    ),
                    // const SizedBox(width: 16),
                    // Expanded(
                    //   child: _buildDropdown(
                    //     'Category',
                    //     selectedCategory,
                    //     categoryOptions,
                    //     (value) {
                    //       setState(() => selectedCategory = value!);
                    //     },
                    //   ),
                    // ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDropdown(
                        'Month',
                        selectedMonth,
                        monthOptions,
                        (value) {
                          setState(() => selectedMonth = value!);
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDropdown('Year', selectedYear, yearOptions, (
                        value,
                      ) {
                        setState(() => selectedYear = value!);
                      }),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton(
                      onPressed: _clearAllFilters,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Clear All'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _generateReport,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8BC34A),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Generate',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Data Table
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: DataTable(
                        columnSpacing: 24,
                        headingRowColor: MaterialStateProperty.all(
                          Colors.grey[100],
                        ),
                        headingTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                        columns: const [
                          DataColumn(label: Text('Categories')),
                          DataColumn(label: Text('Scope')),
                          DataColumn(label: Text('Unit')),
                          DataColumn(label: Text('Total Units')),
                          DataColumn(label: Text('Emission Factor')),
                          DataColumn(label: Text('Total Emissions\n(kg CO₂)')),
                          // DataColumn(label: Text('Data Points')),
                        ],
                        rows: filteredData.map((data) {
                          return DataRow(
                            color: MaterialStateProperty.resolveWith<Color?>((
                              Set<MaterialState> states,
                            ) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.grey[50];
                              }
                              return null;
                            }),
                            cells: [
                              DataCell(
                                Text(
                                  data['category'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getScopeColor(data['scope']),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    data['scope'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(Text(data['unit'])),
                              DataCell(
                                Text(data['totalUnits'].toStringAsFixed(1)),
                              ),
                              DataCell(
                                Text(data['emissionFactor'].toStringAsFixed(4)),
                              ),
                              DataCell(
                                Text(
                                  data['totalEmissions'].toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              // DataCell(Text(data['dataPoints'].toString())),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),

                // Summary
                if (filteredData.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Categories: ${filteredData.length}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Total Emissions: ${filteredData.fold(0.0, (sum, data) => sum + data['totalEmissions']).toStringAsFixed(2)} kg CO₂',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String value,
    List<String> options,
    Function(String?) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: options.map((String option) {
            return DropdownMenuItem<String>(value: option, child: Text(option));
          }).toList(),
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down),
        ),
      ),
    );
  }

  Color _getScopeColor(String scope) {
    switch (scope) {
      case 'Scope 1':
        return Colors.red[400]!;
      case 'Scope 2':
        return Colors.orange[400]!;
      case 'Scope 3':
        return Colors.blue[400]!;
      default:
        return Colors.grey[400]!;
    }
  }
}
