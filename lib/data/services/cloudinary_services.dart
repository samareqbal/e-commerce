import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../utils/constants/apis.dart';
import '../../utils/constants/keys.dart';

class CloudinaryServices extends GetxController{
  static CloudinaryServices get instance => Get.find();

  final _dio = dio.Dio();

  //Upload pic
  Future<dio.Response> uploadImage(File image, String folderName) async {
    try{

      String url = SApiUrls.uploadApi(SKeys.cloudName);

      dio.FormData formData = dio.FormData.fromMap({
        'upload_preset': SKeys.uploadPreset,
        'folder': folderName,
        'file': await dio.MultipartFile.fromFile(image.path, filename: image.path.split('/').last)
      });

      dio.Response response = await _dio.post(url, data: formData);

      return response;

    }catch(e){
      throw 'Failed to upload profile picture. Please try again';
    }
  }

  //delete pic
  Future<dio.Response> deleteImage(String publicId) async {
    try{

      String url = SApiUrls.deleteApi(SKeys.cloudName);

      int timestamp = (DateTime.now().millisecondsSinceEpoch / 1000).round();

      String signatureBase = 'public_id=$publicId&timestamp=$timestamp${SKeys.apiSecret}';

      String signature = sha1.convert(utf8.encode(signatureBase)).toString();

      dio.FormData formData = dio.FormData.fromMap({
        'public_id': publicId,
        'api_key': SKeys.apiKey,
        'timestamp': timestamp,
        'signature': signature
      });

      dio.Response response = await _dio.post(url , data:formData);

      return response;

    }catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
}