import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:subflix/core/extensions/duration_extensions.dart';
import 'package:subflix/core/providers/repository_providers.dart';
import 'package:subflix/core/styles/colors.dart';
import 'package:subflix/core/ui/icons/iconsax.dart';
import 'package:subflix/core/ui/widgets/app_background.dart';
import 'package:subflix/core/ui/widgets/app_gradient_button.dart';
import 'package:subflix/core/ui/widgets/app_surface_card.dart';
import 'package:subflix/core/ui/widgets/loading_skeleton.dart';
import 'package:subflix/core/ui/widgets/section_header.dart';
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
        TranslationPreviewQuery(
          jobId: widget.jobId,
          query: _committedQuery,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Translation preview')),
      bottomNavigationBar: previewAsync.asData?.value == null
          ? null
          : Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: AppGradientButton(
                label: _isExporting
                    ? 'Exporting...'
                    : 'Export translated subtitle',
                icon: Iconsax.export,
                onPressed: _isExporting
                    ? null
                    : () => _exportJob(previewAsync.asData!.value.job, context),
              ),
            ),
      body: AppBackground(
        child: SafeArea(
          child: previewAsync.when(
            data: (preview) {
              final filteredLines = preview.items;
              final job = preview.job;

              return ListView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
                children: <Widget>[
                  const SectionHeader(
                    title: 'Review translated subtitles',
                    subtitle:
                        'Search inside cues, switch preview modes, then export once the translation looks right.',
                  ),
                  const SizedBox(height: 16),
                  _MetadataCard(job: job),
                  const SizedBox(height: 16),
                  AppSurfaceCard(
                    child: Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SegmentedButton<PreviewMode>(
                          segments: PreviewMode.values
                              .map(
                                (mode) => ButtonSegment<PreviewMode>(
                                  value: mode,
                                  label: Text(mode.label),
                                ),
                              )
                              .toList(growable: false),
                          selected: <PreviewMode>{_previewMode},
                          onSelectionChanged: (selection) {
                            setState(() => _previewMode = selection.first);
                          },
                        ),
                        TextField(
                          onChanged: _onQueryChanged,
                          decoration: InputDecoration(
                            hintText: 'Search subtitle lines',
                            prefixIcon: const Icon(Iconsax.searchNormal),
                            suffixIcon: _query.isEmpty
                                ? null
                                : IconButton(
                                    onPressed: () => _onQueryChanged(''),
                                    icon: const Icon(Iconsax.closeCircle),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (filteredLines.isEmpty)
                    StatePanel(
                      icon: Iconsax.searchNormal,
                      title: _committedQuery.isEmpty
                          ? 'Preview cues are not available yet'
                          : 'No subtitle lines matched',
                      message: _committedQuery.isEmpty
                          ? 'The translation finished, but the backend did not return preview cues yet. Try reloading this screen in a moment.'
                          : 'Try a different search term or clear the filter to inspect the full translation.',
                    )
                  else
                    Column(
                      spacing: 12,
                      children: filteredLines
                          .map(
                            (line) => SubtitleLineCard(
                              line: line,
                              mode: _previewMode,
                            ),
                          )
                          .toList(growable: false),
                    ),
                ],
              );
            },
            error: (error, stackTrace) => Padding(
              padding: const EdgeInsets.all(20),
              child: StatePanel(
                icon: Iconsax.warning2,
                title: 'Preview failed to load',
                message: error.toString(),
                action: OutlinedButton.icon(
                  onPressed: () => ref.invalidate(
                    translationPreviewProvider(
                      TranslationPreviewQuery(
                        jobId: widget.jobId,
                        query: _committedQuery,
                      ),
                    ),
                  ),
                  icon: const Icon(Iconsax.refresh),
                  label: const Text('Retry'),
                ),
              ),
            ),
            loading: () => ListView(
              padding: const EdgeInsets.all(20),
              children: const <Widget>[
                LoadingSkeleton(height: 120),
                SizedBox(height: 16),
                LoadingSkeleton(height: 94),
                SizedBox(height: 16),
                LoadingSkeleton(height: 160),
              ],
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
          content: Text('Exported ${result.fileName} to ${result.path}'),
        ),
      );
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Export failed: $error')));
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }
}

class _MetadataCard extends StatelessWidget {
  const _MetadataCard({required this.job});

  final TranslationJob job;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: <Widget>[
          _MetaTile(label: 'Format', value: job.format.label),
          _MetaTile(label: 'Lines', value: '${job.lineCount}'),
          _MetaTile(
            label: 'Languages',
            value: '${job.sourceLanguage.label} -> ${job.targetLanguage.label}',
          ),
          _MetaTile(
            label: 'Estimated duration',
            value: Duration(milliseconds: job.durationMs).toStatLabel(),
          ),
        ],
      ),
    );
  }
}

class _MetaTile extends StatelessWidget {
  const _MetaTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: AppColors.textMuted),
            ),
            Text(value, style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ),
    );
  }
}
