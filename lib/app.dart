import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app.g.dart';

@riverpod
String helloWorld(Ref ref) {
  return "Hello World...";
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(helloWorldProvider);

    return MaterialApp(
      home: Scaffold(body: Center(child: Text(value))),
    );
  }
}
