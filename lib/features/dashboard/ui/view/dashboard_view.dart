import 'package:carbon_root_analytics/config/dependencies.dart';
import 'package:carbon_root_analytics/features/dashboard/ui/view/widget/no_company_widget.dart';
import 'package:carbon_root_analytics/features/dashboard/ui/view/widget/no_emission_widget.dart';
import 'package:carbon_root_analytics/features/emission/ui/read_emission/view/read_emission_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final company = ref.watch(readCompanyViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: company.when(
        data: (company) {
          if (company == null) {
            return const NoCompanyWidget();
          }
          // return NoEmissionWidget(company: company);
          return CarbonDashboardView(companyId: "12");
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'Error loading company data: $error',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
