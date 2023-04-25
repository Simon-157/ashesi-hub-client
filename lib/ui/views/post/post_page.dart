import 'package:flutter/material.dart';
import 'package:hub_client/models/post_model.dart';
import 'package:hub_client/services/firestore_services/posts_service.dart';
import 'package:hub_client/ui/views/post/post_view.dart';

class PostPage extends StatefulWidget {
  final String postId;

  const PostPage({Key? key, required this.postId}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  PostModel? _post;

  @override
  void initState() {
    super.initState();
    _getPost();
  }

  void _getPost() async {
    PostModel? post = await PostService().getPost(widget.postId);
    setState(() {
      _post = post;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Color(0xFF05182D),
            Color(0xFF092A45),
            Color(0xFF0D2339)
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _post == null ? Center(child: CircularProgressIndicator()) : PostView(post: _post!),
      ),
    );
  }
}
