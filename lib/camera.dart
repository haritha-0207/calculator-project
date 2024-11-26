import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'main.dart';
void main(){
  runApp( ProfileImagePicker());
}
class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker({super.key});

  @override
  ProfileImagePickerState createState() => ProfileImagePickerState();
}

class ProfileImagePickerState extends State<ProfileImagePicker> {
  Uint8List? _pickedProfileImageBytes;
  bool _isHovered = false;
  final String _initials = 'AB';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    home: Scaffold(
      body:MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 170,
            width: 170,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _pickedProfileImageBytes == null
                  ?  Colors.black
                  :Colors.white,
              shape: BoxShape.circle,
              image: _pickedProfileImageBytes != null
                  ? DecorationImage(
                image: MemoryImage(_pickedProfileImageBytes!),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: _pickedProfileImageBytes == null
                ? Text(
              _initials,
              style:
             TextStyle(),
            )
                : null,
          ),
          AnimatedOpacity(
            opacity: _isHovered ? 0.7 : 0.0,
            duration: const Duration(milliseconds: 300),
            child:Center(
          child:   Container(
              height: 300,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle
              ),
            ),
          ),
          ),
          InkWell(
            onTap: _pickImage,
            child: AnimatedOpacity(
              opacity: _isHovered ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: const Icon(
                Icons.add_circle,
                color: Colors.deepPurple,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    )
    )
    );
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      if (fileBytes != null) {
        setState(() {
          _pickedProfileImageBytes = fileBytes;
        });
      }
    }
  }
}
