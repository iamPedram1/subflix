import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:subflix/core/localization/app_localizations.dart';
import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/styles/spacing.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/responsive_center.dart';
import 'package:subflix/core/ui/widgets/state_panel.dart';
import 'package:subflix/features/shared/domain/models/translation_job.dart';
import 'package:subflix/features/subtitles/application/translation_preview_provider.dart';
import 'package:subflix/features/subtitles/application/translation_preview_query.dart';
import 'package:subflix/features/subtitles/presentation/widgets/subtitle_line_card.dart';

class TranslationPreviewScreen extends ConsumerStatefulWidget {
  const TranslationPreviewScreen({required this.jobId, super.key});

  final String jobId;

  @override
  ConsumerState<TranslationPreviewScreen> createState() =>
      _TranslationPreviewScreenState();
}

class _TranslationPreviewScreenState
    extends ConsumerState<TranslationPreviewScreen> {
  PreviewMode _previewMode = PreviewMode.bilingual;
  String _query = '';
  String _committedQuery = '';
  bool _isExporting = false;
  Timer? _searchDebounce;

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final previewAsync = ref.watch(
      translationPreviewProvider(
        TranslationPreviewQuery(jobId: widget.jobId, query: _committedQuery),
      ),
    );

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: ResponsiveCenter(
            child: previewAsync.when(
              data: (preview) {
                final lines = preview.items;
                final job = preview.job;

                return Column(
                  children: <Widget>[
                    _PreviewHeader(
                      job: job,
                      query: _query,
                      onBack: () => Navigator.of(context).pop(),
                      onQueryChanged: _onQueryChanged,
                      onClear: () => _onQueryChanged(''),
                      onExport: _isExporting
                          ? null
                          : () => _exportJob(job, context),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                        children: <Widget>[
                          _ModeToggle(
                            mode: _previewMode,
                            onChanged: (mode) =>
                                setState(() => _previewMode = mode),
                          ),
                          const SizedBox(height: 16),
                          _PreviewInfo(mode: _previewMode),
                          const SizedBox(height: 16),
                          if (lines.isEmpty)
                            StatePanel(
                              icon: Icons.search_off_rounded,
                              title: _committedQuery.isEmpty
                                  ? context.t.previewNotReadyTitle
                                  : context.t.previewNoMatchesTitle,
                              message: _committedQuery.isEmpty
                                  ? context.t.previewNotReadyMessage
                                  : context.t.previewNoMatchesMessage,
                            )
                          else
                            ...lines.map(
                              (line) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: SubtitleLineCard(
                                  line: line,
                                  mode: _previewMode,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              error: (error, stackTrace) => ListView(
                padding: AppInsets.page,
                children: <Widget>[
                  const SizedBox(height: 40),
                  StatePanel(
                    icon: Icons.error_outline_rounded,
                    title: context.t.previewFailedTitle,
                    message: '$error',
                    action: OutlinedButton.icon(
                      onPressed: () => ref.invalidate(
                        translationPreviewProvider(
                          TranslationPreviewQuery(
                            jobId: widget.jobId,
                            query: _committedQuery,
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.refresh_rounded),
                      label: Text(context.t.retry),
                    ),
                  ),
                ],
              ),
              loading: () => ListView(
                padding: AppInsets.page,
                children: const <Widget>[
                  LoadingSkeleton(height: 140),
                  SizedBox(height: 12),
                  LoadingSkeleton(height: 80),
                  SizedBox(height: 12),
                  LoadingSkeleton(height: 180),
                  SizedBox(height: 12),
                  LoadingSkeleton(height: 180),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onQueryChanged(String value) {
    _searchDebounce?.cancel();
    setState(() => _query = value);
    _searchDebounce = Timer(const Duration(milliseconds: 180), () {
      if (!mounted) {
        return;
      }
      setState(() => _committedQuery = value.trim());
    });
  }

  Future<void> _exportJob(TranslationJob job, BuildContext context) async {
    setState(() => _isExporting = true);
    try {
      final result = await ref
          .read(subtitleExportRepositoryProvider)
          .exportJob(job);
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.t.exportedSnack(result.fileName, result.path)),
        ),
      );
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.t.exportFailedSnack('$error'))),
      );
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }
}

class _PreviewHeader extends StatelessWidget {
  const _PreviewHeader({
    required this.job,
    required this.query,
    required this.onBack,
    required this.onQueryChanged,
    required this.onClear,
    required this.onExport,
  });

  final TranslationJob job;
  final String query;
  final VoidCallback onBack;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onClear;
  final VoidCallback? onExport;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).scaffoldBackgroundColor.withValues(alpha: 0.94),
        border: Border(
          bottom: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back_rounded),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      context.t.translationPreviewTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      job.title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondaryFor(context),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onExport,
                style: IconButton.styleFrom(backgroundColor: AppColors.primary),
                icon: const Icon(Icons.download_rounded, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            onChanged: onQueryChanged,
            decoration: InputDecoration(
              hintText: context.t.translationPreviewSearchHint,
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: query.isEmpty
                  ? null
                  : IconButton(
                      onPressed: onClear,
                      icon: const Icon(Icons.close_rounded),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeToggle extends StatelessWidget {
  const _ModeToggle({required this.mode, required this.onChanged});

  final PreviewMode mode;
  final ValueChanged<PreviewMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: PreviewMode.values
          .map(
            (item) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: item == PreviewMode.values.last ? 0 : 8,
                ),
                child: ChoiceChip(
                  selected: item == mode,
                  label: SizedBox(
                    width: double.infinity,
                    child: Text(
                      item.label(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onSelected: (_) => onChanged(item),
                ),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _PreviewInfo extends StatelessWidget {
  const _PreviewInfo({required this.mode});

  final PreviewMode mode;

  @override
  Widget build(BuildContext context) {
    final message = switch (mode) {
      PreviewMode.bilingual => context.t.translationPreviewSubtitle,
      PreviewMode.original => context.t.previewModeOriginal,
      PreviewMode.translated => context.t.previewModeTranslated,
    };

    return Container(
      padding: AppInsets.card,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            AppColors.primary.withValues(alpha: 0.10),
            AppColors.secondary.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.translate_rounded, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondaryFor(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
