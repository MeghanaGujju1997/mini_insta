import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_insta/image_screen.dart';
import 'package:mini_insta/sizes_helpers.dart';

class HomeScreen extends StatelessWidget {
  final ImagePicker picker = ImagePicker();

  HomeScreen({Key? key}) : super(key: key);
  void _handleURLButtonPress(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ImageFromGallery()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Center(
          child: InkWell(
        child: Container(
          width: displayWidth(context) / 2,
          height: displayHeight(context) / 20,
          decoration: BoxDecoration(
            color: Colors.pink[900],
            borderRadius: const BorderRadius.all(Radius.circular(25)),
          ),
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.camera_alt_outlined, color: Colors.white),
              Text(
                "Pick your Image",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        onTap: () {
          _handleURLButtonPress(context);
        },
      )),
    );
  }
}
