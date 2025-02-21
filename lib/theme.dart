import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4285158541),
      surfaceTint: Color(4285158541),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4293713151),
      onPrimaryContainer: Color(4283579507),
      secondary: Color(4284766832),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4293648119),
      onSecondaryContainer: Color(4283188055),
      tertiary: Color(4286534235),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294957535),
      onTertiaryContainer: Color(4284758852),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4287823882),
      surface: Color(4294899711),
      onSurface: Color(4280097312),
      onSurfaceVariant: Color(4283057486),
      outline: Color(4286281087),
      outlineVariant: Color(4291544271),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281478965),
      inversePrimary: Color(4292197372),
      primaryFixed: Color(4293713151),
      onPrimaryFixed: Color(4280618565),
      primaryFixedDim: Color(4292197372),
      onPrimaryFixedVariant: Color(4283579507),
      secondaryFixed: Color(4293648119),
      onSecondaryFixed: Color(4280227882),
      secondaryFixedDim: Color(4291740379),
      onSecondaryFixedVariant: Color(4283188055),
      tertiaryFixed: Color(4294957535),
      onTertiaryFixed: Color(4281471001),
      tertiaryFixedDim: Color(4294031298),
      onTertiaryFixedVariant: Color(4284758852),
      surfaceDim: Color(4292860128),
      surfaceBright: Color(4294899711),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294570489),
      surfaceContainer: Color(4294175988),
      surfaceContainerHigh: Color(4293781230),
      surfaceContainerHighest: Color(4293386472),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4282395489),
      surfaceTint: Color(4285158541),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4286145180),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282069830),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285753727),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4283509300),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4287586410),
      onTertiaryContainer: Color(4294967295),
      error: Color(4285792262),
      onError: Color(4294967295),
      errorContainer: Color(4291767335),
      onErrorContainer: Color(4294967295),
      surface: Color(4294899711),
      onSurface: Color(4279439381),
      onSurfaceVariant: Color(4281939005),
      outline: Color(4283781466),
      outlineVariant: Color(4285557621),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281478965),
      inversePrimary: Color(4292197372),
      primaryFixed: Color(4286145180),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4284500610),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285753727),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4284109158),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4287586410),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4285810770),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4291544268),
      surfaceBright: Color(4294899711),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294570489),
      surfaceContainer: Color(4293781230),
      surfaceContainerHigh: Color(4292991971),
      surfaceContainerHighest: Color(4292267991),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4281737558),
      surfaceTint: Color(4285158541),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4283711094),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281346364),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4283319642),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4282786090),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4284955974),
      onTertiaryContainer: Color(4294967295),
      error: Color(4284481540),
      onError: Color(4294967295),
      errorContainer: Color(4288151562),
      onErrorContainer: Color(4294967295),
      surface: Color(4294899711),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4278190080),
      outline: Color(4281215795),
      outlineVariant: Color(4283189072),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281478965),
      inversePrimary: Color(4292197372),
      primaryFixed: Color(4283711094),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4282197853),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4283319642),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4281806658),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4284955974),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4283246384),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4290623422),
      surfaceBright: Color(4294899711),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294373111),
      surfaceContainer: Color(4293386472),
      surfaceContainerHigh: Color(4292465370),
      surfaceContainerHighest: Color(4291544268),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4292197372),
      surfaceTint: Color(4292197372),
      onPrimary: Color(4282000731),
      primaryContainer: Color(4283579507),
      onPrimaryContainer: Color(4293713151),
      secondary: Color(4291740379),
      onSecondary: Color(4281675072),
      secondaryContainer: Color(4283188055),
      onSecondaryContainer: Color(4293648119),
      tertiary: Color(4294031298),
      onTertiary: Color(4283114798),
      tertiaryContainer: Color(4284758852),
      onTertiaryContainer: Color(4294957535),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279570968),
      onSurface: Color(4293386472),
      onSurfaceVariant: Color(4291544271),
      outline: Color(4287991449),
      outlineVariant: Color(4283057486),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293386472),
      inversePrimary: Color(4285158541),
      primaryFixed: Color(4293713151),
      onPrimaryFixed: Color(4280618565),
      primaryFixedDim: Color(4292197372),
      onPrimaryFixedVariant: Color(4283579507),
      secondaryFixed: Color(4293648119),
      onSecondaryFixed: Color(4280227882),
      secondaryFixedDim: Color(4291740379),
      onSecondaryFixedVariant: Color(4283188055),
      tertiaryFixed: Color(4294957535),
      onTertiaryFixed: Color(4281471001),
      tertiaryFixedDim: Color(4294031298),
      onTertiaryFixedVariant: Color(4284758852),
      surfaceDim: Color(4279570968),
      surfaceBright: Color(4282071102),
      surfaceContainerLowest: Color(4279242002),
      surfaceContainerLow: Color(4280097312),
      surfaceContainer: Color(4280360484),
      surfaceContainerHigh: Color(4281084207),
      surfaceContainerHighest: Color(4281807674),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4293449215),
      surfaceTint: Color(4292197372),
      onPrimary: Color(4281277007),
      primaryContainer: Color(4288579266),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4293187569),
      onSecondary: Color(4280951349),
      secondaryContainer: Color(4288122020),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294955481),
      onTertiary: Color(4282260003),
      tertiaryContainer: Color(4290216845),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294955724),
      onError: Color(4283695107),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279570968),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4293057253),
      outline: Color(4290162618),
      outlineVariant: Color(4287925912),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293386472),
      inversePrimary: Color(4283645300),
      primaryFixed: Color(4293713151),
      onPrimaryFixed: Color(4279894586),
      primaryFixedDim: Color(4292197372),
      onPrimaryFixedVariant: Color(4282395489),
      secondaryFixed: Color(4293648119),
      onSecondaryFixed: Color(4279569951),
      secondaryFixedDim: Color(4291740379),
      onSecondaryFixedVariant: Color(4282069830),
      tertiaryFixed: Color(4294957535),
      onTertiaryFixed: Color(4280616463),
      tertiaryFixedDim: Color(4294031298),
      onTertiaryFixedVariant: Color(4283509300),
      surfaceDim: Color(4279570968),
      surfaceBright: Color(4282860361),
      surfaceContainerLowest: Color(4278716171),
      surfaceContainerLow: Color(4280228898),
      surfaceContainer: Color(4280952621),
      surfaceContainerHigh: Color(4281676087),
      surfaceContainerHighest: Color(4282399811),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294438143),
      surfaceTint: Color(4292197372),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4291934199),
      onPrimaryContainer: Color(4279435311),
      secondary: Color(4294438143),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4291477207),
      onSecondaryContainer: Color(4279175193),
      tertiary: Color(4294962158),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4293768383),
      onTertiaryContainer: Color(4280091145),
      error: Color(4294962409),
      onError: Color(4278190080),
      errorContainer: Color(4294946468),
      onErrorContainer: Color(4280418305),
      surface: Color(4279570968),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294967295),
      outline: Color(4294372857),
      outlineVariant: Color(4291281099),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293386472),
      inversePrimary: Color(4283645300),
      primaryFixed: Color(4293713151),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4292197372),
      onPrimaryFixedVariant: Color(4279894586),
      secondaryFixed: Color(4293648119),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4291740379),
      onSecondaryFixedVariant: Color(4279569951),
      tertiaryFixed: Color(4294957535),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4294031298),
      onTertiaryFixedVariant: Color(4280616463),
      surfaceDim: Color(4279570968),
      surfaceBright: Color(4283584341),
      surfaceContainerLowest: Color(4278190080),
      surfaceContainerLow: Color(4280360484),
      surfaceContainer: Color(4281478965),
      surfaceContainerHigh: Color(4282268224),
      surfaceContainerHighest: Color(4282991948),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
