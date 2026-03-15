import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';

class HomeShell extends StatelessWidget {
  const HomeShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            destinations: <NavigationDestination>[
              NavigationDestination(
                icon: const Icon(Iconsax.video),
                label: context.t.navHome,
              ),
              NavigationDestination(
                icon: const Icon(Iconsax.archive),
                label: context.t.navHistory,
              ),
              NavigationDestination(
                icon: const Icon(Iconsax.setting2),
                label: context.t.navSettings,
              ),
            ],
            onDestinationSelected: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
            backgroundColor: AppColors.surface.withValues(alpha: 0.95),
          ),
        ),
      ),
    );
  }
}
