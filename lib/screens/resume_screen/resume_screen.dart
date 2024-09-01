// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jazzee/backend/getdata/get_personal_info.dart';
import 'package:jazzee/components/button.dart';
import 'package:jazzee/models/student/student_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../../components/basic_text.dart';
import '../../core/theme/base_color.dart';

class ResumeUploader extends StatefulWidget {
  final String studentId;

  ResumeUploader({required this.studentId});

  @override
  _ResumeUploaderState createState() => _ResumeUploaderState();
}

class _ResumeUploaderState extends State<ResumeUploader> {
  String? _fileUrl;
  String? _localPath;

  Future<void> _uploadResume() async {
    String? fileUrl = await pickAndUploadFileForStudent(widget.studentId);
    if (fileUrl != null) {
      setState(() {
        _fileUrl = fileUrl;
      });
      // Download the file to a local path to display in PDF viewer
      _localPath = await _downloadPdf();
      if (_localPath != null) {
        setState(() {
          _localPath = _localPath;
        });
      }
      await saveFileUrlToDatabase(widget.studentId, fileUrl).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('Resume uploaded successfully.'),
        ));
        _refresh();
      });
    }
  }

  Future<void> _refresh() async {
    _downloadPdf();
    student = GetPersonalInfo().GetUserStudent(widget.studentId);
  }

  String? localFilePath;

  Future<String> _downloadPdf() async {
    try {
      final responses = await Supabase.instance.client
          .from('students')
          .select('resume_url')
          .eq('student_id', widget.studentId)
          .single();

      if (responses != null) {
        final String url = responses['resume_url'] as String;
        print('url:$url');

        final response = await http.get(Uri.parse(url));
        final bytes = response.bodyBytes;

        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/temp.pdf');

        await file.writeAsBytes(bytes, flush: true);
        setState(() {
          localFilePath = file.path;
        });
      }
      return localFilePath!;
    } catch (e) {
      print("Error: $e");
      return '';
    }
  }

  bool _isLoading = true;
  String _pdfPath = '';
  late Future<Student> student;
  Future<String?> _downloadPDF() async {
    final response = await Supabase.instance.client
        .from('students')
        .select('resume_url')
        .eq('student_id', widget.studentId)
        .single();

    if (response != null) {
      final String url = response['resume_url'] as String;
      print('url:$url');
      final fileResponse = await http.get(Uri.parse(url));
      if (fileResponse.statusCode == 200) {
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/temp.pdf');
        await file.writeAsBytes(fileResponse.bodyBytes);
        setState(() {
          print('File path: ${file.path}');
          _pdfPath = file.path;
          _isLoading = false;
        });
      }
      return _pdfPath;
    } else {
      print('Error fetching resume URL: ${response}');
      return null;
    }
  }

  initState() {
    super.initState();
    _refresh();
    _downloadPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: basic_text(
            title: 'My Resume',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        actions: [],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder(
          future: student,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No data found'));
            } else {
              return Center(
                child: Stack(
                  children: [
                    localFilePath != null
                        ? Container(
                            child: PDFView(
                            filePath: localFilePath!,
                          ))
                        : Center(
                            child: Text(
                              'No resume uploaded yet.',
                              style: TextStyle(color: AppColors.primarycolor2),
                            ),
                          ),
                    SizedBox(height: 20),
                  ],
                ),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Button(
            onPressed: () {
              _uploadResume();
            },
            color: AppColors.black,
            text: 'Update Resume',
            minimumSize: Size(MediaQuery.of(context).size.width * 0.4,
                MediaQuery.of(context).size.height * 0.06)),
      ),
    );
  }

  // Future<String?> _downloadFile(String fileUrl) async {
  //   try {
  //     final fileExists = await Supabase.instance.client.storage
  //         .from('Resume')
  //         .getPublicUrl(fileUrl);

  //     if (fileExists.isEmpty) {
  //       print('File not found at $fileUrl');
  //       return null;
  //     }

  //     final response = await Supabase.instance.client.storage
  //         .from('Resume')
  //         .download(fileUrl);

  //     final tempDir =
  //         await getTemporaryDirectory(); // Get the temporary directory
  //     final file = File('${tempDir.path}/resume.pdf');
  //     await file.writeAsBytes(response);
  //     return file.path;
  //   } catch (e) {
  //     print('Error downloading file: $e');
  //     return null;
  //   }
  // }
}

// Function to pick and upload file for the student
Future<String?> pickAndUploadFileForStudent(String studentId) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'doc', 'docx'],
  );

  if (result != null) {
    File filePath = File(result.files.single.path!);
    String fileName = result.files.single.name;

    // Construct a unique file name using the student ID
    String uniqueFileName = '$studentId/$fileName';

    final storageResponse = await Supabase.instance.client.storage
        .from('Resume')
        .upload(uniqueFileName, filePath);

    if (storageResponse.isNotEmpty) {
      final fileUrl = Supabase.instance.client.storage
          .from('Resume')
          .getPublicUrl(uniqueFileName);
      print('File uploaded successfully: $fileUrl');
      return fileUrl;
    } else {
      print('Error uploading file: ${storageResponse}');
      return null;
    }
  } else {
    print('File picking canceled or failed.');
    return null;
  }
}

// Function to save the file URL in the database
Future<void> saveFileUrlToDatabase(String studentId, String fileUrl) async {
  final response = await Supabase.instance.client
      .from('students')
      .update({'resume_url': fileUrl}).eq('student_id', studentId);

  if (response != null) {
    print('Error saving file URL: ${response.error!.message}');
  } else if (response != null) {
    print('File URL saved successfully for student $studentId');
  } else {
    print('Unknown error occurred while saving file URL.');
  }
}
