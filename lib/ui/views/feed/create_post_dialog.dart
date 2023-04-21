import 'package:flutter/material.dart';
import 'package:hub_client/services/posts_service.dart';
import 'package:hub_client/ui/widgets/common/image_upload.dart';

class CreatePostDialog extends StatefulWidget {
  const CreatePostDialog({Key? key}) : super(key: key);

  @override
  _CreatePostDialogState createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends State<CreatePostDialog> {
  final _captionController = TextEditingController();
  late String _description;
  late String imageUri = "";

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
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 16, 32, 51),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: SingleChildScrollView(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF05182D),
                  Color.fromARGB(255, 7, 30, 49),
                  Color.fromARGB(255, 9, 30, 52)
                ]),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: const [
                // CircleAvatar(
                //   radius: 20.0,
                //   backgroundImage: CachedNetworkImageProvider(user['avatar_url']),
                // ),
                Text(
                  'Create Post',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              TextField(
                controller: _captionController,
                style: const TextStyle(color: Colors.white),
                maxLines: 2,
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'What\'s happening?',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.emoji_emotions,
                      color: Color.fromARGB(209, 183, 194, 38),
                    ),
                    onPressed: () {
                      //TODO: Add emoji selection functionality
                    },
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  ImageUploader(
                    onImageUrlChanged: setImageUrl,
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color.fromARGB(255, 220, 77, 15),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                      onPressed: () {
                        postService
                            .uploadPost(context, imageUri, _description)
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
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        });
                      },
                      child: const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 38, 88, 108),
                        child: Icon(Icons.send),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
