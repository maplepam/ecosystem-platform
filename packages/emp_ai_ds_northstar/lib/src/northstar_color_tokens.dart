import 'package:flutter/material.dart';

/// Semantic colors for Northstar: Material 3 bridge fields plus every color
/// role from the Figma variables export (DTCG JSON).
///
/// **Preset values** live in [NorthstarBaseTokens]. [surface], [outline], etc.
/// stay aligned with Figma aliases (e.g. [surface] = Background Bright,
/// [contentBlack] = Content Black) so [toColorScheme] and
/// [NorthstarColorTokens.of] match design tokens.
///
/// **Extending for a white-label app:** use [copyWith] or compose a new
/// instance — do not mutate a shared singleton.
@immutable
class NorthstarColorTokens extends ThemeExtension<NorthstarColorTokens> {
  const NorthstarColorTokens({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.surface,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.surfaceContainerLow,
    required this.surfaceContainerHigh,
    required this.outline,
    required this.outlineVariant,
    required this.error,
    required this.onError,
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.background,
    required this.backgroundBright,
    required this.backgroundDim,
    required this.border,
    required this.card0,
    required this.card10,
    required this.card20,
    required this.card30,
    required this.card40,
    required this.contentBlack,
    required this.contentGray,
    required this.contentGrayBright,
    required this.contentWhite,
    required this.divider,
    required this.errorContainer,
    required this.errorVariant,
    required this.errorHover,
    required this.logotype,
    required this.miscellaneousBlue,
    required this.miscellaneousBlueContainer,
    required this.miscellaneousBlueHover,
    required this.miscellaneousBlueVariant,
    required this.miscellaneousEmerald,
    required this.miscellaneousEmeraldContainer,
    required this.miscellaneousEmeraldHover,
    required this.miscellaneousEmeraldVariant,
    required this.miscellaneousIndigo,
    required this.miscellaneousIndigoContainer,
    required this.miscellaneousIndigoHover,
    required this.miscellaneousIndigoVariant,
    required this.miscellaneousOnBlueContainer,
    required this.miscellaneousOnEmeraldContainer,
    required this.miscellaneousOnIndigoContainer,
    required this.miscellaneousOnOrangeContainer,
    required this.miscellaneousOnPinkContainer,
    required this.miscellaneousOnVioletContainer,
    required this.miscellaneousOrange,
    required this.miscellaneousOrangeContainer,
    required this.miscellaneousOrangeHover,
    required this.miscellaneousOrangeVariant,
    required this.miscellaneousPink,
    required this.miscellaneousPinkContainer,
    required this.miscellaneousPinkHover,
    required this.miscellaneousPinkVariant,
    required this.miscellaneousViolet,
    required this.miscellaneousVioletContainer,
    required this.miscellaneousVioletHover,
    required this.miscellaneousVioletVariant,
    required this.onErrorContainer,
    required this.onSecondaryContainer,
    required this.onSuccessContainer,
    required this.onWarningContainer,
    required this.primaryHover,
    required this.primaryVariant,
    required this.secondaryContainer,
    required this.secondaryHover,
    required this.secondaryVariant,
    required this.successContainer,
    required this.successHover,
    required this.successVariant,
    required this.warningContainer,
    required this.warningHover,
    required this.warningVariant,
  });

  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color surface;
  final Color onSurface;
  final Color onSurfaceVariant;
  final Color surfaceContainerLow;
  final Color surfaceContainerHigh;
  final Color outline;
  final Color outlineVariant;
  final Color error;
  final Color onError;
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color inverseSurface;
  final Color onInverseSurface;
  final Color background;
  final Color backgroundBright;
  final Color backgroundDim;
  final Color border;
  final Color card0;
  final Color card10;
  final Color card20;
  final Color card30;
  final Color card40;
  final Color contentBlack;
  final Color contentGray;
  final Color contentGrayBright;
  final Color contentWhite;
  final Color divider;
  final Color errorContainer;
  final Color errorVariant;
  final Color errorHover;
  final Color logotype;
  final Color miscellaneousBlue;
  final Color miscellaneousBlueContainer;
  final Color miscellaneousBlueHover;
  final Color miscellaneousBlueVariant;
  final Color miscellaneousEmerald;
  final Color miscellaneousEmeraldContainer;
  final Color miscellaneousEmeraldHover;
  final Color miscellaneousEmeraldVariant;
  final Color miscellaneousIndigo;
  final Color miscellaneousIndigoContainer;
  final Color miscellaneousIndigoHover;
  final Color miscellaneousIndigoVariant;
  final Color miscellaneousOnBlueContainer;
  final Color miscellaneousOnEmeraldContainer;
  final Color miscellaneousOnIndigoContainer;
  final Color miscellaneousOnOrangeContainer;
  final Color miscellaneousOnPinkContainer;
  final Color miscellaneousOnVioletContainer;
  final Color miscellaneousOrange;
  final Color miscellaneousOrangeContainer;
  final Color miscellaneousOrangeHover;
  final Color miscellaneousOrangeVariant;
  final Color miscellaneousPink;
  final Color miscellaneousPinkContainer;
  final Color miscellaneousPinkHover;
  final Color miscellaneousPinkVariant;
  final Color miscellaneousViolet;
  final Color miscellaneousVioletContainer;
  final Color miscellaneousVioletHover;
  final Color miscellaneousVioletVariant;
  final Color onErrorContainer;
  final Color onSecondaryContainer;
  final Color onSuccessContainer;
  final Color onWarningContainer;
  final Color primaryHover;
  final Color primaryVariant;
  final Color secondaryContainer;
  final Color secondaryHover;
  final Color secondaryVariant;
  final Color successContainer;
  final Color successHover;
  final Color successVariant;
  final Color warningContainer;
  final Color warningHover;
  final Color warningVariant;

  /// Resolve tokens from [BuildContext] after [ThemeData.extensions] is set.
  static NorthstarColorTokens of(BuildContext context) {
    final ext = Theme.of(context).extension<NorthstarColorTokens>();
    assert(
      ext != null,
      'NorthstarColorTokens missing — add via NorthstarTheme.buildThemeData',
    );
    return ext!;
  }

  @override
  NorthstarColorTokens copyWith({
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? surface,
    Color? onSurface,
    Color? onSurfaceVariant,
    Color? surfaceContainerLow,
    Color? surfaceContainerHigh,
    Color? outline,
    Color? outlineVariant,
    Color? error,
    Color? onError,
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? inverseSurface,
    Color? onInverseSurface,
    Color? background,
    Color? backgroundBright,
    Color? backgroundDim,
    Color? border,
    Color? card0,
    Color? card10,
    Color? card20,
    Color? card30,
    Color? card40,
    Color? contentBlack,
    Color? contentGray,
    Color? contentGrayBright,
    Color? contentWhite,
    Color? divider,
    Color? errorContainer,
    Color? errorVariant,
    Color? errorHover,
    Color? logotype,
    Color? miscellaneousBlue,
    Color? miscellaneousBlueContainer,
    Color? miscellaneousBlueHover,
    Color? miscellaneousBlueVariant,
    Color? miscellaneousEmerald,
    Color? miscellaneousEmeraldContainer,
    Color? miscellaneousEmeraldHover,
    Color? miscellaneousEmeraldVariant,
    Color? miscellaneousIndigo,
    Color? miscellaneousIndigoContainer,
    Color? miscellaneousIndigoHover,
    Color? miscellaneousIndigoVariant,
    Color? miscellaneousOnBlueContainer,
    Color? miscellaneousOnEmeraldContainer,
    Color? miscellaneousOnIndigoContainer,
    Color? miscellaneousOnOrangeContainer,
    Color? miscellaneousOnPinkContainer,
    Color? miscellaneousOnVioletContainer,
    Color? miscellaneousOrange,
    Color? miscellaneousOrangeContainer,
    Color? miscellaneousOrangeHover,
    Color? miscellaneousOrangeVariant,
    Color? miscellaneousPink,
    Color? miscellaneousPinkContainer,
    Color? miscellaneousPinkHover,
    Color? miscellaneousPinkVariant,
    Color? miscellaneousViolet,
    Color? miscellaneousVioletContainer,
    Color? miscellaneousVioletHover,
    Color? miscellaneousVioletVariant,
    Color? onErrorContainer,
    Color? onSecondaryContainer,
    Color? onSuccessContainer,
    Color? onWarningContainer,
    Color? primaryHover,
    Color? primaryVariant,
    Color? secondaryContainer,
    Color? secondaryHover,
    Color? secondaryVariant,
    Color? successContainer,
    Color? successHover,
    Color? successVariant,
    Color? warningContainer,
    Color? warningHover,
    Color? warningVariant,
  }) {
    return NorthstarColorTokens(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      surfaceContainerLow: surfaceContainerLow ?? this.surfaceContainerLow,
      surfaceContainerHigh: surfaceContainerHigh ?? this.surfaceContainerHigh,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      onInverseSurface: onInverseSurface ?? this.onInverseSurface,
      background: background ?? this.background,
      backgroundBright: backgroundBright ?? this.backgroundBright,
      backgroundDim: backgroundDim ?? this.backgroundDim,
      border: border ?? this.border,
      card0: card0 ?? this.card0,
      card10: card10 ?? this.card10,
      card20: card20 ?? this.card20,
      card30: card30 ?? this.card30,
      card40: card40 ?? this.card40,
      contentBlack: contentBlack ?? this.contentBlack,
      contentGray: contentGray ?? this.contentGray,
      contentGrayBright: contentGrayBright ?? this.contentGrayBright,
      contentWhite: contentWhite ?? this.contentWhite,
      divider: divider ?? this.divider,
      errorContainer: errorContainer ?? this.errorContainer,
      errorVariant: errorVariant ?? this.errorVariant,
      errorHover: errorHover ?? this.errorHover,
      logotype: logotype ?? this.logotype,
      miscellaneousBlue: miscellaneousBlue ?? this.miscellaneousBlue,
      miscellaneousBlueContainer:
          miscellaneousBlueContainer ?? this.miscellaneousBlueContainer,
      miscellaneousBlueHover:
          miscellaneousBlueHover ?? this.miscellaneousBlueHover,
      miscellaneousBlueVariant:
          miscellaneousBlueVariant ?? this.miscellaneousBlueVariant,
      miscellaneousEmerald: miscellaneousEmerald ?? this.miscellaneousEmerald,
      miscellaneousEmeraldContainer:
          miscellaneousEmeraldContainer ?? this.miscellaneousEmeraldContainer,
      miscellaneousEmeraldHover:
          miscellaneousEmeraldHover ?? this.miscellaneousEmeraldHover,
      miscellaneousEmeraldVariant:
          miscellaneousEmeraldVariant ?? this.miscellaneousEmeraldVariant,
      miscellaneousIndigo: miscellaneousIndigo ?? this.miscellaneousIndigo,
      miscellaneousIndigoContainer:
          miscellaneousIndigoContainer ?? this.miscellaneousIndigoContainer,
      miscellaneousIndigoHover:
          miscellaneousIndigoHover ?? this.miscellaneousIndigoHover,
      miscellaneousIndigoVariant:
          miscellaneousIndigoVariant ?? this.miscellaneousIndigoVariant,
      miscellaneousOnBlueContainer:
          miscellaneousOnBlueContainer ?? this.miscellaneousOnBlueContainer,
      miscellaneousOnEmeraldContainer: miscellaneousOnEmeraldContainer ??
          this.miscellaneousOnEmeraldContainer,
      miscellaneousOnIndigoContainer:
          miscellaneousOnIndigoContainer ?? this.miscellaneousOnIndigoContainer,
      miscellaneousOnOrangeContainer:
          miscellaneousOnOrangeContainer ?? this.miscellaneousOnOrangeContainer,
      miscellaneousOnPinkContainer:
          miscellaneousOnPinkContainer ?? this.miscellaneousOnPinkContainer,
      miscellaneousOnVioletContainer:
          miscellaneousOnVioletContainer ?? this.miscellaneousOnVioletContainer,
      miscellaneousOrange: miscellaneousOrange ?? this.miscellaneousOrange,
      miscellaneousOrangeContainer:
          miscellaneousOrangeContainer ?? this.miscellaneousOrangeContainer,
      miscellaneousOrangeHover:
          miscellaneousOrangeHover ?? this.miscellaneousOrangeHover,
      miscellaneousOrangeVariant:
          miscellaneousOrangeVariant ?? this.miscellaneousOrangeVariant,
      miscellaneousPink: miscellaneousPink ?? this.miscellaneousPink,
      miscellaneousPinkContainer:
          miscellaneousPinkContainer ?? this.miscellaneousPinkContainer,
      miscellaneousPinkHover:
          miscellaneousPinkHover ?? this.miscellaneousPinkHover,
      miscellaneousPinkVariant:
          miscellaneousPinkVariant ?? this.miscellaneousPinkVariant,
      miscellaneousViolet: miscellaneousViolet ?? this.miscellaneousViolet,
      miscellaneousVioletContainer:
          miscellaneousVioletContainer ?? this.miscellaneousVioletContainer,
      miscellaneousVioletHover:
          miscellaneousVioletHover ?? this.miscellaneousVioletHover,
      miscellaneousVioletVariant:
          miscellaneousVioletVariant ?? this.miscellaneousVioletVariant,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      primaryHover: primaryHover ?? this.primaryHover,
      primaryVariant: primaryVariant ?? this.primaryVariant,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      secondaryHover: secondaryHover ?? this.secondaryHover,
      secondaryVariant: secondaryVariant ?? this.secondaryVariant,
      successContainer: successContainer ?? this.successContainer,
      successHover: successHover ?? this.successHover,
      successVariant: successVariant ?? this.successVariant,
      warningContainer: warningContainer ?? this.warningContainer,
      warningHover: warningHover ?? this.warningHover,
      warningVariant: warningVariant ?? this.warningVariant,
    );
  }

  @override
  NorthstarColorTokens lerp(
      ThemeExtension<NorthstarColorTokens>? other, double t) {
    if (other is! NorthstarColorTokens) {
      return this;
    }
    return NorthstarColorTokens(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryContainer:
          Color.lerp(primaryContainer, other.primaryContainer, t)!,
      onPrimaryContainer:
          Color.lerp(onPrimaryContainer, other.onPrimaryContainer, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      onSurfaceVariant:
          Color.lerp(onSurfaceVariant, other.onSurfaceVariant, t)!,
      surfaceContainerLow:
          Color.lerp(surfaceContainerLow, other.surfaceContainerLow, t)!,
      surfaceContainerHigh:
          Color.lerp(surfaceContainerHigh, other.surfaceContainerHigh, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      outlineVariant: Color.lerp(outlineVariant, other.outlineVariant, t)!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      inverseSurface: Color.lerp(inverseSurface, other.inverseSurface, t)!,
      onInverseSurface:
          Color.lerp(onInverseSurface, other.onInverseSurface, t)!,
      background: Color.lerp(background, other.background, t)!,
      backgroundBright:
          Color.lerp(backgroundBright, other.backgroundBright, t)!,
      backgroundDim: Color.lerp(backgroundDim, other.backgroundDim, t)!,
      border: Color.lerp(border, other.border, t)!,
      card0: Color.lerp(card0, other.card0, t)!,
      card10: Color.lerp(card10, other.card10, t)!,
      card20: Color.lerp(card20, other.card20, t)!,
      card30: Color.lerp(card30, other.card30, t)!,
      card40: Color.lerp(card40, other.card40, t)!,
      contentBlack: Color.lerp(contentBlack, other.contentBlack, t)!,
      contentGray: Color.lerp(contentGray, other.contentGray, t)!,
      contentGrayBright:
          Color.lerp(contentGrayBright, other.contentGrayBright, t)!,
      contentWhite: Color.lerp(contentWhite, other.contentWhite, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      errorContainer: Color.lerp(errorContainer, other.errorContainer, t)!,
      errorVariant: Color.lerp(errorVariant, other.errorVariant, t)!,
      errorHover: Color.lerp(errorHover, other.errorHover, t)!,
      logotype: Color.lerp(logotype, other.logotype, t)!,
      miscellaneousBlue:
          Color.lerp(miscellaneousBlue, other.miscellaneousBlue, t)!,
      miscellaneousBlueContainer: Color.lerp(
          miscellaneousBlueContainer, other.miscellaneousBlueContainer, t)!,
      miscellaneousBlueHover:
          Color.lerp(miscellaneousBlueHover, other.miscellaneousBlueHover, t)!,
      miscellaneousBlueVariant: Color.lerp(
          miscellaneousBlueVariant, other.miscellaneousBlueVariant, t)!,
      miscellaneousEmerald:
          Color.lerp(miscellaneousEmerald, other.miscellaneousEmerald, t)!,
      miscellaneousEmeraldContainer: Color.lerp(miscellaneousEmeraldContainer,
          other.miscellaneousEmeraldContainer, t)!,
      miscellaneousEmeraldHover: Color.lerp(
          miscellaneousEmeraldHover, other.miscellaneousEmeraldHover, t)!,
      miscellaneousEmeraldVariant: Color.lerp(
          miscellaneousEmeraldVariant, other.miscellaneousEmeraldVariant, t)!,
      miscellaneousIndigo:
          Color.lerp(miscellaneousIndigo, other.miscellaneousIndigo, t)!,
      miscellaneousIndigoContainer: Color.lerp(
          miscellaneousIndigoContainer, other.miscellaneousIndigoContainer, t)!,
      miscellaneousIndigoHover: Color.lerp(
          miscellaneousIndigoHover, other.miscellaneousIndigoHover, t)!,
      miscellaneousIndigoVariant: Color.lerp(
          miscellaneousIndigoVariant, other.miscellaneousIndigoVariant, t)!,
      miscellaneousOnBlueContainer: Color.lerp(
          miscellaneousOnBlueContainer, other.miscellaneousOnBlueContainer, t)!,
      miscellaneousOnEmeraldContainer: Color.lerp(
          miscellaneousOnEmeraldContainer,
          other.miscellaneousOnEmeraldContainer,
          t)!,
      miscellaneousOnIndigoContainer: Color.lerp(miscellaneousOnIndigoContainer,
          other.miscellaneousOnIndigoContainer, t)!,
      miscellaneousOnOrangeContainer: Color.lerp(miscellaneousOnOrangeContainer,
          other.miscellaneousOnOrangeContainer, t)!,
      miscellaneousOnPinkContainer: Color.lerp(
          miscellaneousOnPinkContainer, other.miscellaneousOnPinkContainer, t)!,
      miscellaneousOnVioletContainer: Color.lerp(miscellaneousOnVioletContainer,
          other.miscellaneousOnVioletContainer, t)!,
      miscellaneousOrange:
          Color.lerp(miscellaneousOrange, other.miscellaneousOrange, t)!,
      miscellaneousOrangeContainer: Color.lerp(
          miscellaneousOrangeContainer, other.miscellaneousOrangeContainer, t)!,
      miscellaneousOrangeHover: Color.lerp(
          miscellaneousOrangeHover, other.miscellaneousOrangeHover, t)!,
      miscellaneousOrangeVariant: Color.lerp(
          miscellaneousOrangeVariant, other.miscellaneousOrangeVariant, t)!,
      miscellaneousPink:
          Color.lerp(miscellaneousPink, other.miscellaneousPink, t)!,
      miscellaneousPinkContainer: Color.lerp(
          miscellaneousPinkContainer, other.miscellaneousPinkContainer, t)!,
      miscellaneousPinkHover:
          Color.lerp(miscellaneousPinkHover, other.miscellaneousPinkHover, t)!,
      miscellaneousPinkVariant: Color.lerp(
          miscellaneousPinkVariant, other.miscellaneousPinkVariant, t)!,
      miscellaneousViolet:
          Color.lerp(miscellaneousViolet, other.miscellaneousViolet, t)!,
      miscellaneousVioletContainer: Color.lerp(
          miscellaneousVioletContainer, other.miscellaneousVioletContainer, t)!,
      miscellaneousVioletHover: Color.lerp(
          miscellaneousVioletHover, other.miscellaneousVioletHover, t)!,
      miscellaneousVioletVariant: Color.lerp(
          miscellaneousVioletVariant, other.miscellaneousVioletVariant, t)!,
      onErrorContainer:
          Color.lerp(onErrorContainer, other.onErrorContainer, t)!,
      onSecondaryContainer:
          Color.lerp(onSecondaryContainer, other.onSecondaryContainer, t)!,
      onSuccessContainer:
          Color.lerp(onSuccessContainer, other.onSuccessContainer, t)!,
      onWarningContainer:
          Color.lerp(onWarningContainer, other.onWarningContainer, t)!,
      primaryHover: Color.lerp(primaryHover, other.primaryHover, t)!,
      primaryVariant: Color.lerp(primaryVariant, other.primaryVariant, t)!,
      secondaryContainer:
          Color.lerp(secondaryContainer, other.secondaryContainer, t)!,
      secondaryHover: Color.lerp(secondaryHover, other.secondaryHover, t)!,
      secondaryVariant:
          Color.lerp(secondaryVariant, other.secondaryVariant, t)!,
      successContainer:
          Color.lerp(successContainer, other.successContainer, t)!,
      successHover: Color.lerp(successHover, other.successHover, t)!,
      successVariant: Color.lerp(successVariant, other.successVariant, t)!,
      warningContainer:
          Color.lerp(warningContainer, other.warningContainer, t)!,
      warningHover: Color.lerp(warningHover, other.warningHover, t)!,
      warningVariant: Color.lerp(warningVariant, other.warningVariant, t)!,
    );
  }

  ColorScheme toColorScheme(Brightness brightness) {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      surface: surface,
      onSurface: onSurface,
      onSurfaceVariant: onSurfaceVariant,
      error: error,
      onError: onError,
      outline: outline,
      outlineVariant: outlineVariant,
    );
  }

  @override
  int get hashCode => Object.hashAll([
        primary,
        onPrimary,
        primaryContainer,
        onPrimaryContainer,
        secondary,
        onSecondary,
        surface,
        onSurface,
        onSurfaceVariant,
        surfaceContainerLow,
        surfaceContainerHigh,
        outline,
        outlineVariant,
        error,
        onError,
        success,
        onSuccess,
        warning,
        onWarning,
        inverseSurface,
        onInverseSurface,
        background,
        backgroundBright,
        backgroundDim,
        border,
        card0,
        card10,
        card20,
        card30,
        card40,
        contentBlack,
        contentGray,
        contentGrayBright,
        contentWhite,
        divider,
        errorContainer,
        errorVariant,
        errorHover,
        logotype,
        miscellaneousBlue,
        miscellaneousBlueContainer,
        miscellaneousBlueHover,
        miscellaneousBlueVariant,
        miscellaneousEmerald,
        miscellaneousEmeraldContainer,
        miscellaneousEmeraldHover,
        miscellaneousEmeraldVariant,
        miscellaneousIndigo,
        miscellaneousIndigoContainer,
        miscellaneousIndigoHover,
        miscellaneousIndigoVariant,
        miscellaneousOnBlueContainer,
        miscellaneousOnEmeraldContainer,
        miscellaneousOnIndigoContainer,
        miscellaneousOnOrangeContainer,
        miscellaneousOnPinkContainer,
        miscellaneousOnVioletContainer,
        miscellaneousOrange,
        miscellaneousOrangeContainer,
        miscellaneousOrangeHover,
        miscellaneousOrangeVariant,
        miscellaneousPink,
        miscellaneousPinkContainer,
        miscellaneousPinkHover,
        miscellaneousPinkVariant,
        miscellaneousViolet,
        miscellaneousVioletContainer,
        miscellaneousVioletHover,
        miscellaneousVioletVariant,
        onErrorContainer,
        onSecondaryContainer,
        onSuccessContainer,
        onWarningContainer,
        primaryHover,
        primaryVariant,
        secondaryContainer,
        secondaryHover,
        secondaryVariant,
        successContainer,
        successHover,
        successVariant,
        warningContainer,
        warningHover,
        warningVariant
      ]);

  @override
  bool operator ==(Object other) {
    return other is NorthstarColorTokens &&
        other.primary == primary &&
        other.onPrimary == onPrimary &&
        other.primaryContainer == primaryContainer &&
        other.onPrimaryContainer == onPrimaryContainer &&
        other.secondary == secondary &&
        other.onSecondary == onSecondary &&
        other.surface == surface &&
        other.onSurface == onSurface &&
        other.onSurfaceVariant == onSurfaceVariant &&
        other.surfaceContainerLow == surfaceContainerLow &&
        other.surfaceContainerHigh == surfaceContainerHigh &&
        other.outline == outline &&
        other.outlineVariant == outlineVariant &&
        other.error == error &&
        other.onError == onError &&
        other.success == success &&
        other.onSuccess == onSuccess &&
        other.warning == warning &&
        other.onWarning == onWarning &&
        other.inverseSurface == inverseSurface &&
        other.onInverseSurface == onInverseSurface &&
        other.background == background &&
        other.backgroundBright == backgroundBright &&
        other.backgroundDim == backgroundDim &&
        other.border == border &&
        other.card0 == card0 &&
        other.card10 == card10 &&
        other.card20 == card20 &&
        other.card30 == card30 &&
        other.card40 == card40 &&
        other.contentBlack == contentBlack &&
        other.contentGray == contentGray &&
        other.contentGrayBright == contentGrayBright &&
        other.contentWhite == contentWhite &&
        other.divider == divider &&
        other.errorContainer == errorContainer &&
        other.errorVariant == errorVariant &&
        other.errorHover == errorHover &&
        other.logotype == logotype &&
        other.miscellaneousBlue == miscellaneousBlue &&
        other.miscellaneousBlueContainer == miscellaneousBlueContainer &&
        other.miscellaneousBlueHover == miscellaneousBlueHover &&
        other.miscellaneousBlueVariant == miscellaneousBlueVariant &&
        other.miscellaneousEmerald == miscellaneousEmerald &&
        other.miscellaneousEmeraldContainer == miscellaneousEmeraldContainer &&
        other.miscellaneousEmeraldHover == miscellaneousEmeraldHover &&
        other.miscellaneousEmeraldVariant == miscellaneousEmeraldVariant &&
        other.miscellaneousIndigo == miscellaneousIndigo &&
        other.miscellaneousIndigoContainer == miscellaneousIndigoContainer &&
        other.miscellaneousIndigoHover == miscellaneousIndigoHover &&
        other.miscellaneousIndigoVariant == miscellaneousIndigoVariant &&
        other.miscellaneousOnBlueContainer == miscellaneousOnBlueContainer &&
        other.miscellaneousOnEmeraldContainer ==
            miscellaneousOnEmeraldContainer &&
        other.miscellaneousOnIndigoContainer ==
            miscellaneousOnIndigoContainer &&
        other.miscellaneousOnOrangeContainer ==
            miscellaneousOnOrangeContainer &&
        other.miscellaneousOnPinkContainer == miscellaneousOnPinkContainer &&
        other.miscellaneousOnVioletContainer ==
            miscellaneousOnVioletContainer &&
        other.miscellaneousOrange == miscellaneousOrange &&
        other.miscellaneousOrangeContainer == miscellaneousOrangeContainer &&
        other.miscellaneousOrangeHover == miscellaneousOrangeHover &&
        other.miscellaneousOrangeVariant == miscellaneousOrangeVariant &&
        other.miscellaneousPink == miscellaneousPink &&
        other.miscellaneousPinkContainer == miscellaneousPinkContainer &&
        other.miscellaneousPinkHover == miscellaneousPinkHover &&
        other.miscellaneousPinkVariant == miscellaneousPinkVariant &&
        other.miscellaneousViolet == miscellaneousViolet &&
        other.miscellaneousVioletContainer == miscellaneousVioletContainer &&
        other.miscellaneousVioletHover == miscellaneousVioletHover &&
        other.miscellaneousVioletVariant == miscellaneousVioletVariant &&
        other.onErrorContainer == onErrorContainer &&
        other.onSecondaryContainer == onSecondaryContainer &&
        other.onSuccessContainer == onSuccessContainer &&
        other.onWarningContainer == onWarningContainer &&
        other.primaryHover == primaryHover &&
        other.primaryVariant == primaryVariant &&
        other.secondaryContainer == secondaryContainer &&
        other.secondaryHover == secondaryHover &&
        other.secondaryVariant == secondaryVariant &&
        other.successContainer == successContainer &&
        other.successHover == successHover &&
        other.successVariant == successVariant &&
        other.warningContainer == warningContainer &&
        other.warningHover == warningHover &&
        other.warningVariant == warningVariant;
  }
}

/// Bridges common [ColorScheme] roles to [NorthstarColorTokens] so apps and
/// widgets can read **one** extension for semantic paint (even when
/// [ColorScheme] is seed-derived via [NorthstarTheme.buildThemeData]).
extension NorthstarColorTokensMaterialBridge on NorthstarColorTokens {
  /// Strongest container tier in M3; Northstar ships [surfaceContainerLow] and
  /// [surfaceContainerHigh] only — this maps to **high** for elevated panels.
  Color get surfaceContainerHighest => surfaceContainerHigh;
}
