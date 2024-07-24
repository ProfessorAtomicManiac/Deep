import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  const Content({super.key, required this.title, required this.content});

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleTextStyle = theme.textTheme.titleLarge!.copyWith(
      color: theme.colorScheme.onSurface,
    );
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 50,
          right: 50,
        ),
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  bottom: 25,
                ),
                child: Text(
                  title,
                  style: titleTextStyle,
                ),
              ),
              Expanded(
                child: content,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
