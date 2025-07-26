import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;

  const OptionCard({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: ListTile(
        title: Text(text),
        onTap: onTap,
      ),
    );
  }
}
