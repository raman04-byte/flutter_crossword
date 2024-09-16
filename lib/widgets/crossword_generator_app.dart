
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import 'crossword_widget.dart';

class CrosswordGeneratorApp extends StatelessWidget {
  const CrosswordGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _EagerInitialization(
      child: Scaffold(
        appBar: AppBar(
          actions: [_CrosswordGeneratorMenu()],
          titleTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          title: const Text('Crossword Generator'),
        ),
        body: const SafeArea(
          child: CrosswordWidget(),
        ),
      ),
    );
  }
}

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(wordListProvider);
    return child;
  }
}

class _CrosswordGeneratorMenu extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) => MenuAnchor(
        menuChildren: [
          for (final entry in CrosswordSize.values)
            MenuItemButton(
              onPressed: () => ref.read(sizeProvider.notifier).setSize(entry),
              leadingIcon: entry == ref.watch(sizeProvider)
                  ? const Icon(Icons.radio_button_checked_outlined)
                  : const Icon(Icons.radio_button_unchecked_outlined),
              child: Text(entry.label),
            ),
        ],
        builder: (context, controller, child) => IconButton(
          onPressed: () => controller.open(),
          icon: const Icon(Icons.settings),
        ),
      );
}
