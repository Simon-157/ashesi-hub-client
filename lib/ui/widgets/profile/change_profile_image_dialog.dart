import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hub_client/ui/widgets/common/image_upload.dart';
import 'package:hub_client/utils/firebase_collections.dart';

class CameraDialog extends StatefulWidget {
  final String currentAvatarUri;
  final String profileId;
  const CameraDialog(
      {Key? key, required this.currentAvatarUri, required this.profileId})
      : super(key: key);

  @override
  _CameraDialogState createState() => _CameraDialogState();
}

class _CameraDialogState extends State<CameraDialog> {
  String? imageUri;
  bool _isLoading = false;

  void _updateImageUri(String uri) {
    setState(() {
      imageUri = uri;
    });
  }

  Future<void> _updateProfileImage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await usersRef.doc(widget.profileId).update({'avatar_url': imageUri});
      print('Profile image successfully updated');
      Navigator.of(context).pop();
    } catch (error) {
      print('Error updating profile image: $error');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AlertDialog(
        content: Column(
          children: [
            CachedNetworkImage(
              imageUrl: widget.currentAvatarUri,
              width: 300,
              height: 250,
            ),
            const SizedBox(
              height: 10,
            ),
            ImageUploader(onImageUrlChanged: _updateImageUri),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed: _isLoading ? null : _updateProfileImage,
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text('OK'),
          ),
        ],
      ),
    );
  }
}
