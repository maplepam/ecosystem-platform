import 'package:emp_ai_ds_northstar/emp_ai_ds_northstar.dart';
import 'package:emp_ai_ds_widgets/src/catalog/widget_catalog_entry.dart';
import 'package:emp_ai_ds_widgets/src/display/northstar_tab_bar.dart';
import 'package:flutter/material.dart';

WidgetCatalogEntry northstarTabBarCatalogEntry() {
  return WidgetCatalogEntry(
    id: 'northstar_tab_bar',
    title: 'NorthstarTabBar',
    description:
        'Figma *Tabs*: primary **underline** indicator, full-width **divider**, '
        'sentence-case labels. Build tabs with [NorthstarTabBar.tab] for optional '
        '**icon** and **badgeCount** `(n)`. Use [isScrollable] for many tabs or '
        'narrow width. Pair with [TabBarView] and [DefaultTabController]. '
        'Prefer ≤7 tabs for IA clarity.',
    code: '''
  DefaultTabController(
    length: 3,
    child: Column(
      children: [
        NorthstarTabBar(
          controller: DefaultTabController.of(context),
          tabs: [
            NorthstarTabBar.tab(label: 'Profile'),
            NorthstarTabBar.tab(label: 'Inbox', badgeCount: 12),
            NorthstarTabBar.tab(
              label: 'Files',
              icon: Icons.folder_outlined,
            ),
          ],
          automationId: 'main_tabs',
        ),
        Expanded(
          child: TabBarView(
            controller: DefaultTabController.of(context),
            children: [ /* … */ ],
          ),
        ),
      ],
    ),
  )

  // Scrollable row (many tabs / mobile)
  NorthstarTabBar(
    controller: c,
    isScrollable: true,
    tabs: List.generate(8, (i) => NorthstarTabBar.tab(label: 'Tab \${i + 1}')),
  )
  ''',
    preview: (BuildContext context) => const _NorthstarTabBarCatalogDemo(),
  );
}

class _NorthstarTabBarCatalogDemo extends StatefulWidget {
  const _NorthstarTabBarCatalogDemo();

  @override
  State<_NorthstarTabBarCatalogDemo> createState() =>
      _NorthstarTabBarCatalogDemoState();
}

class _NorthstarTabBarCatalogDemoState extends State<_NorthstarTabBarCatalogDemo> {
  bool _scrollable = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final int length = _scrollable ? 8 : 3;

    return DefaultTabController(
      key: ValueKey<bool>(_scrollable),
      length: length,
      child: Builder(
        builder: (BuildContext context) {
          final TabController c = DefaultTabController.of(context);
          return Padding(
            padding: const EdgeInsets.all(NorthstarSpacing.space16),
            child: SizedBox(
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Scrollable (8 tabs)', style: tt.labelLarge),
                    value: _scrollable,
                    onChanged: (bool v) => setState(() => _scrollable = v),
                  ),
                  const SizedBox(height: NorthstarSpacing.space8),
                  NorthstarTabBar(
                    controller: c,
                    isScrollable: _scrollable,
                    tabs: _scrollable
                        ? List<Tab>.generate(
                            8,
                            (int i) =>
                                NorthstarTabBar.tab(label: 'Section ${i + 1}'),
                          )
                        : <Tab>[
                            NorthstarTabBar.tab(label: 'Profile'),
                            NorthstarTabBar.tab(
                              label: 'Work experience',
                              badgeCount: 23,
                            ),
                            NorthstarTabBar.tab(
                              label: 'Skills',
                              icon: Icons.star_outline,
                            ),
                          ],
                    automationId: 'cat_tabs',
                  ),
                  const SizedBox(height: NorthstarSpacing.space12),
                  SizedBox(
                    height: 100,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: NorthstarColorTokens.of(context).outlineVariant,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TabBarView(
                        controller: c,
                        children: List<Widget>.generate(
                          length,
                          (int i) => Center(
                            child: Text(
                              'Panel ${i + 1}',
                              style: tt.titleSmall,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
