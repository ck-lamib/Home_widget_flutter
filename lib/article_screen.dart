import 'dart:io';

import 'package:flutter/material.dart';
import 'package:home_widget_test/home_screen.dart';
import 'package:home_widget_test/news_data.dart';
import 'package:image_picker/image_picker.dart';

class ArticleScreen extends StatefulWidget {
  final NewsArticle article;
  const ArticleScreen({
    super.key,
    required this.article,
  });

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  File? pickedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.title),
      ),
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text("Description: ${widget.article.description}"),
          SizedBox(
            height: 10,
          ),
          if (pickedFile != null)
            Container(
              width: 300,
              child: Image.file(pickedFile!),
            )
        ],
      )),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 10,
          ),
          FloatingActionButton.extended(
            heroTag: 'btn1',
            onPressed: () async {
              ImagePicker imagePicker = ImagePicker();
              XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

              if (file != null) {
                setState(() {
                  pickedFile = File(file.path);
                });
              }
            },
            label: const Text('Pick Image'),
          ),
          FloatingActionButton.extended(
            heroTag: 'btn2',
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Updating home screen widget...'),
              ));
              NewsArticle newsArticle;
              // New: call updateHeadline
              if (pickedFile != null) {
                print("not nujll");
                newsArticle = NewsArticle(
                  title: widget.article.title,
                  description: widget.article.description,
                  filename: pickedFile!.path,
                );
              } else {
                newsArticle = NewsArticle(
                  title: widget.article.title,
                  description: widget.article.description,
                );
              }

              updateHeadline(newsArticle);
            },
            label: const Text('Update Homescreen'),
          ),
        ],
      ),
    );
  }
}
