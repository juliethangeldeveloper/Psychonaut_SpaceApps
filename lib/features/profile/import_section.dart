import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../data/profile_repository.dart';
import '../../l10n/l10n.dart';
import '../../theme/app_theme.dart';
import '../../theme/components.dart';
import '../../theme/tokens.dart';

/// Import a different person's profile from a JSON file, with no code changes.
class ImportSection extends ConsumerStatefulWidget {
  const ImportSection({super.key});

  @override
  ConsumerState<ImportSection> createState() => _ImportSectionState();
}

class _ImportSectionState extends ConsumerState<ImportSection> {
  String? _error;
  bool _busy = false;

  Future<void> _import() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final text = await ref.read(profileFilePickerProvider)(
        context.l10n.importPickerTitle,
      );
      if (text == null) return;
      final profile = parseProfileFile(text);
      await ref.read(profileProvider.notifier).set(profile);
      ref.read(selectedIndicatorProvider.notifier).select(null);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.importDone(profile.displayName))),
        );
      }
    } on FormatException catch (e) {
      setState(
        () => _error = e.message == notJsonMessage
            ? context.l10n.importNotJson
            : e.message,
      );
    } catch (_) {
      setState(() => _error = context.l10n.importUnreadable);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.importTitle, style: AppText.section()),
        const SizedBox(height: 4),
        Text(context.l10n.importHint, style: AppText.caption()),
        const SizedBox(height: AppSpacing.gap),
        OutlinedButton.icon(
          onPressed: _busy ? null : _import,
          icon: const Icon(Icons.upload_file),
          label: Text(context.l10n.importButton),
        ),
        if (_error != null) ...[
          const SizedBox(height: AppSpacing.gap),
          Semantics(
            liveRegion: true,
            child: AppCard(
              borderColor: AppColors.alert,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.error_outline, color: AppColors.alert),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      context.l10n.importFailed(_error!),
                      style: AppText.body(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
