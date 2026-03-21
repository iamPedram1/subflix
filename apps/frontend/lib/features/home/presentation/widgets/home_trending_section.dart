import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:subflix/core/app/router/app_routes.dart';
import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/widgets/app_text.dart';

class HomeTrendingSection extends StatelessWidget {
  const HomeTrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _TrendingHeader(),
        SizedBox(height: 12),
        _TrendingRow(),
      ],
    );
  }
}

class _TrendingHeader extends StatelessWidget {
  const _TrendingHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(Icons.trending_up_rounded, color: AppColors.primary),
        const SizedBox(width: 8),
        AppText(
          context.t.homeTrendingNow,
          variant: AppTextVariant.titleLarge,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}

class _TrendingRow extends StatelessWidget {
  const _TrendingRow();

  @override
  Widget build(BuildContext context) {
    const items = <_TrendingItem>[
      _TrendingItem(
        title: 'Oppenheimer',
        subtitle: 'movie',
        image:
            'https://images.unsplash.com/photo-1756412955475-7e1ed16869af?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtb3ZpZSUyMHBvc3RlciUyMGNvbGxlY3Rpb258ZW58MXx8fHwxNzczNjkwNzc1fDA&ixlib=rb-4.1.0&q=80&w=1080',
      ),
      _TrendingItem(
        title: 'The Last of Us',
        subtitle: 'series',
        image:
            'https://images.unsplash.com/photo-1705123898140-11c516829f4c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx0diUyMHNlcmllcyUyMHNjcmVlbnxlbnwxfHx8fDE3NzM2ODQyMDB8MA&ixlib=rb-4.1.0&q=80&w=1080',
      ),
      _TrendingItem(
        title: 'Dune: Part Two',
        subtitle: 'movie',
        image:
            'https://images.unsplash.com/photo-1659497379075-a807be116f74?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmaWxtJTIwcmVlbCUyMGNpbmVtYXxlbnwxfHx8fDE3NzM2OTA3NzV8MA&ixlib=rb-4.1.0&q=80&w=1080',
      ),
    ];

    return SizedBox(
      height: 198,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) =>
            _TrendingPosterCard(item: items[index]),
      ),
    );
  }
}

class _TrendingPosterCard extends StatelessWidget {
  const _TrendingPosterCard({required this.item});

  final _TrendingItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(AppRoutes.search),
      borderRadius: BorderRadius.circular(18),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: SizedBox(
          width: 128,
          height: 192,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.network(
                item.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: AppColors.surfaceMutedFor(context)),
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.transparent,
                      Color(0x26000000),
                      Color(0xCC000000),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppText(
                      item.title,
                      variant: AppTextVariant.labelLarge,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    AppText(
                      item.subtitle,
                      variant: AppTextVariant.bodySmall,
                      color: Colors.white.withValues(alpha: 0.66),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrendingItem {
  const _TrendingItem({
    required this.title,
    required this.subtitle,
    required this.image,
  });

  final String title;
  final String subtitle;
  final String image;
}
