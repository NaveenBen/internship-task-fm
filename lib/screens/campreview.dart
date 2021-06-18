import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../main.dart';

// ignore: must_be_immutable
class CamPrev extends StatefulWidget {
  List<CameraDescription> cameras;
  CamPrev(this.cameras);
  @override
  _CamPrevState createState() => _CamPrevState();
}

class _CamPrevState extends State<CamPrev> {
  late CameraController con;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    con = new CameraController(cameras[0], ResolutionPreset.high,
        enableAudio: true);
    con.initialize().then((_) {
      if (!mounted) {
        return;
      } else {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!con.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    } else {
      return AspectRatio(
        aspectRatio: con.value.aspectRatio,
        child: CameraPreview(con),
      );
    }
  }
}
