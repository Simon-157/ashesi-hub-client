// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUploader extends StatefulWidget {
  final Function(String)? onImageUrlChanged;
  const ImageUploader({Key? key, this.onImageUrlChanged}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  String? imageUrl;

  Future<void> _pickImage() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((event) async {
      final file = uploadInput.files?.first;
      final uuid = const Uuid().v4(); // generate a unique identifier
      final fileName =
          '$uuid.jpg'; // use the unique identifier as the file name
      final Reference storageRef =
          FirebaseStorage.instance.ref().child('posts_images/$fileName');
      final UploadTask uploadTask = storageRef.putBlob(file);
      await uploadTask;
      final url = await storageRef.getDownloadURL();
      setState(() {
        imageUrl = url;
        if (widget.onImageUrlChanged != null) {
          widget.onImageUrlChanged!(imageUrl!);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: _pickImage,
          icon: const Icon(Icons.image_outlined),
        ),
        if (imageUrl != null)
          CachedNetworkImage(
            imageUrl: imageUrl!,
            height: 300,
            width: 300,
          ),
      ],
    );
  }
}
