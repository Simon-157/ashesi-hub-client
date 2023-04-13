import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_client/services/posts_service.dart';
import 'package:hub_client/ui/widgets/common/image_upload.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _captionController = TextEditingController();
  late String _description;
  late String imageUri;

  PostService postService = PostService();

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  void setImageUrl(String url) {
    setState(() {
      imageUri = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Center(child: ImageUploader(onImageUrlChanged: setImageUrl)),
            const SizedBox(height: 32),
            SizedBox(
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
                    height: 50, // set the width of SizedBox to a specific value
                    child: Container(
                      color: Colors.blue,
                      child: IconButton(
                        icon: const Icon(Icons.send_rounded),
                        onPressed: () {
                          postService
                              .uploadPost(imageUri, _description)
                              .then((value) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Post created'),
                                  content: const Text(
                                      'Your post has been successfully created.'),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        context.go("/feeds");
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          });
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
    );
  }
}
