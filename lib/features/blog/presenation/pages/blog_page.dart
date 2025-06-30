import 'package:flutter/material.dart';
import 'package:subablog/features/blog/presenation/pages/add_blog_page.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddBlogPage.route());
            },
            icon: Icon(Icons.add_circle_outline_outlined),
          ),
        ],
      ),
    );
  }
}
