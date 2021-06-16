import 'package:flutter/material.dart';
import 'dart:core';
import 'package:file_picker/file_picker.dart';

class FilePickerScreen extends StatefulWidget {
  @override
  _FilePickerScreenState createState() => _FilePickerScreenState();
}

class _FilePickerScreenState extends State<FilePickerScreen> {

  List<Map<String, dynamic>> selectedFilesList = [];

  @override
  initState() {
    super.initState();
    openFilePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Files'),
    ),
    body: fileListView());
  }

  Widget fileListView() {
    return Container(
      child: ListView.builder(
          itemCount: selectedFilesList.length,
          itemBuilder: (context, index) {
            return Card(
                child: Column(
                    children: [
                      Text(selectedFilesList[index]['name']),
                      Text(selectedFilesList[index]['path']),
                    ]
                )
            );
          }),
    );
  }

  openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'doc', 'png'],
        allowMultiple: true);

    List<Map<String, dynamic>> tempList = [];

    if (result != null) {
      for (PlatformFile file in result.files) {
        // PlatformFile platformFile = file;
        Map<String, dynamic> fileInfo = {
          'name': file.name,
          'extension': file.extension,
          'path': file.path
        };
        tempList.add(fileInfo);
      }

      setState(() => selectedFilesList = tempList);
    } else {
      // User canceled the picker
    }
  }
}
