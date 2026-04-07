import 'package:emp_ai_ds_northstar/emp_ai_ds_northstar.dart';
import 'package:emp_ai_ds_widgets/src/testing/ds_automation_keys.dart';
import 'package:flutter/material.dart';

/// Northstar **TabBar** — underline indicator, divider, label styles (*Tabs* spec).
///
/// Pass [tabs] built with [NorthstarTabBar.tab] for optional icon + **badge**
/// counts. Use [isScrollable] when there are many tabs (&gt;7 is discouraged by
/// design — prefer scroll or rethink IA).
class NorthstarTabBar extends StatelessWidget implements PreferredSizeWidget {
  const NorthstarTabBar({
    super.key,
    required this.controller,
    required this.tabs,
    this.isScrollable = false,
    this.indicatorWeight = 3,
    this.automationId,
  });

  final TabController controller;
  final List<Widget> tabs;

  /// When true, tabs scroll horizontally (narrow / many tabs).
  final bool isScrollable;

  /// Thickness of the primary underline indicator.
  final double indicatorWeight;

  final String? automationId;

  /// Single tab row: optional [icon] (left of label), optional [badgeCount] as `(n)`.
  static Tab tab({
    required String label,
    int? badgeCount,
    IconData? icon,
  }) {
    return Tab(
      height: 48,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Non-scrollable [TabBar]: tabs get a finite max width — [Expanded]
          // lets the label ellipsize. Scrollable tabs pass unbounded horizontal
          // constraints; [Expanded] would assert / fail layout.
          final bool boundedWidth = constraints.hasBoundedWidth;
          final Text labelText = Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
          return Row(
            mainAxisSize: boundedWidth ? MainAxisSize.max : MainAxisSize.min,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Icon(icon, size: 18),
                const SizedBox(width: NorthstarSpacing.space8),
              ],
              if (boundedWidth) Expanded(child: labelText) else labelText,
              if (badgeCount != null)
                Text(
                  ' ($badgeCount)',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    final NorthstarColorTokens ns = NorthstarColorTokens.of(context);
    final ThemeData theme = Theme.of(context);
    final TextStyle? labelLarge = theme.textTheme.labelLarge;

    return KeyedSubtree(
      key: DsAutomationKeys.part(automationId, DsAutomationKeys.elementTabBar),
      child: TabBar(
        controller: controller,
        tabs: tabs,
        isScrollable: isScrollable,
        indicatorColor: ns.primary,
        indicatorWeight: indicatorWeight,
        dividerColor: ns.outlineVariant,
        labelColor: ns.onSurface,
        unselectedLabelColor: ns.onSurfaceVariant,
        labelStyle: labelLarge?.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: labelLarge?.copyWith(fontWeight: FontWeight.w500),
        overlayColor:
            WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return ns.primary.withValues(alpha: 0.08);
          }
          return Colors.transparent;
        }),
      ),
    );
  }
}
