import 'package:carbon_root_analytics/config/dependencies.dart';
import 'package:carbon_root_analytics/features/company/domain/company_model.dart';
import 'package:carbon_root_analytics/features/emission/ui/create_emission/view/create_emission_view.dart';
import 'package:carbon_root_analytics/features/navigation_console/utils/media_query_extension.dart';
import 'package:carbon_root_analytics/features/navigation_console/view/pages/logs/widgets/emission_expansion_panel.dart';
import 'package:carbon_root_analytics/features/navigation_console/view/widgets/responsive_padding.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompanyDetailsView extends ConsumerWidget {
  const CompanyDetailsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final company = ref.watch(readCompanyViewModelProvider);

    return Scaffold(
      body: company.when(
        data: (company) {
          if (company == null) {
            return const Center(child: Text('No company data available.'));
          }

          return _buildCompanyDetails(context, company);
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

  Widget _buildCompanyDetails(BuildContext context, Company company) {
    return ResponsivePadding(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              company.name,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              company.location,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),
            _buildRow('Industry', company.industry),
            _buildRow('Employees', company.numberOfEmployees.toString()),
            _buildRow(
              'Last Updated',
              company.lastUpdated.toLocal().toIso8601String().substring(0, 10),
            ),
            const SizedBox(height: 32),

            // Add Monthly Carbon Data Section
            // create a expandable list tile for emissions grouped by year
            Text(
              'Carbon Emission Data',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Expanded(child: EmissionExpansionPanel()),

            Center(
              child: FilledButton.tonalIcon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      final content = CreateEmissionView(companyId: company.id);
                      if (context.isPhone) {
                        return Dialog.fullscreen(
                          key: const Key('create_emission_fullscreen_dialog'),
                          child: content,
                        );
                      } else {
                        return Dialog(
                          key: const Key('create_emission_dialog'),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: content,
                          ),
                        );
                      }
                    },
                  );
                },
                icon: const Icon(Icons.add_chart),
                label: const Text('Add Monthly Carbon Data'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 16),
          Text(value),
        ],
      ),
    );
  }
}
