import 'package:flutter/material.dart';

class SearchTag extends StatelessWidget {
  const SearchTag({super.key, required this.email, required this.name});

  final String email;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(name),
    );
  }
}