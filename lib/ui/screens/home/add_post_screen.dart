import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:health_tracker/data/repositories/firestore.dart';
import 'package:health_tracker/shared/services/user_provider.dart';
import 'package:health_tracker/shared/utilities/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();

  _selectImage(BuildContext parentContext) async {
    return showDialog(
        context: parentContext,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Create a Post'),
            children: <Widget>[
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a Photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  Future<void> postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start loading
    try {
      String res = await FireStoreCrud().uploadPost(
          _descriptionController.text, _file, uid, username, profImage);
      if (res == 'success') {
        setState(() {
          isLoading = false;
        });
        if (!mounted) {
          return;
        }
        showSnackBar(context, 'Posted!');
        clearImage();
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        showSnackBar(context, e.toString());
      });
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          'Update Status',
        ),
        centerTitle: false,
        actions: <Widget>[
          _file == null
              ? IconButton(
                  icon: const Icon(Icons.upload),
                  onPressed: () => _selectImage(context),
                )
              : IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: clearImage,
                ),
          IconButton(
              onPressed: () async {
                await postImage(
                  userProvider.getUser.uid,
                  userProvider.getUser.username,
                  userProvider.getUser.photoUrl,
                );
                if (!mounted) {
                  return;
                }
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.send))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            isLoading
                ? const LinearProgressIndicator()
                : const Padding(padding: EdgeInsets.only(top: 0)),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    userProvider.getUser.photoUrl,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                        hintText: "Write a caption...",
                        border: InputBorder.none),
                    maxLines: 8,
                  ),
                ),
                // SizedBox(
                //   height: 45.0,
                //   width: 45.0,
                //   child: AspectRatio(
                //     aspectRatio: 487 / 451,
                //     child: _file == null
                //         ? Center(
                //             child: IconButton(
                //               icon: const Icon(Icons.upload),
                //               onPressed: () => _selectImage(context),
                //             ),
                //           )
                //         : Container(
                //             decoration: BoxDecoration(
                //                 image: DecorationImage(
                //               fit: BoxFit.fill,
                //               alignment: FractionalOffset.topCenter,
                //               image: MemoryImage(_file!),
                //             )),
                //           ),
                //   ),
                // ),
              ],
            ),
            _file != null
                ? SizedBox(
                    height: 350,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter,
                        image: MemoryImage(_file!),
                      )),
                    ),
                  )
                : const SizedBox(),
            const Divider(),
          ]),
        ),
      ),
    );
  }
}
