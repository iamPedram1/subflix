import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            destinations: const <NavigationDestination>[
              NavigationDestination(icon: Icon(Iconsax.video), label: 'Home'),
              NavigationDestination(
                icon: Icon(Iconsax.archive),
                label: 'History',
              ),
              NavigationDestination(
                icon: Icon(Iconsax.setting2),
                label: 'Settings',
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
