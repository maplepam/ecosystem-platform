import 'package:emp_ai_ds_northstar/emp_ai_ds_northstar.dart';
import 'package:emp_ai_ds_widgets/src/testing/ds_automation_keys.dart';
import 'package:flutter/material.dart';

/// Northstar **segmented control** — [SegmentedButton] with token colors (*Segmented Controls* spec).
///
/// Single selection: keep [multiSelectionEnabled] false (default). Prefer **2–5**
/// segments; labels should be short. Selected segment uses
/// [NorthstarColorTokens.primaryContainer] / [onPrimaryContainer]; dividers use
/// [outlineVariant].
class NorthstarSegmentedControl<T extends Object> extends StatelessWidget {
  const NorthstarSegmentedControl({
    super.key,
    required this.segments,
    required this.selected,
    required this.onSelectionChanged,
    this.multiSelectionEnabled = false,
    this.emptySelectionAllowed = false,
    this.showSelectedIcon = false,
    this.automationId,
  });

  final List<ButtonSegment<T>> segments;
  final Set<T> selected;
  final void Function(Set<T> newSelection) onSelectionChanged;

  final bool multiSelectionEnabled;
  final bool emptySelectionAllowed;
  final bool showSelectedIcon;

  final String? automationId;

  @override
  Widget build(BuildContext context) {
    final NorthstarColorTokens ns = NorthstarColorTokens.of(context);
    final ThemeData theme = Theme.of(context);

    final ButtonStyle style = ButtonStyle(
      visualDensity: VisualDensity.compact,
      side: WidgetStateProperty.all(BorderSide(color: ns.outlineVariant)),
      padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(
          horizontal: NorthstarSpacing.space16,
          vertical: NorthstarSpacing.space8,
        ),
      ),
      textStyle: WidgetStatePropertyAll<TextStyle?>(theme.textTheme.labelLarge),
      backgroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> s) {
        if (s.contains(WidgetState.selected)) {
          return ns.primaryContainer;
        }
        if (s.contains(WidgetState.hovered) ||
            s.contains(WidgetState.focused)) {
          return ns.surfaceContainerLow;
        }
        return Colors.transparent;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> s) {
        if (s.contains(WidgetState.selected)) {
          return ns.onPrimaryContainer;
        }
        return ns.onSurface;
      }),
    );

    return KeyedSubtree(
      key: DsAutomationKeys.part(
        automationId,
        DsAutomationKeys.elementSegmentedControl,
      ),
      child: SegmentedButton<T>(
        segments: segments,
        selected: selected,
        onSelectionChanged: onSelectionChanged,
        multiSelectionEnabled: multiSelectionEnabled,
        emptySelectionAllowed: emptySelectionAllowed,
        showSelectedIcon: showSelectedIcon,
        style: style,
      ),
    );
  }
}
