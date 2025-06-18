import 'package:carbon_root_analytics/features/company/domain/company_model.dart';
import 'package:carbon_root_analytics/features/emission/ui/create_emission/view/create_emission_view.dart';
import 'package:carbon_root_analytics/features/navigation_console/utils/media_query_extension.dart';
import 'package:flutter/material.dart';

class NoEmissionWidget extends StatelessWidget {
  final Company company;
  const NoEmissionWidget({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to the Dashboard, ${company.name}!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          FilledButton(
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
            child: const Text('Add Carbon Emissions'),
          ),
        ],
      ),
    );
  }
}
