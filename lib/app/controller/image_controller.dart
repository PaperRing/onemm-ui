import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onemm/app/mapper/image_mapper.dart';

class ImageController extends GetxController {
  final ImageMapper imageMapper;
  RxString selectedImagePath = ''.obs;
  RxString selectedImageSize = ''.obs;
  final _preSignedUrl = ''.obs;
  RxBool imageBool = false.obs;
  RxBool s3DeleteBool = false.obs;

  get preSignedUrl => _preSignedUrl.value;

  get filePath => null;

  set preSignedUrl(value) => _preSignedUrl.value = value;

  ImageController({required this.imageMapper});

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    }
  }

  deleteImage() {
    selectedImagePath.value = '';
    imageBool.value = false;
  }

  getS3PreSignedUrl(String folder, String fileName) async {
    return await imageMapper.getPreSignedUrl(folder, fileName);
  }

  putS3(String url, File file) async {
    await imageMapper.putS3(url, file);
  }

  getS3(String url) async {
    await imageMapper.getS3(url);
  }
}
