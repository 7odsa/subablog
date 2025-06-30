import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  const BlogEditor({super.key, required this.controller, required this.hint});
  final TextEditingController controller;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hint: Text(hint)),
      maxLines: null,
    );
  }
}
