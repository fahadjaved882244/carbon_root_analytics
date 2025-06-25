import 'package:carbon_root_analytics/features/navigation_console/view/widgets/responsive_padding.dart';
import 'package:flutter/material.dart';

class CarbonReportPage extends StatefulWidget {
  const CarbonReportPage({super.key});

  @override
  createState() => _CarbonReportPageState();
}

class _CarbonReportPageState extends State<CarbonReportPage> {
  String selectedScope = 'Scope 1 Emissions';
  String selectedCategory = 'All Categories';
  String selectedUsage = 'Daily Usage (Hrs)';
  String selectedPower = 'Power Rating (W)';
  int itemsPerPage = 5;
  int currentPage = 1;

  final List<String> scopes = [
    'Scope 1 Emissions',
    'Scope 2 Emissions',
    'Scope 3 Emissions',
  ];

  final List<String> categories = [
    'All Categories',
    'Stationary Combustion',
    'Mobile Combustion',
    'Fugitive Emissions',
    'Process Emissions',
  ];

  final List<EmissionData> allData = [
    // Stationary Combustion
    EmissionData(
      'Gas Boilers',
      'Stationary Combustion',
      8,
      15000,
      8,
      3600,
      0.12,
      432,
      120,
    ),
    EmissionData(
      'Water Heating',
      'Stationary Combustion',
      12,
      8000,
      6,
      2880,
      0.12,
      346,
      85,
    ),
    EmissionData(
      'Diesel/Gas Generator',
      'Stationary Combustion',
      3,
      25000,
      4,
      1200,
      0.12,
      144,
      200,
    ),

    // Mobile Combustion
    EmissionData(
      'Company Cars',
      'Mobile Combustion',
      15,
      0,
      8,
      0,
      0.15,
      1800,
      250,
    ),
    EmissionData(
      'Delivery Vans',
      'Mobile Combustion',
      8,
      0,
      10,
      0,
      0.15,
      1440,
      180,
    ),
    EmissionData(
      'Forklifts',
      'Mobile Combustion',
      5,
      12000,
      6,
      1800,
      0.12,
      216,
      90,
    ),
    EmissionData(
      'Construction Machinery',
      'Mobile Combustion',
      3,
      45000,
      8,
      4320,
      0.12,
      518,
      300,
    ),

    // Fugitive Emissions
    EmissionData(
      'Air Conditioners',
      'Fugitive Emissions',
      25,
      2500,
      12,
      9000,
      0.12,
      1080,
      180,
    ),
    EmissionData(
      'Refrigerators',
      'Fugitive Emissions',
      50,
      150,
      24,
      10800,
      0.12,
      1296,
      195,
    ),
    EmissionData(
      'Cold Storages',
      'Fugitive Emissions',
      4,
      8000,
      24,
      23040,
      0.12,
      2765,
      450,
    ),
    EmissionData(
      'HVAC Systems',
      'Fugitive Emissions',
      6,
      12000,
      12,
      25920,
      0.12,
      3110,
      520,
    ),

    // Process Emissions
    EmissionData(
      'Metal Cutting/Welding',
      'Process Emissions',
      8,
      5500,
      6,
      7920,
      0.12,
      950,
      160,
    ),
    EmissionData(
      'Ovens (Gas Use)',
      'Process Emissions',
      4,
      18000,
      8,
      17280,
      0.12,
      2074,
      380,
    ),
    EmissionData(
      'Fuel Powered Landscaping Equipment',
      'Process Emissions',
      12,
      3000,
      4,
      4320,
      0.12,
      518,
      85,
    ),
  ];

  List<EmissionData> get filteredData {
    List<EmissionData> filtered = allData;

    if (selectedCategory != 'All Categories') {
      filtered = filtered
          .where((item) => item.category == selectedCategory)
          .toList();
    }

    return filtered;
  }

  List<EmissionData> get paginatedData {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    return filteredData.sublist(
      startIndex,
      endIndex > filteredData.length ? filteredData.length : endIndex,
    );
  }

  int get totalPages => (filteredData.length / itemsPerPage).ceil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsivePadding(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 32),
              _buildFilters(),
              SizedBox(height: 24),
              Expanded(child: _buildDataTable()),
              SizedBox(height: 16),
              _buildPagination(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Generate Report',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        ElevatedButton.icon(
          onPressed: _downloadReport,
          icon: Icon(Icons.download, color: Colors.white),
          label: Text('Download Report', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF9ACD32),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return Row(
      children: [
        Expanded(
          child: _buildDropdown(selectedScope, scopes, (value) {
            setState(() => selectedScope = value!);
          }),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildDropdown(selectedCategory, categories, (value) {
            setState(() {
              selectedCategory = value!;
              currentPage = 1; // Reset to first page when filter changes
            });
          }),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildDropdown(
            selectedUsage,
            ['Daily Usage (Hrs)', 'Weekly Usage (Hrs)', 'Monthly Usage (Hrs)'],
            (value) {
              setState(() => selectedUsage = value!);
            },
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildDropdown(
            selectedPower,
            ['Power Rating (W)', 'Power Rating (kW)', 'Fuel Consumption (L)'],
            (value) {
              setState(() => selectedPower = value!);
            },
          ),
        ),
        SizedBox(width: 16),
        OutlinedButton(
          onPressed: _clearAll,
          child: Text('Clear All'),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        SizedBox(width: 16),
        ElevatedButton(
          onPressed: _generate,
          child: Text('Generate', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF9ACD32),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items.map((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTableHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: paginatedData.length,
              itemBuilder: (context, index) {
                return _buildTableRow(paginatedData[index], index % 2 == 1);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: _buildHeaderCell('Categories')),
          Expanded(flex: 1, child: _buildHeaderCell('Quantity')),
          Expanded(flex: 1, child: _buildHeaderCell('Power Rating\n(W)')),
          Expanded(flex: 1, child: _buildHeaderCell('Daily Usage\n(Hrs)')),
          Expanded(
            flex: 1,
            child: _buildHeaderCell('Monthly\nConsumption (kWh)'),
          ),
          Expanded(flex: 1, child: _buildHeaderCell('Cost Per\nkWh (\$)')),
          Expanded(flex: 1, child: _buildHeaderCell('Monthly\nCost (\$)')),
          Expanded(
            flex: 1,
            child: _buildHeaderCell('Monthly\nSavings Achieved (\$)'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: Colors.grey.shade700,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildTableRow(EmissionData data, bool isOdd) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isOdd ? Colors.grey.shade500 : Colors.white,
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: _buildDataCell(data.name)),
          Expanded(flex: 1, child: _buildDataCell(data.quantity.toString())),
          Expanded(flex: 1, child: _buildDataCell(data.powerRating.toString())),
          Expanded(flex: 1, child: _buildDataCell(data.dailyUsage.toString())),
          Expanded(
            flex: 1,
            child: _buildDataCell(data.monthlyConsumption.toString()),
          ),
          Expanded(
            flex: 1,
            child: _buildDataCell('\$${data.costPerKwh.toStringAsFixed(2)}'),
          ),
          Expanded(flex: 1, child: _buildDataCell('\$${data.monthlyCost}')),
          Expanded(flex: 1, child: _buildDataCell('\$${data.monthlySavings}')),
        ],
      ),
    );
  }

  Widget _buildDataCell(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 14, color: Colors.black87),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text('Items Per Page'),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: itemsPerPage,
                  items: [5, 10, 15, 20].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      itemsPerPage = value!;
                      currentPage = 1;
                    });
                  },
                ),
              ),
            ),
            SizedBox(width: 16),
            Text(
              '${((currentPage - 1) * itemsPerPage) + 1}-${currentPage * itemsPerPage > filteredData.length ? filteredData.length : currentPage * itemsPerPage} of ${filteredData.length} items',
            ),
          ],
        ),
        Row(
          children: [
            for (int i = 1; i <= totalPages && i <= 5; i++)
              GestureDetector(
                onTap: () => setState(() => currentPage = i),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: currentPage == i
                        ? Color(0xFF9ACD32)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: currentPage == i
                          ? Color(0xFF9ACD32)
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    i.toString(),
                    style: TextStyle(
                      color: currentPage == i ? Colors.white : Colors.black87,
                      fontWeight: currentPage == i
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            if (totalPages > 5)
              GestureDetector(
                onTap: () => setState(
                  () => currentPage = currentPage < totalPages
                      ? currentPage + 1
                      : currentPage,
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Icon(Icons.chevron_right),
                ),
              ),
          ],
        ),
      ],
    );
  }

  void _clearAll() {
    setState(() {
      selectedScope = 'Scope 1 Emissions';
      selectedCategory = 'All Categories';
      selectedUsage = 'Daily Usage (Hrs)';
      selectedPower = 'Power Rating (W)';
      currentPage = 1;
    });
  }

  void _generate() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Report generated successfully!'),
        backgroundColor: Color(0xFF9ACD32),
      ),
    );
  }

  void _downloadReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Report download started!'),
        backgroundColor: Color(0xFF9ACD32),
      ),
    );
  }
}

class EmissionData {
  final String name;
  final String category;
  final int quantity;
  final int powerRating;
  final int dailyUsage;
  final int monthlyConsumption;
  final double costPerKwh;
  final int monthlyCost;
  final int monthlySavings;

  EmissionData(
    this.name,
    this.category,
    this.quantity,
    this.powerRating,
    this.dailyUsage,
    this.monthlyConsumption,
    this.costPerKwh,
    this.monthlyCost,
    this.monthlySavings,
  );
}
