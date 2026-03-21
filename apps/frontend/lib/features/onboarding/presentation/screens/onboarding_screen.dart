import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_gradient_button.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/features/settings/application/settings_controller.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _handleContinue() async {
    final pages = _localizedPages(context);
    if (_pageIndex < pages.length - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 320),
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
          child: ResponsiveCenter(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 8,
                  right: 16,
                  child: TextButton(
                    onPressed: () async {
                      await ref
                          .read(settingsControllerProvider.notifier)
                          .markOnboardingSeen();
                      if (!context.mounted) {
                        return;
                      }
                      context.go(AppRoutes.home);
                    },
                    child: AppText(
                      context.t.onboardingSkip,
                      variant: AppTextVariant.labelLarge,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: pages.length,
                          onPageChanged: (value) =>
                              setState(() => _pageIndex = value),
                          itemBuilder: (context, index) {
                            final page = pages[index];
                            return Padding(
                              padding: const EdgeInsets.only(top: 28),
                              child: Column(
                                children: <Widget>[
                                  const Spacer(),
                                  _IconPanel(
                                        icon: page.icon,
                                        gradient: page.gradient,
                                      )
                                      .animate(key: ValueKey(index))
                                      .fadeIn(duration: 350.ms)
                                      .scale(begin: const Offset(0.92, 0.92)),
                                  const SizedBox(height: 42),
                                  AppText(
                                    page.title,
                                    variant: AppTextVariant.headlineMedium,
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w700,
                                  ).animate().fadeIn(duration: 300.ms),
                                  const SizedBox(height: 14),
                                  AppText(
                                    page.description,
                                    variant: AppTextVariant.bodyLarge,
                                    textAlign: TextAlign.center,
                                    color: AppColors.textSecondaryFor(context),
                                  ),
                                  const SizedBox(height: 24),
                                  ...page.highlights.map(
                                    (highlight) => Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: _HighlightRow(label: highlight),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(
                          pages.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 240),
                            width: _pageIndex == index ? 28 : 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: _pageIndex == index
                                  ? AppColors.primary
                                  : AppColors.textMutedFor(
                                      context,
                                    ).withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      AppGradientButton(
                        label: _pageIndex == pages.length - 1
                            ? context.t.onboardingEnterApp
                            : context.t.onboardingContinue,
                        icon: Icons.arrow_forward_rounded,
                        mirrorIconInRtl: true,
                        onPressed: _handleContinue,
                        fullWidth: true,
                      ),
                    ],
                  ),
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
        title: context.t.onboardingPage1Title,
        description: context.t.onboardingPage1Description,
        icon: Icons.search_rounded,
        gradient: const LinearGradient(
          colors: <Color>[AppColors.primary, AppColors.secondary],
        ),
        highlights: <String>[
          context.t.onboardingPage1Highlight1,
          context.t.onboardingPage1Highlight2,
          context.t.onboardingPage1Highlight3,
        ],
      ),
      _OnboardingPageModel(
        title: context.t.onboardingPage2Title,
        description: context.t.onboardingPage2Description,
        icon: Icons.upload_file_rounded,
        gradient: const LinearGradient(
          colors: <Color>[AppColors.secondary, AppColors.tertiary],
        ),
        highlights: <String>[
          context.t.onboardingPage2Highlight1,
          context.t.onboardingPage2Highlight2,
          context.t.onboardingPage2Highlight3,
        ],
      ),
      _OnboardingPageModel(
        title: context.t.onboardingPage3Title,
        description: context.t.onboardingPage3Description,
        icon: Icons.download_rounded,
        gradient: const LinearGradient(
          colors: <Color>[AppColors.tertiary, Color(0xFFF43F5E)],
        ),
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
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
    required this.highlights,
  });

  final String title;
  final String description;
  final IconData icon;
  final Gradient gradient;
  final List<String> highlights;
}

class _IconPanel extends StatelessWidget {
  const _IconPanel({required this.icon, required this.gradient});

  final IconData icon;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 210,
          height: 210,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[
                AppColors.primary.withValues(alpha: 0.16),
                Colors.transparent,
              ],
            ),
          ),
        ),
        Container(
          width: 156,
          height: 156,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(36),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: gradient.colors.first.withValues(alpha: 0.30),
                blurRadius: 34,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: Icon(icon, size: 72, color: Colors.white),
        ),
      ],
    );
  }
}

class _HighlightRow extends StatelessWidget {
  const _HighlightRow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppInsets.cardCompact,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.check_rounded,
              size: 18,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppText(
              label,
              variant: AppTextVariant.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
