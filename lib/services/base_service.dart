import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hub_client/utils/file.dart';
import 'package:hub_client/utils/firebase_collections.dart';


abstract class Service {

  //function to upload images to firebase storage and retrieve the url.
  Future<String> uploadImage(Reference ref, File file) async {
    String ext = FileUtils.getFileExtension(file);
    Reference storageReference = ref.child("${uuid.v4()}.$ext");
    UploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.whenComplete(() => null);
    String fileUrl = await storageReference.getDownloadURL();
    return fileUrl;
  }
}