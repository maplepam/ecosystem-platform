import 'package:emp_ai_ds_northstar/emp_ai_ds_northstar.dart';
import 'package:emp_ai_ds_widgets/src/catalog/widget_catalog_entry.dart';
import 'package:emp_ai_ds_widgets/src/display/northstar_tooltip.dart';
import 'package:flutter/material.dart';

WidgetCatalogEntry northstarTooltipCatalogEntry() {
  return WidgetCatalogEntry(
    id: 'northstar_tooltip',
    title: 'NorthstarTooltip',
    description:
        '**Plain** ([NorthstarPlainTooltip]): [NorthstarTooltipSpecs.plainMaxWidth] max width, '
        'no min width; ≤${NorthstarTooltipSpecs.plainMaxCharacters} characters; optional '
        '[NorthstarTooltipTailPosition] tail. **Rich** ([NorthstarRichTooltip]): '
        '${NorthstarTooltipSpecs.richMinWidth}–${NorthstarTooltipSpecs.richMaxWidth} width, '
        '≤${NorthstarTooltipSpecs.richMaxCharacters} chars for title+body text; optional '
        'title, [leading] icon, or [content] widget. Gap **4** / **8** from [hasVisualBoundary].',
    code: '''
  // Plain — default: no tail (Material), 4px gap with boundary
  NorthstarPlainTooltip(
    message: 'Sorts by last updated.',
    child: IconButton(icon: Icon(Icons.info_outline), onPressed: () {}),
  )

  // Plain — Figma tail under bubble (custom overlay)
  NorthstarPlainTooltip(
    message: 'With tail',
    tailPosition: NorthstarTooltipTailPosition.bottom,
    child: IconButton(icon: Icon(Icons.label), onPressed: () {}),
  )

  // Rich — title + body (Material when tail is none)
  NorthstarRichTooltip(
    title: 'Talent score',
    description: 'Composite from reviews and delivery outcomes.',
    child: Text('Score', style: TextStyle(decoration: TextDecoration.underline)),
  )

  // Rich — custom body + icon (custom overlay)
  NorthstarRichTooltip(
    title: 'Details',
    content: Row(children: [Icon(Icons.star), Text('4.0')]),
    leading: Icon(Icons.person_outline),
    child: Chip(label: Text('Rated')),
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
  bool _plainTightOffset = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(NorthstarSpacing.space16),
        child: SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Plain tooltip', style: tt.labelSmall),
              const SizedBox(height: NorthstarSpacing.space8),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(
                  'verticalOffset 0 (override 4/8 gap)',
                  style: tt.labelLarge,
                ),
                value: _plainTightOffset,
                onChanged: (bool v) => setState(() => _plainTightOffset = v),
              ),
              const SizedBox(height: NorthstarSpacing.space8),
              Wrap(
                spacing: NorthstarSpacing.space12,
                runSpacing: NorthstarSpacing.space12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  NorthstarPlainTooltip(
                    message: 'No tail (Material). Max 200px wide.',
                    verticalOffset:
                        _plainTightOffset ? 0 : null,
                    hasVisualBoundary: !_plainTightOffset,
                    automationId: 'cat_tip_plain_none',
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.view_compact_outlined),
                    ),
                  ),
                  NorthstarPlainTooltip(
                    message: 'Tail bottom',
                    tailPosition: NorthstarTooltipTailPosition.bottom,
                    verticalOffset:
                        _plainTightOffset ? 0 : null,
                    hasVisualBoundary: !_plainTightOffset,
                    automationId: 'cat_tip_plain_tail_b',
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_downward),
                    ),
                  ),
                  NorthstarPlainTooltip(
                    message: 'Tail top',
                    tailPosition: NorthstarTooltipTailPosition.top,
                    verticalOffset:
                        _plainTightOffset ? 0 : null,
                    hasVisualBoundary: !_plainTightOffset,
                    automationId: 'cat_tip_plain_tail_t',
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_upward),
                    ),
                  ),
                  NorthstarPlainTooltip(
                    message: 'Text anchor',
                    verticalOffset:
                        _plainTightOffset ? 0 : null,
                    hasVisualBoundary: !_plainTightOffset,
                    automationId: 'cat_tip_plain_text',
                    child: Text(
                      'Hover label',
                      style: tt.titleSmall?.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor:
                            NorthstarColorTokens.of(context).primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: NorthstarSpacing.space24),
              Text('Rich tooltip', style: tt.labelSmall),
              const SizedBox(height: NorthstarSpacing.space8),
              NorthstarRichTooltip(
                title: 'Talent score',
                description:
                    'Composite from peer reviews, tenure, and delivery outcomes. '
                    'Updated weekly; not a promotion guarantee.',
                automationId: 'cat_tip_rich',
                child: ActionChip(
                  label: const Text('Talent score'),
                  avatar: const Icon(Icons.insights_outlined, size: 18),
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: NorthstarSpacing.space12),
              NorthstarRichTooltip(
                title: 'With leading icon',
                description: 'Short body under the title.',
                leading: const Icon(Icons.info_outline),
                automationId: 'cat_tip_rich_lead',
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Hover'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
