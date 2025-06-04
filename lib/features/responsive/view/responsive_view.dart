// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:carbon_root_analytics/features/contact/contact_view.dart';
// import 'package:carbon_root_analytics/features/experience/view/exprience_list_view.dart';
// import 'package:carbon_root_analytics/features/home/home_view.dart';
// import 'package:carbon_root_analytics/features/project/view/project_list_view.dart';
// import 'package:carbon_root_analytics/features/responsive/utils/media_query_extension.dart';
// import 'package:carbon_root_analytics/features/responsive/view/widgets/custom_drawer.dart';
// import 'package:carbon_root_analytics/features/responsive/view/widgets/custom_nav_menu.dart';

// import 'widgets/responsive_padding.dart';

// const widgets = [
//   HomeView(),
//   ProjectListView(),
//   ExperienceListView(),
//   ContactView(),
// ];

// class ResponsiveView extends HookConsumerWidget {
//   const ResponsiveView({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedIndex = useState(0);
//     final clickedIndex = useState(0);
//     final pageController = usePageController(initialPage: 0);

//     useEffect(() {
//       if (pageController.hasClients &&
//           clickedIndex.value != selectedIndex.value) {
//         pageController
//             .animateToPage(
//               clickedIndex.value,
//               duration: const Duration(milliseconds: 350),
//               curve: Curves.easeInOut,
//             )
//             .then((_) {
//               selectedIndex.value = clickedIndex.value;
//             });
//       }
//       return null;
//     }, [clickedIndex.value]);

//     return Scaffold(
//       appBar: !context.showRail
//           ? AppBar(
//               backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
//               title: Text(
//                 'Portfolio',
//                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               centerTitle: false,
//             )
//           : null,
//       drawer: CustomDrawer(
//         selectedIndex: selectedIndex.value,
//         onDestinationSelected: (i) {
//           clickedIndex.value = i;
//         },
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             if (context.showRail)
//               CustomNavMenu(
//                 selectedIndex: selectedIndex.value,
//                 onDestinationSelected: (i) {
//                   clickedIndex.value = i;
//                 },
//               ),
//             Expanded(
//               child: PageView.builder(
//                 pageSnapping: true,
//                 controller: pageController,
//                 scrollDirection: Axis.vertical,
//                 itemCount: widgets.length,
//                 itemBuilder: (context, i) {
//                   return ResponsivePadding(child: widgets[i]);
//                 },
//                 onPageChanged: (i) {
//                   if (clickedIndex.value == selectedIndex.value) {
//                     selectedIndex.value = i;
//                     clickedIndex.value = i;
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
