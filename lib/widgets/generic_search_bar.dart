import 'package:flutter/material.dart';

class GenericSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onSearchChanged;
  final FocusNode focusNode;
  final VoidCallback? onEditingComplete;
  final List<Widget>? trailing;

  const GenericSearchBar({
    super.key,
    required this.hintText,
    required this.onSearchChanged,
    required this.focusNode,
    this.onEditingComplete,
    this.trailing = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchBar(
        focusNode: focusNode,
        leading: const Icon(Icons.search),
        trailing: trailing,
        hintText: hintText,
        onChanged: onSearchChanged,
        onSubmitted: onSearchChanged,
      ),
    );
  }
}
