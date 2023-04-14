import 'package:flutter/material.dart';
import 'package:hub_client/models/post_model.dart';
import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/ui/widgets/post/post_buttons.dart';
import 'package:timeago/timeago.dart' as timeago;

class ViewImage extends StatefulWidget {
  final PostModel post;

  const ViewImage({Key? key, required this.post}) : super(key: key);

  @override
  _ViewImageState createState() => _ViewImageState();
}

final DateTime timestamp = DateTime.now();


late UserModel user;

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: buildImage(context, widget.post),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.username,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        const Icon(Icons.alarm_outlined, size: 13.0),
                        const SizedBox(width: 3.0),
                        Text(
                          timeago.format(widget.post.timestamp.toDate()),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                buildLikeButton(widget.post),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
