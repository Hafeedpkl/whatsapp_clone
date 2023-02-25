import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp_clone/ui/views/camera/camera_view_page.dart';

List<CameraDescription> cameras = [];

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  Future<void>? cameraValue;
  XFile? imageFile;
  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController?.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(child: CameraPreview(_cameraController!));
                } else {
                  return const SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              }),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.flash_off,
                            color: Colors.white,
                            size: 28,
                          )),
                      InkWell(
                        onTap: () {
                          takePhoto(context);
                        },
                        child: const Icon(
                          Icons.panorama_fish_eye,
                          color: Colors.white,
                          size: 70,
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 28,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Hold for Video, tap for photo',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    final directory = await getTemporaryDirectory();
    final filePath = path.join(directory.path, '${DateTime.now()}.png');

    try {
      XFile picture = await _cameraController!.takePicture();
      File file = File(picture.path);
      file.renameSync(filePath);
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CameraViewPage(path: filePath),
          ));
    } catch (e) {
      log(e.toString());
    }
  }
}
