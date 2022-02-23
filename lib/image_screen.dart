import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_insta/sizes_helpers.dart';

class ImageFromGallery extends StatefulWidget {
  const ImageFromGallery({Key? key}) : super(key: key);

  @override
  ImageFromGalleryState createState() => ImageFromGalleryState();
}

class ImageFromGalleryState extends State<ImageFromGallery> {
  var _image;
  var imagePicker;
  final textController = TextEditingController();
  final textTagController = TextEditingController();

  Offset offset = Offset.zero;
  double _fontSize = 14;
  bool tagFilterSel = false;
  final List<String> _instaTags = [
    "love",
    "fashion",
    "happy",
    "beautiful",
    "amazon",
    "cute",
    "soft",
    "sunny",
    "bling",
    "funny",
    "luck",
    "life",
    "late",
    "live",
    "laugh",
    "smile",
    "chill",
    "hot",
    "chocolate",
    "rose",
    "rain",
    "summer",
    "shiver",
    "pain",
    "winter",
    "pool",
    "home",
    "work it",
  ];
  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    getImagesFromGallery();
  }

  Future<void> getImagesFromGallery() async {
    var source = ImageSource.gallery;
    XFile image = await imagePicker.pickImage(
        source: source,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      _image = File(image.path);
    });
  }

  void addTextOnImage() {
    textController.clear();
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.black45,
        builder: (BuildContext context) {
          return Column(children: [
            SizedBox(
              width: displayWidth(context) - 32,
              height: displayHeight(context) / 15,
              child: TextField(
                controller: textController,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: "Type the Text",
                  hintStyle: const TextStyle(
                    color: Colors.white38,
                  ),
                  suffixIcon: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ]);
        });
  }

  void addTagOnImage() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.black45,
        builder: (BuildContext context) {
          return Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _instaTags.sort();
                            Navigator.pop(context);
                            addTagOnImage();
                          });
                          //print(_instaTags);
                        },
                        icon: const Icon(
                          Icons.sort_by_alpha,
                          color: Colors.white,
                        ),
                      ),
                      if (!tagFilterSel)
                        IconButton(
                          onPressed: () {
                            setState(() {
                              tagFilterSel = true;
                              textTagController.clear();
                              Navigator.pop(context);
                              //_instaTags.retainWhere(
                              //     (element) => element.startsWith('s'));

                              addTagOnImage();
                              //print("f");
                            });
                          },
                          icon: const Icon(
                            Icons.filter_alt,
                            color: Colors.white,
                          ),
                        ),
                      if (tagFilterSel)
                        SizedBox(
                          //color: Colors.green,
                          width: displayWidth(context) / 2,
                          height: displayHeight(context) / 20,
                          child: TextField(
                            controller: textTagController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: "Your tag should contain",
                              hintStyle: TextStyle(color: Colors.white38),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: displayWidth(context),
                height: displayHeight(context) / 2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (textTagController.text.isEmpty)
                        for (int i = 0; i < _instaTags.length; i++)
                          ListTile(
                            title: Text(
                              _instaTags[i],
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                      else
                        for (int i = 0; i < _instaTags.length; i++)
                          if (_instaTags[i].contains(textTagController.text))
                            ListTile(
                              title: Text(
                                _instaTags[i],
                                style: const TextStyle(color: Colors.white),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image from Gallery"),
        backgroundColor: Colors.pink[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  width: displayWidth(context),
                  height: displayHeight(context) / 1.5,
                  decoration: BoxDecoration(color: Colors.red[200]),
                  child: _image != null
                      ? Image.file(
                          _image,
                          width: displayWidth(context),
                          height: displayHeight(context),
                          fit: BoxFit.cover,
                        )
                      : Container(
                          decoration: BoxDecoration(color: Colors.red[200]),
                          width: displayWidth(context),
                          height: displayHeight(context),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                ),
                if (textController.text.isNotEmpty)
                  Positioned(
                    left: offset.dx,
                    top: offset.dy,
                    child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            offset = Offset(offset.dx + details.delta.dx,
                                offset.dy + details.delta.dy);
                          });
                        },
                        child: Container(
                          //color: Colors.black,
                          width: 300,
                          height: 300,
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              textController.text,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: _fontSize,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: addTextOnImage,
                    child: Container(
                      width: displayWidth(context) / 3,
                      height: displayHeight(context) / 20,
                      decoration: BoxDecoration(
                        color: Colors.pink[900],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Add Text",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        tagFilterSel = false;
                      });
                      addTagOnImage();
                    },
                    child: Container(
                      width: displayWidth(context) / 3,
                      height: displayHeight(context) / 20,
                      decoration: BoxDecoration(
                        color: Colors.pink[900],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Add Tag",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (textController.text.isNotEmpty)
              Slider(
                  min: 10,
                  max: 60,
                  activeColor: Colors.pink[900],
                  inactiveColor: Colors.purple[100],
                  label: _fontSize.toString(),
                  value: _fontSize,
                  onChanged: (chngSize) {
                    setState(() {
                      _fontSize = chngSize;
                    });
                  }),
          ],
        ),
      ),
    );
  }
}
