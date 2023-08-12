
import 'dart:io';

import 'package:get/get_connect/connect.dart';
import 'package:image_picker/image_picker.dart';

import '../component/http.dart';
import '../config/host_config.dart';

class ImageMapper extends GetConnect {
  var url = HostConfig.host;

  getPreSignedUrl(String folder, String fileName) async {
    return await Http.I.post(
      "$url/s3/preSignedUrl?folder=$folder&fileName=$fileName",
      decode: false,
    );
  }

  putS3(String url, File file) async {
    await Http.I.sendFile(url, file);
  }

  getS3(String url) async{

  }
}
