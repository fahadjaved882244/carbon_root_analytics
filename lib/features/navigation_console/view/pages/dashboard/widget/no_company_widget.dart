import 'package:carbon_root_analytics/features/company/ui/create_company/view/create_company_view.dart';
import 'package:carbon_root_analytics/features/navigation_console/utils/media_query_extension.dart';
import 'package:flutter/material.dart';

class NoCompanyWidget extends StatelessWidget {
  const NoCompanyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No company found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  final content = const CreateCompanyView();
                  if (context.isPhone) {
                    return Dialog.fullscreen(
                      key: const Key('project_detail_fullscreen_dialog'),
                      child: content,
                    );
                  } else {
                    return Dialog(
                      key: const Key('project_detail_dialog'),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: content,
                      ),
                    );
                  }
                },
              );
            },
            child: const Text('Add Company'),
          ),
        ],
      ),
    );
  }
}
