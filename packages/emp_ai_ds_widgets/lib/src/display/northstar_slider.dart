import 'package:emp_ai_ds_northstar/emp_ai_ds_northstar.dart';
import 'package:emp_ai_ds_widgets/src/testing/ds_automation_keys.dart';
import 'package:flutter/material.dart';

/// Northstar **Slider** (*Atoms: Sliders* — continuous or discrete).
///
/// Active segment and thumb use [NorthstarColorTokens.primary]; inactive track
/// uses [NorthstarColorTokens.surfaceContainerHigh]. Focus/drag **halo** uses
/// primary at ~18% opacity. Optional **value indicator** while interacting when
/// [showValueIndicator] is true. [onChanged] `null` → disabled (muted colors).
///
/// Prefer [divisions] for discrete steps (tick marks). Typical range **0–100**
/// matches Figma examples.
class NorthstarSlider extends StatelessWidget {
  const NorthstarSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 100,
    this.divisions,
    this.showValueIndicator = false,
    this.automationId,
  });

  final double value;
  final ValueChanged<double>? onChanged;

  /// Inclusive bounds.
  final double min;
  final double max;

  /// Non-null → discrete slider with tick marks.
  final int? divisions;

  /// Material value indicator (paddle) while dragging / focused.
  final bool showValueIndicator;

  final String? automationId;

  @override
  Widget build(BuildContext context) {
    final NorthstarColorTokens ns = NorthstarColorTokens.of(context);
    final ThemeData theme = Theme.of(context);
    final bool enabled = onChanged != null;
    final Color active = enabled ? ns.primary : ns.outlineVariant;
    final Color inactive =
        enabled ? ns.surfaceContainerHigh : ns.surfaceContainerLow;
    final double clamped = value.clamp(min, max).toDouble();

    final ShowValueIndicator indicator = !enabled || !showValueIndicator
        ? ShowValueIndicator.never
        : (divisions != null
            ? ShowValueIndicator.onlyForDiscrete
            : ShowValueIndicator.onlyForContinuous);

    final SliderThemeData base = SliderTheme.of(context);
    final SliderThemeData themed = base.copyWith(
      trackHeight: 4,
      activeTrackColor: active,
      inactiveTrackColor: inactive,
      thumbColor: active,
      overlayColor: enabled ? ns.primary.withValues(alpha: 0.18) : Colors.transparent,
      valueIndicatorColor: ns.primary,
      valueIndicatorTextStyle: theme.textTheme.labelSmall?.copyWith(
        color: ns.onPrimary,
        fontWeight: FontWeight.w600,
      ),
      showValueIndicator: indicator,
      tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 2),
      activeTickMarkColor: inactive,
      inactiveTickMarkColor: inactive.withValues(alpha: 0.55),
    );

    return KeyedSubtree(
      key: DsAutomationKeys.part(automationId, DsAutomationKeys.elementSlider),
      child: SliderTheme(
        data: themed,
        child: Slider(
          value: clamped,
          min: min,
          max: max,
          divisions: divisions,
          label: showValueIndicator && enabled ? '${clamped.round()}' : null,
          semanticFormatterCallback: (double v) => '${v.round()}',
          onChanged: onChanged,
        ),
      ),
    );
  }
}
