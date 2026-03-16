import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_gradient_button.dart';
import 'package:subflix/core/ui/widgets/subflix_wordmark.dart';
import 'package:subflix/features/onboarding/presentation/widgets/onboarding_page_card.dart';
import 'package:subflix/features/settings/application/settings_controller.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _handleContinue() async {
    final totalPages = _localizedPages(context).length;
    if (_pageIndex < totalPages - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
      return;
    }

    await ref.read(settingsControllerProvider.notifier).markOnboardingSeen();
    if (!mounted) {
      return;
    }
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final pages = _localizedPages(context);
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: AppInsets.page,
            child: Column(
              spacing: 24,
              children: <Widget>[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: SubflixWordmark(compact: true),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: pages.length,
                    onPageChanged: (value) =>
                        setState(() => _pageIndex = value),
                    itemBuilder: (context, index) {
                      final page = pages[index];
                      return OnboardingPageCard(
                        eyebrow: page.eyebrow,
                        title: page.title,
                        description: page.description,
                        icon: page.icon,
                        highlights: page.highlights,
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: List<Widget>.generate(
                    pages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      width: _pageIndex == index ? 28 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _pageIndex == index
                            ? AppColors.primary
                            : Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                ),
                AppGradientButton(
                  label: _pageIndex == pages.length - 1
                      ? context.t.onboardingEnterApp
                      : context.t.onboardingContinue,
                  icon: Iconsax.arrowRight,
                  onPressed: _handleContinue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<_OnboardingPageModel> _localizedPages(BuildContext context) {
    return <_OnboardingPageModel>[
      _OnboardingPageModel(
        eyebrow: context.t.onboardingPage1Eyebrow,
        title: context.t.onboardingPage1Title,
        description: context.t.onboardingPage1Description,
        icon: Iconsax.searchNormal,
        highlights: <String>[
          context.t.onboardingPage1Highlight1,
          context.t.onboardingPage1Highlight2,
          context.t.onboardingPage1Highlight3,
        ],
      ),
      _OnboardingPageModel(
        eyebrow: context.t.onboardingPage2Eyebrow,
        title: context.t.onboardingPage2Title,
        description: context.t.onboardingPage2Description,
        icon: Iconsax.documentUpload,
        highlights: <String>[
          context.t.onboardingPage2Highlight1,
          context.t.onboardingPage2Highlight2,
          context.t.onboardingPage2Highlight3,
        ],
      ),
      _OnboardingPageModel(
        eyebrow: context.t.onboardingPage3Eyebrow,
        title: context.t.onboardingPage3Title,
        description: context.t.onboardingPage3Description,
        icon: Iconsax.languageCircle,
        highlights: <String>[
          context.t.onboardingPage3Highlight1,
          context.t.onboardingPage3Highlight2,
          context.t.onboardingPage3Highlight3,
        ],
      ),
    ];
  }
}

class _OnboardingPageModel {
  const _OnboardingPageModel({
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.icon,
    required this.highlights,
  });

  final String eyebrow;
  final String title;
  final String description;
  final IconData icon;
  final List<String> highlights;
}
