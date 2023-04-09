import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:hub_client/services/posts_service.dart';
import 'package:hub_client/utils/post_view.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:provider/provider.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _captionController = TextEditingController();
  String _image;
  String _description;
  File imageFile;
  File img;
  PostService postService = PostService();

  Future<void> _getImage(BuildContext context) async {
    // final pickedFile = await ImagePickerWeb.getImageInfo;
    imageFile = await ImagePickerWeb.getImageAsFile();

    // if (pickedFile != null) {
    //   setState(() {
    //     _image = pickedFile.base64;
    //   });
    // }

    if (imageFile != null) {
      setState(() {
        img = imageFile;
      });
    }
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postsViewModel = Provider.of<PostsViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/logo_ashesi.png',
          width: 50,
          height: 50,
        ),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Save post logic
            },
            child: const Text(
              'Post',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_image != null) ...[
                Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(
                        // Decoding from base64 to bytes.
                        base64.decode(img.toString()),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: TextButton(
                        onPressed: () async {
                          postsViewModel.pickImage(context);
                        },
                        child: Container(
                          height: 100,
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: const Center(
                            child: Text('Tap to select image'),
                          ),
                        )),
                  ),
                  // TextButton(
                  //   onPressed: () => _getImage(context),
                  //   child: const Text('Take Photo'),
                  // ),
                ],
              ),
              const SizedBox(height: 32),
              Container(
                width: 400,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _captionController,
                        decoration: const InputDecoration(
                          hintText: 'Write a caption',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: null,
                        onChanged: (value) {
                          setState(() {
                            _description = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height:
                          50, // set the width of SizedBox to a specific value
                      child: Container(
                        color: Colors.blue,
                        child: IconButton(
                          icon: const Icon(Icons.send_rounded),
                          onPressed: () {
                            postService.uploadPost(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQDDpg-HtJ5hNVcPj3QDk6q0xmOmQYrdP9jw',
                                _description);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
