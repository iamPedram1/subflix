import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/styles/colors.dart';
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

  static const List<_OnboardingPageModel> _pages = <_OnboardingPageModel>[
    _OnboardingPageModel(
      eyebrow: 'Search and fetch',
      title: 'Find movies or series and pull ready-to-translate subtitles.',
      description:
          'Search a title, review the available English subtitle sources, and launch a translation workflow that feels instant.',
      icon: Iconsax.searchNormal,
      highlights: <String>[
        'Deterministic mock catalog for reliable development',
        'Subtitle source quality labels and format badges',
        'Built to swap into a real backend later',
      ],
    ),
    _OnboardingPageModel(
      eyebrow: 'Bring your own file',
      title: 'Upload `.srt` or `.vtt` files when you already have the script.',
      description:
          'Import your subtitle file, validate the format, and run the same polished translation pipeline without leaving the app.',
      icon: Iconsax.documentUpload,
      highlights: <String>[
        'Local file validation and graceful retry states',
        'Consistent translation setup for uploads and search',
        'Preview before export so nothing feels opaque',
      ],
    ),
    _OnboardingPageModel(
      eyebrow: 'Translate and export',
      title:
          'Preview, compare, and export subtitles in your preferred language.',
      description:
          'Switch between original, translated, and bilingual views, revisit history, and export clean subtitle files once the result looks right.',
      icon: Iconsax.languageCircle,
      highlights: <String>[
        'Fast preview controls with metadata and search',
        'History keeps previous jobs a tap away',
        'Designed like a premium media tool, not a demo',
      ],
    ),
  ];

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
    if (_pageIndex < _pages.length - 1) {
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
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
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
                    itemCount: _pages.length,
                    onPageChanged: (value) =>
                        setState(() => _pageIndex = value),
                    itemBuilder: (context, index) {
                      final page = _pages[index];
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
                    _pages.length,
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
                  label: _pageIndex == _pages.length - 1
                      ? 'Enter SubFlix'
                      : 'Continue',
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
