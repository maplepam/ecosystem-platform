import 'package:emp_ai_ds_northstar/emp_ai_ds_northstar.dart';
import 'package:emp_ai_ds_widgets/src/catalog/widget_catalog_entry.dart';
import 'package:emp_ai_ds_widgets/src/display/northstar_slider.dart';
import 'package:flutter/material.dart';

WidgetCatalogEntry northstarSliderCatalogEntry() {
  return WidgetCatalogEntry(
    id: 'northstar_slider',
    title: 'NorthstarSlider',
    description:
        'Figma *Atoms: Sliders*. **Continuous** (no divisions) vs **discrete** '
        '(tick marks via [divisions]). Active track + thumb use '
        '[NorthstarColorTokens.primary]; inactive [surfaceContainerHigh]. '
        '[showValueIndicator] shows the Material value label while dragging. '
        '[onChanged] null → disabled state.',
    code: '''
  // Continuous 0–100
  NorthstarSlider(
    value: volume,
    onChanged: (v) => setState(() => volume = v),
    showValueIndicator: true,
    automationId: 'volume',
  )

  // Discrete (e.g. steps 0,25,50,75,100 → divisions: 4)
  NorthstarSlider(
    value: level,
    divisions: 4,
    onChanged: (v) => setState(() => level = v),
    showValueIndicator: true,
    automationId: 'level',
  )

  // Disabled
  NorthstarSlider(
    value: 40,
    onChanged: null,
    automationId: 'locked',
  )

  // Custom numeric range
  NorthstarSlider(
    value: warmth,
    min: 2700,
    max: 6500,
    onChanged: (v) => setState(() => warmth = v),
  )
  ''',
    preview: (BuildContext context) => const _NorthstarSliderCatalogDemo(),
  );
}

class _NorthstarSliderCatalogDemo extends StatefulWidget {
  const _NorthstarSliderCatalogDemo();

  @override
  State<_NorthstarSliderCatalogDemo> createState() =>
      _NorthstarSliderCatalogDemoState();
}

class _NorthstarSliderCatalogDemoState extends State<_NorthstarSliderCatalogDemo> {
  double _continuous = 35;
  double _discrete = 50;
  bool _showIndicator = true;
  bool _disabled = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(NorthstarSpacing.space16),
        child: SizedBox(
          width: 360,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Value indicator while drag', style: tt.labelLarge),
                value: _showIndicator,
                onChanged: (bool v) => setState(() => _showIndicator = v),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Disable continuous slider', style: tt.labelLarge),
                value: _disabled,
                onChanged: (bool v) => setState(() => _disabled = v),
              ),
              const SizedBox(height: NorthstarSpacing.space8),
              Text(
                'Continuous (${_continuous.round()})',
                style: tt.labelSmall,
              ),
              NorthstarSlider(
                value: _continuous,
                showValueIndicator: _showIndicator,
                onChanged: _disabled
                    ? null
                    : (double v) => setState(() => _continuous = v),
                automationId: 'cat_slider_cont',
              ),
              const SizedBox(height: NorthstarSpacing.space24),
              Text(
                'Discrete 0–100 (divisions: 4)',
                style: tt.labelSmall,
              ),
              NorthstarSlider(
                value: _discrete,
                divisions: 4,
                showValueIndicator: _showIndicator,
                onChanged: (double v) => setState(() => _discrete = v),
                automationId: 'cat_slider_disc',
              ),
              const SizedBox(height: NorthstarSpacing.space24),
              Text('Static disabled', style: tt.labelSmall),
              NorthstarSlider(
                value: 60,
                onChanged: null,
                automationId: 'cat_slider_off',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
