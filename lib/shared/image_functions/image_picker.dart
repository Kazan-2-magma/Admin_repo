import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

XFile? _image;
final picker = ImagePicker();

//Photo
Future<void> getImageFromGallery() async {
    try{
     await picker.pickImage(source: ImageSource.gallery);
    }catch(e){
      print(e.toString());
    }
}
//Image to base64
Future<String>? convertXFileIntoBase64() async {
  String converter = "";
  if(_image != null){
    Uint8List bytes = await _image!.readAsBytes();
    converter = base64Encode(bytes);
  }
  return converter;
}

Image? convertStringToXFile(String imageString)  {
  try {
    Uint8List bytes = base64Decode(imageString);
    Image image = Image.memory(bytes);
    return image;
  }catch (e) {
    print('Error converting string to XFile: $e');
    return null;
  }
}

