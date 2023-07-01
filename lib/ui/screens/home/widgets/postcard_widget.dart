import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/data/models/user_model.dart' as model;
import 'package:health_tracker/data/repositories/firestore.dart';
import 'package:health_tracker/shared/services/user_provider.dart';
import 'package:health_tracker/shared/utilities/utils.dart';
import 'package:health_tracker/ui/screens/home/comments_screen.dart';
import 'package:health_tracker/ui/screens/home/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final dynamic snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;
  bool isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
    fetchCommentLen();
  }

  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
    mounted ? setState(() {}) : null;
    // setState(() {});
  }

  deletePost(String postId) async {
    try {
      await FireStoreCrud().deletePost(postId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(255, 16, 16, 16)
            : Colors.grey.shade200,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(children: [
        // ? POST HEADER
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 16,
          ).copyWith(right: 0),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                  widget.snap['profImage'].toString(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.snap['username'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              widget.snap['uid'].toString() == user.uid
                  ? IconButton(
                      onPressed: () {
                        showDialog(
                          useRootNavigator: false,
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: ListView(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shrinkWrap: true,
                                  children: [
                                    'Delete',
                                  ]
                                      .map(
                                        (e) => InkWell(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                              child: Text(e),
                                            ),
                                            onTap: () {
                                              deletePost(
                                                widget.snap['postId']
                                                    .toString(),
                                              );
                                              // remove the dialog box
                                              Navigator.of(context).pop();
                                            }),
                                      )
                                      .toList()),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.more_vert),
                    )
                  : Container(),
            ],
          ),
        ),
        // ? POST DESCRIPTION AND NUMBER OF COMMENTS
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  DateFormat.yMMMd()
                      .format(widget.snap['datePublished'].toDate()),
                  style: const TextStyle(
                      // color: secondaryColor,
                      ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: ExpandableText(
                  widget.snap['description'].toString(),
                  expandText: 'more',
                  collapseText: 'less',
                  maxLines: 3,
                  linkColor: Colors.blue,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                // Text(' ${widget.snap['description']}'),
              ),
            ],
          ),
        ),
        // ? POST IMAGE
        widget.snap['postUrl'] != null
            ? GestureDetector(
                onDoubleTap: () {
                  FireStoreCrud().likePost(
                    widget.snap['postId'].toString(),
                    user.uid,
                    widget.snap['likes'],
                  );
                  setState(() {
                    isLikeAnimating = true;
                  });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      child: Image.network(
                        widget.snap['postUrl'].toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isLikeAnimating ? 1 : 0,
                      child: LikeAnimation(
                        isAnimating: isLikeAnimating,
                        duration: const Duration(
                          milliseconds: 400,
                        ),
                        onEnd: () {
                          setState(() {
                            isLikeAnimating = false;
                          });
                        },
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 100,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: DefaultTextStyle(
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.w800),
                child: Text(
                  '${widget.snap['likes'].length} likes',
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
          ),
        ),

        const Divider(),
        // ? LIKE | COMMENT
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LikeAnimation(
                        isAnimating: widget.snap['likes'].contains(user.uid),
                        smallLike: true,
                        child: IconButton(
                          icon: widget.snap['likes'].contains(user.uid)
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                ),
                          onPressed: () => FireStoreCrud().likePost(
                            widget.snap['postId'].toString(),
                            user.uid,
                            widget.snap['likes'],
                          ),
                        ),
                      ),
                      const Text('Like')
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentsScreen(
                      postId: widget.snap['postId'].toString(),
                    ),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // IconButton(
                    //   icon: const Icon(
                    //     CupertinoIcons.text_bubble,
                    //   ),
                    //   onPressed: () => Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) => CommentsScreen(
                    //         postId: widget.snap['postId'].toString(),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Icon(CupertinoIcons.text_bubble),
                    SizedBox(width: 10,),
                    Text('Comment')
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
