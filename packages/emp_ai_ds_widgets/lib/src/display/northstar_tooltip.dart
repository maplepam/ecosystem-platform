import 'dart:async';

import 'package:emp_ai_ds_northstar/emp_ai_ds_northstar.dart';
import 'package:emp_ai_ds_widgets/src/testing/ds_automation_keys.dart';
import 'package:flutter/material.dart';

/// Which edge of the tooltip bubble shows the pointer triangle (Figma *Tabs* /
/// tooltip spec). [none] is a rounded rectangle only.
enum NorthstarTooltipTailPosition {
  /// Triangle centered on the top edge, pointing upward.
  top,

  /// Triangle centered on the right edge, pointing right.
  right,

  /// Triangle centered on the bottom edge, pointing downward.
  bottom,

  /// Triangle centered on the left edge, pointing left.
  left,

  /// No tail.
  none,
}

/// Layout / copy limits from Northstar tooltip guidelines (plain vs rich).
abstract final class NorthstarTooltipSpecs {
  const NorthstarTooltipSpecs._();

  /// Plain tooltip: no minimum width; content defines width up to [plainMaxWidth].
  static const double plainMinWidth = 0;

  /// Plain tooltip max width (logical px).
  static const double plainMaxWidth = 200;

  /// Plain tooltip — max characters (including spaces), per spec.
  static const int plainMaxCharacters = 56;

  /// Rich tooltip min width (logical px).
  static const double richMinWidth = 150;

  /// Rich tooltip max width (logical px).
  static const double richMaxWidth = 350;

  /// Rich tooltip — max characters including spaces (title + body text).
  static const int richMaxCharacters = 150;

  /// Default corner radius for tooltip surfaces.
  static const double cornerRadius = 8;

  /// Gap when the anchor has a visible boundary (e.g. button), per Figma.
  static const double gapWithBoundary = 4;

  /// Gap when the anchor has no clear box (e.g. text baseline), per Figma.
  static const double gapWithoutBoundary = 8;
}

class _TailPainter extends CustomPainter {
  _TailPainter({required this.color, required this.direction});

  final Color color;

  /// 0 = down, 1 = up, 2 = right, 3 = left (triangle points that way).
  final int direction;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final Path path = Path();
    switch (direction) {
      case 0: // points down
        path
          ..moveTo(0, 0)
          ..lineTo(size.width / 2, size.height)
          ..lineTo(size.width, 0)
          ..close();
      case 1: // points up
        path
          ..moveTo(0, size.height)
          ..lineTo(size.width / 2, 0)
          ..lineTo(size.width, size.height)
          ..close();
      case 2: // points right
        path
          ..moveTo(0, 0)
          ..lineTo(size.width, size.height / 2)
          ..lineTo(0, size.height)
          ..close();
      case 3: // points left
        path
          ..moveTo(size.width, 0)
          ..lineTo(0, size.height / 2)
          ..lineTo(size.width, size.height)
          ..close();
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TailPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.direction != direction;
  }
}

/// Rounded bubble + optional tail. [child] is the padded label area only.
class _NorthstarTooltipBubble extends StatelessWidget {
  const _NorthstarTooltipBubble({
    required this.tailPosition,
    required this.backgroundColor,
    required this.child,
    this.minWidth,
    this.maxWidth,
  });

  final NorthstarTooltipTailPosition tailPosition;
  final Color backgroundColor;
  final Widget child;
  final double? minWidth;
  final double? maxWidth;

  static const double _tailW = 10;
  static const double _tailH = 5;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(
      NorthstarTooltipSpecs.cornerRadius,
    );
    final Widget body = DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: radius,
      ),
      child: child,
    );

    switch (tailPosition) {
      case NorthstarTooltipTailPosition.none:
        return _constrain(body);
      case NorthstarTooltipTailPosition.bottom:
        return _constrain(
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              body,
              CustomPaint(
                size: const Size(_tailW, _tailH),
                painter: _TailPainter(color: backgroundColor, direction: 0),
              ),
            ],
          ),
        );
      case NorthstarTooltipTailPosition.top:
        return _constrain(
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomPaint(
                size: const Size(_tailW, _tailH),
                painter: _TailPainter(color: backgroundColor, direction: 1),
              ),
              body,
            ],
          ),
        );
      case NorthstarTooltipTailPosition.right:
        return _constrain(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              body,
              CustomPaint(
                size: const Size(_tailH, _tailW),
                painter: _TailPainter(color: backgroundColor, direction: 2),
              ),
            ],
          ),
        );
      case NorthstarTooltipTailPosition.left:
        return _constrain(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomPaint(
                size: const Size(_tailH, _tailW),
                painter: _TailPainter(color: backgroundColor, direction: 3),
              ),
              body,
            ],
          ),
        );
    }
  }

  Widget _constrain(Widget w) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth ?? 0,
        maxWidth: maxWidth ?? double.infinity,
      ),
      child: w,
    );
  }
}

/// Shared interactive layer: hover + focus; Material [Tooltip] when
/// [useMaterialTooltip], else [OverlayPortal] + [CompositedTransformFollower]
/// for tailed bubbles. (Touch long-press matches Material [Tooltip] when
/// [tailPosition] is [NorthstarTooltipTailPosition.none].)
class _NorthstarTooltipAnchor extends StatefulWidget {
  const _NorthstarTooltipAnchor({
    required this.child,
    required this.semanticMessage,
    required this.tailPosition,
    required this.preferBelow,
    required this.gap,
    required this.waitDuration,
    required this.showDuration,
    required this.exitDuration,
    required this.automationKey,
    required this.tooltipChild,
    this.useMaterialTooltip = false,
    this.materialMessage,
    this.materialRichMessage,
    this.materialConstraints,
    this.materialPadding,
    this.materialTextStyle,
    this.materialTextAlign,
    this.materialDecoration,
  });

  final Widget child;
  final String semanticMessage;
  final NorthstarTooltipTailPosition tailPosition;
  final bool preferBelow;
  final double gap;
  final Duration waitDuration;
  final Duration showDuration;
  final Duration exitDuration;
  final Key? automationKey;
  final Widget tooltipChild;

  final bool useMaterialTooltip;
  final String? materialMessage;
  final InlineSpan? materialRichMessage;
  final BoxConstraints? materialConstraints;
  final EdgeInsetsGeometry? materialPadding;
  final TextStyle? materialTextStyle;
  final TextAlign? materialTextAlign;
  final Decoration? materialDecoration;

  @override
  State<_NorthstarTooltipAnchor> createState() =>
      _NorthstarTooltipAnchorState();
}

class _NorthstarTooltipAnchorState extends State<_NorthstarTooltipAnchor> {
  final LayerLink _link = LayerLink();
  final OverlayPortalController _portal = OverlayPortalController();
  Timer? _waitTimer;
  Timer? _hideTimer;
  bool _pointerInside = false;
  bool _focused = false;

  @override
  void dispose() {
    _cancelTimers();
    super.dispose();
  }

  void _cancelTimers() {
    _waitTimer?.cancel();
    _waitTimer = null;
    _hideTimer?.cancel();
    _hideTimer = null;
  }

  void _scheduleShowFromHover() {
    _hideTimer?.cancel();
    _hideTimer = null;
    if (_portal.isShowing) {
      return;
    }
    _waitTimer?.cancel();
    _waitTimer = Timer(widget.waitDuration, () {
      if (mounted && _pointerInside) {
        _portal.show();
      }
    });
  }

  void _scheduleHideAfterExit() {
    _waitTimer?.cancel();
    _waitTimer = null;
    _hideTimer?.cancel();
    _hideTimer = Timer(widget.exitDuration, () {
      if (mounted && !_pointerInside && !_focused) {
        _portal.hide();
      }
    });
  }

  void _hideNow() {
    _cancelTimers();
    _portal.hide();
  }

  ({Alignment targetAnchor, Alignment followerAnchor, Offset offset})
      _placement() {
    final double g = widget.gap;
    switch (widget.tailPosition) {
      case NorthstarTooltipTailPosition.left:
        return (
          targetAnchor: Alignment.centerRight,
          followerAnchor: Alignment.centerLeft,
          offset: Offset(g, 0),
        );
      case NorthstarTooltipTailPosition.right:
        return (
          targetAnchor: Alignment.centerLeft,
          followerAnchor: Alignment.centerRight,
          offset: Offset(-g, 0),
        );
      case NorthstarTooltipTailPosition.none:
      case NorthstarTooltipTailPosition.top:
      case NorthstarTooltipTailPosition.bottom:
        if (widget.preferBelow) {
          return (
            targetAnchor: Alignment.bottomCenter,
            followerAnchor: Alignment.topCenter,
            offset: Offset(0, g),
          );
        }
        return (
          targetAnchor: Alignment.topCenter,
          followerAnchor: Alignment.bottomCenter,
          offset: Offset(0, -g),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.useMaterialTooltip) {
      assert(
        widget.materialMessage != null || widget.materialRichMessage != null,
      );
      return KeyedSubtree(
        key: widget.automationKey,
        child: Tooltip(
          message: widget.materialRichMessage == null
              ? widget.materialMessage
              : null,
          richMessage: widget.materialRichMessage,
          preferBelow: widget.preferBelow,
          verticalOffset: widget.gap,
          waitDuration: widget.waitDuration,
          showDuration: widget.showDuration,
          exitDuration: widget.exitDuration,
          textAlign: widget.materialTextAlign ?? TextAlign.center,
          constraints: widget.materialConstraints,
          decoration: widget.materialDecoration,
          textStyle: widget.materialTextStyle,
          padding: widget.materialPadding,
          child: Semantics(
            tooltip: widget.semanticMessage,
            child: widget.child,
          ),
        ),
      );
    }

    final ({
      Alignment targetAnchor,
      Alignment followerAnchor,
      Offset offset
    }) p = _placement();

    return KeyedSubtree(
      key: widget.automationKey,
      child: Semantics(
        tooltip: widget.semanticMessage,
        child: CompositedTransformTarget(
          link: _link,
          child: OverlayPortal(
            controller: _portal,
            overlayChildBuilder: (BuildContext context) {
              return CompositedTransformFollower(
                link: _link,
                showWhenUnlinked: false,
                targetAnchor: p.targetAnchor,
                followerAnchor: p.followerAnchor,
                offset: p.offset,
                child: widget.tooltipChild,
              );
            },
            child: Focus(
              onFocusChange: (bool focused) {
                _focused = focused;
                if (focused) {
                  _hideTimer?.cancel();
                  _waitTimer?.cancel();
                  _waitTimer = Timer(widget.waitDuration, () {
                    if (mounted && _focused) {
                      _portal.show();
                    }
                  });
                } else if (!_pointerInside) {
                  _hideNow();
                }
              },
              child: MouseRegion(
                onEnter: (_) {
                  _pointerInside = true;
                  _scheduleShowFromHover();
                },
                onExit: (_) {
                  _pointerInside = false;
                  if (!_focused) {
                    _scheduleHideAfterExit();
                  }
                },
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Plain **tooltip** — short helper on [NorthstarColorTokens.inverseSurface].
///
/// * No minimum width; max width [NorthstarTooltipSpecs.plainMaxWidth].
/// * Prefer ≤ [NorthstarTooltipSpecs.plainMaxCharacters] characters (including
///   spaces); text wraps and the bubble grows in height.
/// * Default placement is **above** the anchor ([preferBelow] false). Gap is
///   [NorthstarTooltipSpecs.gapWithBoundary] when [hasVisualBoundary] is true,
///   else [NorthstarTooltipSpecs.gapWithoutBoundary], unless [verticalOffset]
///   is set explicitly.
/// * [tailPosition] [none] uses the platform [Tooltip] (no drawn tail). Any
///   other value uses a custom bubble with a tail on that edge.
class NorthstarPlainTooltip extends StatelessWidget {
  const NorthstarPlainTooltip({
    super.key,
    required this.message,
    required this.child,
    this.tailPosition = NorthstarTooltipTailPosition.none,
    this.preferBelow = false,
    this.hasVisualBoundary = true,
    this.verticalOffset,
    this.waitDuration = const Duration(milliseconds: 400),
    this.showDuration = const Duration(seconds: 3),
    this.automationId,
  });

  final String message;
  final Widget child;

  /// Triangle on this side of the bubble, or [none] for Material tooltip.
  final NorthstarTooltipTailPosition tailPosition;

  /// When false (default), tooltip prefers **above** the child (Figma default).
  final bool preferBelow;

  /// Drives default gap when [verticalOffset] is null (4px vs 8px).
  final bool hasVisualBoundary;

  /// Overrides computed gap from [hasVisualBoundary] when non-null.
  final double? verticalOffset;

  final Duration waitDuration;
  final Duration showDuration;

  final String? automationId;

  @override
  Widget build(BuildContext context) {
    assert(() {
      if (message.characters.length > NorthstarTooltipSpecs.plainMaxCharacters) {
        FlutterError.reportError(
          FlutterErrorDetails(
            exception: FlutterError(
              'NorthstarPlainTooltip message exceeds '
              '${NorthstarTooltipSpecs.plainMaxCharacters} characters '
              '(${message.characters.length}).',
            ),
            library: 'emp_ai_ds_widgets',
          ),
        );
      }
      return true;
    }());

    final NorthstarColorTokens ns = NorthstarColorTokens.of(context);
    final ThemeData theme = Theme.of(context);
    final TextStyle? textStyle = theme.textTheme.bodySmall?.copyWith(
      color: ns.onInverseSurface,
      height: 1.35,
    );

    final double gap = verticalOffset ??
        (hasVisualBoundary
            ? NorthstarTooltipSpecs.gapWithBoundary
            : NorthstarTooltipSpecs.gapWithoutBoundary);

    final Widget bubbleContent = Padding(
      padding: const EdgeInsets.all(NorthstarSpacing.space8),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: textStyle,
        maxLines: null,
        softWrap: true,
      ),
    );

    if (tailPosition == NorthstarTooltipTailPosition.none) {
      return _NorthstarTooltipAnchor(
        automationKey:
            DsAutomationKeys.part(automationId, DsAutomationKeys.elementTooltip),
        semanticMessage: message,
        tailPosition: tailPosition,
        preferBelow: preferBelow,
        gap: gap,
        waitDuration: waitDuration,
        showDuration: showDuration,
        exitDuration: const Duration(milliseconds: 100),
        useMaterialTooltip: true,
        materialMessage: message,
        materialConstraints: const BoxConstraints(
          maxWidth: NorthstarTooltipSpecs.plainMaxWidth,
        ),
        materialPadding: const EdgeInsets.all(NorthstarSpacing.space8),
        materialTextStyle: textStyle,
        materialTextAlign: TextAlign.center,
        materialDecoration: BoxDecoration(
          color: ns.inverseSurface,
          borderRadius: BorderRadius.circular(NorthstarTooltipSpecs.cornerRadius),
        ),
        tooltipChild: const SizedBox.shrink(),
        child: child,
      );
    }

    return _NorthstarTooltipAnchor(
      automationKey:
          DsAutomationKeys.part(automationId, DsAutomationKeys.elementTooltip),
      semanticMessage: message,
      tailPosition: tailPosition,
      preferBelow: preferBelow,
      gap: gap,
      waitDuration: waitDuration,
      showDuration: showDuration,
      exitDuration: const Duration(milliseconds: 100),
      tooltipChild: Material(
        type: MaterialType.transparency,
        child: _NorthstarTooltipBubble(
          tailPosition: tailPosition,
          backgroundColor: ns.inverseSurface,
          maxWidth: NorthstarTooltipSpecs.plainMaxWidth,
          child: bubbleContent,
        ),
      ),
      child: child,
    );
  }
}

/// **Rich tooltip** — optional [title], body text and/or [content], optional
/// [leading] (e.g. icon).
///
/// * Width clamp [NorthstarTooltipSpecs.richMinWidth]–[NorthstarTooltipSpecs.richMaxWidth].
/// * Prefer ≤ [NorthstarTooltipSpecs.richMaxCharacters] characters total in
///   [title] + [description] when using text (not enforced for [content]).
/// * Avoid interactive widgets inside the tooltip surface.
/// * [tailPosition] [none] with text-only body uses Material [Tooltip.rich]. A
///   non-null [content] or [leading] always uses the custom overlay (same as a
///   non-[none] tail).
class NorthstarRichTooltip extends StatelessWidget {
  NorthstarRichTooltip({
    super.key,
    required this.child,
    this.title,
    this.description,
    this.content,
    this.leading,
    this.tailPosition = NorthstarTooltipTailPosition.none,
    this.preferBelow = false,
    this.hasVisualBoundary = true,
    this.verticalOffset,
    this.waitDuration = const Duration(milliseconds: 400),
    this.showDuration = const Duration(seconds: 4),
    this.automationId,
  }) : assert(
          content != null ||
              (description != null && description.isNotEmpty),
          'Provide description and/or content.',
        );

  final Widget child;

  /// Optional bold heading.
  final String? title;

  /// Body copy when not using [content].
  final String? description;

  /// Custom body (charts, rows, stars). When set, [description] is ignored.
  final Widget? content;

  /// e.g. leading icon; non-interactive.
  final Widget? leading;

  final NorthstarTooltipTailPosition tailPosition;
  final bool preferBelow;
  final bool hasVisualBoundary;
  final double? verticalOffset;
  final Duration waitDuration;
  final Duration showDuration;
  final String? automationId;

  @override
  Widget build(BuildContext context) {
    assert(() {
      if (content == null) {
        final int n = (title?.characters.length ?? 0) +
            (description?.characters.length ?? 0) +
            (title != null && description != null ? 1 : 0);
        if (n > NorthstarTooltipSpecs.richMaxCharacters) {
          FlutterError.reportError(
            FlutterErrorDetails(
              exception: FlutterError(
                'NorthstarRichTooltip title+description exceeds '
                '${NorthstarTooltipSpecs.richMaxCharacters} characters.',
              ),
              library: 'emp_ai_ds_widgets',
            ),
          );
        }
      }
      return true;
    }());

    final NorthstarColorTokens ns = NorthstarColorTokens.of(context);
    final ThemeData theme = Theme.of(context);
    final TextStyle body = theme.textTheme.bodySmall!.copyWith(
      color: ns.onInverseSurface,
      height: 1.4,
    );
    final TextStyle titleStyle = body.copyWith(fontWeight: FontWeight.w700);

    final double gap = verticalOffset ??
        (hasVisualBoundary
            ? NorthstarTooltipSpecs.gapWithBoundary
            : NorthstarTooltipSpecs.gapWithoutBoundary);

    final Widget bodyColumn = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null) ...<Widget>[
          Text(title!, style: titleStyle),
          const SizedBox(height: NorthstarSpacing.space4),
        ],
        if (content != null)
          content!
        else
          Text(description!, style: body),
      ],
    );

    final Widget paddedInner = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: NorthstarSpacing.space12,
        vertical: NorthstarSpacing.space12,
      ),
      child: leading == null
          ? bodyColumn
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: NorthstarSpacing.space8),
                  child: IconTheme.merge(
                    data: IconThemeData(color: ns.onInverseSurface, size: 20),
                    child: leading!,
                  ),
                ),
                Expanded(child: bodyColumn),
              ],
            ),
    );

    final String semanticMessage = <String?>[
      title,
      description,
    ].whereType<String>().join('\n');

    final bool useMaterialRich = tailPosition == NorthstarTooltipTailPosition.none &&
        content == null &&
        leading == null;

    if (useMaterialRich) {
      final TextSpan rich = TextSpan(
        style: body,
        children: <InlineSpan>[
          if (title != null)
            TextSpan(text: '$title\n', style: titleStyle),
          TextSpan(text: description!),
        ],
      );
      return _NorthstarTooltipAnchor(
        automationKey:
            DsAutomationKeys.part(automationId, DsAutomationKeys.elementTooltip),
        semanticMessage:
            semanticMessage.isEmpty ? description! : semanticMessage,
        tailPosition: tailPosition,
        preferBelow: preferBelow,
        gap: gap,
        waitDuration: waitDuration,
        showDuration: showDuration,
        exitDuration: const Duration(milliseconds: 100),
        useMaterialTooltip: true,
        materialRichMessage: rich,
        materialConstraints: const BoxConstraints(
          minWidth: NorthstarTooltipSpecs.richMinWidth,
          maxWidth: NorthstarTooltipSpecs.richMaxWidth,
        ),
        materialPadding: const EdgeInsets.symmetric(
          horizontal: NorthstarSpacing.space12,
          vertical: NorthstarSpacing.space12,
        ),
        materialDecoration: BoxDecoration(
          color: ns.inverseSurface,
          borderRadius: BorderRadius.circular(NorthstarTooltipSpecs.cornerRadius),
        ),
        tooltipChild: const SizedBox.shrink(),
        child: child,
      );
    }

    return _NorthstarTooltipAnchor(
      automationKey:
          DsAutomationKeys.part(automationId, DsAutomationKeys.elementTooltip),
      semanticMessage: semanticMessage.isNotEmpty
          ? semanticMessage
          : (description ?? title ?? ''),
      tailPosition: tailPosition,
      preferBelow: preferBelow,
      gap: gap,
      waitDuration: waitDuration,
      showDuration: showDuration,
      exitDuration: const Duration(milliseconds: 100),
      tooltipChild: Material(
        type: MaterialType.transparency,
        textStyle: body,
        child: _NorthstarTooltipBubble(
          tailPosition: tailPosition,
          backgroundColor: ns.inverseSurface,
          minWidth: NorthstarTooltipSpecs.richMinWidth,
          maxWidth: NorthstarTooltipSpecs.richMaxWidth,
          child: paddedInner,
        ),
      ),
      child: child,
    );
  }
}
