import 'package:dsr/theme.dart';
import 'package:dsr/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui/pages/home.dart';

void main() {
  runApp(ProviderScope(child: MyApp())); // Wrap your app with ProviderScope
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider).themeMode;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
          fontFamily: 'JosefinSans',
        );
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily  Scripture Reading',
      themeMode: themeMode,
      theme: theme.light().copyWith(
            textTheme: textTheme,
            primaryTextTheme: textTheme,
          ),
      darkTheme: theme.dark().copyWith(
            textTheme: textTheme,
            primaryTextTheme: textTheme,
          ),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => Home(),
      },
    );
  }
}
