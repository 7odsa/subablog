import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:subablog/core/theme/app_colors.dart';
import 'package:subablog/core/utils/pick_image.dart';
import 'package:subablog/features/blog/domain/entities/blog.dart';
import 'package:subablog/features/blog/presenation/widgets/blog_editor.dart';

class AddBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddBlogPage());
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  File? image;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  Set<String> selectedTopics = {};

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // TODO
            },
            icon: Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  final imgFile = await pickImage();
                  if (imgFile != null) {
                    image = imgFile;
                    setState(() {});
                  }
                },
                child: DottedBorder(
                  options: RectDottedBorderOptions(
                    color: AppColors.borderColor,
                    dashPattern: [10, 5],
                    strokeCap: StrokeCap.round,
                  ),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    child: (image != null)
                        ? Image.file(image!, fit: BoxFit.cover)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.folder_open, size: 40),
                              SizedBox(height: 16),
                              Text(
                                "Select Your Image",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: Blog.topics
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: GestureDetector(
                            onTap: () {
                              selectedTopics.contains(e)
                                  ? selectedTopics.remove(e)
                                  : selectedTopics.add(e);
                              setState(() {});
                              print(selectedTopics);
                            },
                            child: Chip(
                              label: Text(e),
                              side: BorderSide(color: AppColors.borderColor),
                              color: WidgetStatePropertyAll(
                                (selectedTopics.contains(e)
                                    ? AppColors.gradient1
                                    : null),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 16),
              BlogEditor(controller: titleController, hint: "Blog Title"),
              SizedBox(height: 16),
              BlogEditor(controller: contentController, hint: "Blog Content"),
            ],
          ),
        ),
      ),
    );
  }
}
