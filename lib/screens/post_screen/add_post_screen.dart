// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jazzee/backend/jobdata/send_post.dart';
import 'package:jazzee/components/button.dart';
import 'package:jazzee/constants.dart/constants.dart';
import 'package:jazzee/core/theme/base_color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jazzee/main.dart';
import 'package:jazzee/screens/wrapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';
import 'package:path/path.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key, required this.name, this.college})
      : super(key: key);
  final String name;
  final String? college;
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  List<File> _selectedImages = [];
  bool _isLoading = false;
  final TextEditingController _postController = TextEditingController();

  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        _selectedImages = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  Future<List<String>> _uploadImagesAndSubmit() async {
    setState(() {
      _isLoading = true;
    });

    List<String> imageUrls = [];

    for (var image in _selectedImages) {
      String fileName = basename(image.path);
      try {
        final response = await Supabase.instance.client.storage
            .from('Post')
            .upload(fileName, image);

        if (response != null) {
          final String imageUrl = Supabase.instance.client.storage
              .from('Post')
              .getPublicUrl(fileName);

          imageUrls.add(imageUrl);
        } else {
          print('Upload Error: ${response}');
        }
      } catch (e) {
        print('Upload Exception: $e');
      }
    }
    setState(() {
      _isLoading = false;
    });
    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextField(
            controller: _postController,
            decoration: InputDecoration(
              labelText: 'What’s on your mind?',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
          ),
          SizedBox(height: 10),
          Button(
            onPressed: _pickImages,
            color: AppColors.primarycolor2,
            text: 'Add Image',
            minimumSize: Size(MediaQuery.of(context).size.width * 0.4, 40),
          ),
          SizedBox(height: 10),
          Expanded(
            child: _selectedImages.isEmpty
                ? Container()
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _selectedImages.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Image.file(_selectedImages[index], fit: BoxFit.cover),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: Icon(Icons.cancel, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _selectedImages.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
          SizedBox(height: 10),
          Button(
            onPressed: () async {
              final List<String> imageUrls = await _uploadImagesAndSubmit();
              await SendPosts()
                  .sendMPost(
                      supabase.auth.currentUser!.id,
                      _postController.text,
                      imageUrls.isEmpty ? '' : imageUrls.join(', '),
                      widget.name,
                      widget.college ?? '')
                  .then((value) {
                navigatorKey.currentState!.pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => wrapper()),
                    (route) => false);
              });
            },
            color: AppColors.black,
            text: _isLoading ? 'Uploading...' : 'Post',
            minimumSize: Size(double.infinity, 50),
          ),
        ],
      ),
    );
  }
}
