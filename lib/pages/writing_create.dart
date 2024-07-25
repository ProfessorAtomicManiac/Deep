import 'package:flutter/material.dart';

class WritingCreate extends StatelessWidget {
  const WritingCreate({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleTextStyle = theme.textTheme.titleLarge!.copyWith(
      color: theme.colorScheme.onSurface,
    );
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(5, (index) {
        return Center(
          child: Text(
            "Ambitious",
            style: titleTextStyle,
          ),
        );
      }),
    );
  }
}
