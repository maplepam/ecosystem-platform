import 'package:emp_ai_ds_northstar/emp_ai_ds_northstar.dart';
import 'package:emp_ai_ds_widgets/src/catalog/widget_catalog_entry.dart';
import 'package:emp_ai_ds_widgets/src/display/northstar_tooltip.dart';
import 'package:flutter/material.dart';

WidgetCatalogEntry northstarTooltipCatalogEntry() {
  return WidgetCatalogEntry(
    id: 'northstar_tooltip',
    title: 'NorthstarTooltip',
    description:
        '**Plain**: max ${NorthstarTooltipSpecs.plainMaxWidth}px wide, no min; '
        '≤${NorthstarTooltipSpecs.plainMaxCharacters} chars recommended; '
        '[NorthstarTooltipTailPosition]. **Rich**: '
        '${NorthstarTooltipSpecs.richMinWidth}–${NorthstarTooltipSpecs.richMaxWidth}px; '
        '≤${NorthstarTooltipSpecs.richMaxCharacters} chars (title+body). '
        '**Gap**: [hasVisualBoundary] true → ${NorthstarTooltipSpecs.gapWithBoundary}px '
        '(button-like); false → ${NorthstarTooltipSpecs.gapWithoutBoundary}px (text). '
        'Use [verticalOffset] only to override that default.',
    code: '''
  // 4 px gap — icon button has a visible boundary (default hasVisualBoundary: true)
  NorthstarPlainTooltip(
    message: 'Sorts by date.',
    child: IconButton(icon: Icon(Icons.info_outline), onPressed: () {}),
  )

  // 8 px gap — underline text, no box (set hasVisualBoundary: false)
  NorthstarPlainTooltip(
    message: 'Helper text',
    hasVisualBoundary: false,
    child: Text('Hover', style: TextStyle(decoration: TextDecoration.underline)),
  )

  NorthstarPlainTooltip(
    message: 'With tail',
    tailPosition: NorthstarTooltipTailPosition.bottom,
    child: IconButton(icon: Icon(Icons.label), onPressed: () {}),
  )

  NorthstarRichTooltip(
    title: 'Talent score',
    description: 'Composite from reviews and outcomes.',
    child: Text('Score', style: TextStyle(decoration: TextDecoration.underline)),
  )
  ''',
    preview: (BuildContext context) => const _NorthstarTooltipCatalogDemo(),
  );
}

class _NorthstarTooltipCatalogDemo extends StatefulWidget {
  const _NorthstarTooltipCatalogDemo();

  @override
  State<_NorthstarTooltipCatalogDemo> createState() =>
      _NorthstarTooltipCatalogDemoState();
}

class _NorthstarTooltipCatalogDemoState extends State<_NorthstarTooltipCatalogDemo> {
  NorthstarTooltipTailPosition _plainTail = NorthstarTooltipTailPosition.none;

  /// Stays within [NorthstarTooltipSpecs.plainMaxCharacters]; still wraps near 200px width.
  static const String _plainNearMaxWidthThreeLines =
      'Max 200px width; extra words wrap onto more lines here.';

  /// Three lines (newlines); with title stays within the 150-char guideline.
  static const String _richNearMaxWidthThreeLines =
      'Near 350 px max, first line of rich body.\n'
      'Second line continues the catalog sample.\n'
      'Third line; keeps char limit with title.';

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final ColorScheme cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(NorthstarSpacing.space16),
        child: SizedBox(
          width: 440,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Spacing (Figma)', style: tt.titleSmall),
              const SizedBox(height: NorthstarSpacing.space4),
              Text(
                'Use hasVisualBoundary: true (default) for controls with a visible '
                'box — gap is ${NorthstarTooltipSpecs.gapWithBoundary}px above the '
                'anchor. Use false for plain text or baseline anchors — gap is '
                '${NorthstarTooltipSpecs.gapWithoutBoundary}px. '
                'verticalOffset only overrides those defaults if you need a custom gap.',
                style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: NorthstarSpacing.space12),
              Wrap(
                spacing: NorthstarSpacing.space24,
                runSpacing: NorthstarSpacing.space12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '${NorthstarTooltipSpecs.gapWithBoundary}px — button',
                        style: tt.labelMedium,
                      ),
                      Text(
                        'hasVisualBoundary: true (default)',
                        style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
                      ),
                      const SizedBox(height: NorthstarSpacing.space8),
                      NorthstarPlainTooltip(
                        message: 'Four pixel gap above this icon button.',
                        hasVisualBoundary: true,
                        automationId: 'cat_tip_gap_4',
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.touch_app_outlined),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '${NorthstarTooltipSpecs.gapWithoutBoundary}px — text',
                        style: tt.labelMedium,
                      ),
                      Text(
                        'hasVisualBoundary: false',
                        style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
                      ),
                      const SizedBox(height: NorthstarSpacing.space8),
                      NorthstarPlainTooltip(
                        message: 'Eight pixel gap above this text anchor.',
                        hasVisualBoundary: false,
                        automationId: 'cat_tip_gap_8',
                        child: Text(
                          'Hover this label',
                          style: tt.titleSmall?.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor:
                                NorthstarColorTokens.of(context).primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: NorthstarSpacing.space24),
              Text('Plain — tail position', style: tt.titleSmall),
              const SizedBox(height: NorthstarSpacing.space4),
              Text(
                'Choose a tail; the icon button below updates. none uses Material '
                'Tooltip; other values use the custom bubble.',
                style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: NorthstarSpacing.space8),
              Wrap(
                spacing: NorthstarSpacing.space8,
                runSpacing: NorthstarSpacing.space8,
                children: <Widget>[
                  for (final NorthstarTooltipTailPosition p
                      in NorthstarTooltipTailPosition.values)
                    ChoiceChip(
                      label: Text(_tailLabel(p)),
                      selected: _plainTail == p,
                      onSelected: (_) => setState(() => _plainTail = p),
                    ),
                ],
              ),
              const SizedBox(height: NorthstarSpacing.space12),
              NorthstarPlainTooltip(
                key: ValueKey<NorthstarTooltipTailPosition>(_plainTail),
                tailPosition: _plainTail,
                message: 'Tail: ${_tailLabel(_plainTail)}',
                automationId: 'cat_tip_tail_demo',
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.all(NorthstarSpacing.space8),
                      child: Icon(Icons.arrow_drop_up),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: NorthstarSpacing.space24),
              Text('Plain — hug small content', style: tt.titleSmall),
              const SizedBox(height: NorthstarSpacing.space8),
              NorthstarPlainTooltip(
                message: 'OK',
                automationId: 'cat_tip_plain_hug',
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.check_circle_outline),
                ),
              ),
              const SizedBox(height: NorthstarSpacing.space24),
              Text(
                'Plain — near max ${NorthstarTooltipSpecs.plainMaxWidth}px, ~3 lines',
                style: tt.titleSmall,
              ),
              const SizedBox(height: NorthstarSpacing.space4),
              Text(
                'Stays within ${NorthstarTooltipSpecs.plainMaxCharacters} chars; width still drives wrap.',
                style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: NorthstarSpacing.space8),
              NorthstarPlainTooltip(
                message: _plainNearMaxWidthThreeLines,
                automationId: 'cat_tip_plain_max',
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.format_align_left),
                ),
              ),
              const SizedBox(height: NorthstarSpacing.space24),
              Text('Rich — short copy (min ${NorthstarTooltipSpecs.richMinWidth}px width)',
                  style: tt.titleSmall),
              const SizedBox(height: NorthstarSpacing.space4),
              Text(
                'Width never goes below ${NorthstarTooltipSpecs.richMinWidth}px even when '
                'title and body are very short (“hug” above that floor).',
                style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: NorthstarSpacing.space8),
              NorthstarRichTooltip(
                title: 'Note',
                description: 'Short.',
                automationId: 'cat_tip_rich_hug',
                child: ActionChip(
                  label: const Text('Tiny chip'),
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: NorthstarSpacing.space24),
              Text(
                'Rich — near max ${NorthstarTooltipSpecs.richMaxWidth}px, ~3 lines',
                style: tt.titleSmall,
              ),
              const SizedBox(height: NorthstarSpacing.space8),
              NorthstarRichTooltip(
                title: 'Talent score : 90%',
                description: _richNearMaxWidthThreeLines,
                automationId: 'cat_tip_rich_max',
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Wide rich tooltip'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _tailLabel(NorthstarTooltipTailPosition p) {
    return switch (p) {
      NorthstarTooltipTailPosition.none => 'none',
      NorthstarTooltipTailPosition.top => 'top',
      NorthstarTooltipTailPosition.right => 'right',
      NorthstarTooltipTailPosition.bottom => 'bottom',
      NorthstarTooltipTailPosition.left => 'left',
    };
  }
}
