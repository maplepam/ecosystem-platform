import 'package:emp_ai_ds_northstar/emp_ai_ds_northstar.dart';
import 'package:emp_ai_ds_widgets/src/catalog/widget_catalog_entry.dart';
import 'package:emp_ai_ds_widgets/src/display/northstar_segmented_control.dart';
import 'package:flutter/material.dart';

enum _ViewMode { list, board, timeline }

WidgetCatalogEntry northstarSegmentedControlCatalogEntry() {
  return WidgetCatalogEntry(
    id: 'northstar_segmented_control',
    title: 'NorthstarSegmentedControl',
    description:
        'Figma *Segmented Controls*: 2–5 short labels, **single** selection '
        '(default). Selected segment uses [primaryContainer] / '
        '[onPrimaryContainer]; hover uses [surfaceContainerLow]. '
        'Set [multiSelectionEnabled] for multi-select (advanced).',
    code: '''
  enum View { list, board, timeline }

  NorthstarSegmentedControl<View>(
    segments: const [
      ButtonSegment(value: View.list, label: Text('List')),
      ButtonSegment(value: View.board, label: Text('Board')),
      ButtonSegment(value: View.timeline, label: Text('Timeline')),
    ],
    selected: {current},
    onSelectionChanged: (Set<View> next) {
      setState(() => current = next.single);
    },
    automationId: 'view_switcher',
  )

  // Multi-select (optional)
  NorthstarSegmentedControl<String>(
    segments: const [
      ButtonSegment(value: 'a', label: Text('A')),
      ButtonSegment(value: 'b', label: Text('B')),
    ],
    selected: tags,
    multiSelectionEnabled: true,
    emptySelectionAllowed: true,
    onSelectionChanged: (s) => setState(() => tags = s),
  )
  ''',
    preview: (BuildContext context) => const _NorthstarSegmentedCatalogDemo(),
  );
}

class _NorthstarSegmentedCatalogDemo extends StatefulWidget {
  const _NorthstarSegmentedCatalogDemo();

  @override
  State<_NorthstarSegmentedCatalogDemo> createState() =>
      _NorthstarSegmentedCatalogDemoState();
}

class _NorthstarSegmentedCatalogDemoState
    extends State<_NorthstarSegmentedCatalogDemo> {
  _ViewMode _mode = _ViewMode.list;
  final Set<String> _multi = <String>{'draft'};

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(NorthstarSpacing.space16),
        child: SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('Single selection', style: tt.labelSmall),
              const SizedBox(height: NorthstarSpacing.space8),
              NorthstarSegmentedControl<_ViewMode>(
                segments: const <ButtonSegment<_ViewMode>>[
                  ButtonSegment<_ViewMode>(
                    value: _ViewMode.list,
                    label: Text('List'),
                  ),
                  ButtonSegment<_ViewMode>(
                    value: _ViewMode.board,
                    label: Text('Board'),
                  ),
                  ButtonSegment<_ViewMode>(
                    value: _ViewMode.timeline,
                    label: Text('Timeline'),
                  ),
                ],
                selected: <_ViewMode>{_mode},
                onSelectionChanged: (Set<_ViewMode> s) {
                  setState(() => _mode = s.single);
                },
                automationId: 'cat_seg_view',
              ),
              const SizedBox(height: NorthstarSpacing.space8),
              Text(
                'Active: $_mode',
                style: tt.bodySmall,
              ),
              const SizedBox(height: NorthstarSpacing.space24),
              Text('Multi-select (filters)', style: tt.labelSmall),
              const SizedBox(height: NorthstarSpacing.space8),
              NorthstarSegmentedControl<String>(
                segments: const <ButtonSegment<String>>[
                  ButtonSegment<String>(value: 'draft', label: Text('Draft')),
                  ButtonSegment<String>(value: 'sent', label: Text('Sent')),
                  ButtonSegment<String>(value: 'done', label: Text('Done')),
                ],
                selected: _multi,
                multiSelectionEnabled: true,
                emptySelectionAllowed: true,
                onSelectionChanged: (Set<String> s) => setState(() {
                  _multi
                    ..clear()
                    ..addAll(s);
                }),
                automationId: 'cat_seg_multi',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
