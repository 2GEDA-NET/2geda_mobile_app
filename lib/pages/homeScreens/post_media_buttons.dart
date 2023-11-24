import 'dart:io';
import 'dart:typed_data';

import 'package:_2geda/pages/homeScreens/create_post.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:flutter/material.dart';

// globals.dart
List<Uint8List> globalVoiceNotes = [];

class ContainerGrid extends StatefulWidget {
  const ContainerGrid({Key? key}) : super(key: key);

  @override
  State<ContainerGrid> createState() => _ContainerGridState();
}

class _ContainerGridState extends State<ContainerGrid> {
  late RecorderController recorderController;
  late AudioPlayer audioPlayer;
  bool isRecording = false; // Define isRecording
  bool isWaveformVisible = false; // Track visibility of the AudioWaveforms
  late PlayerController playerController; // Add this line

  @override
  void initState() {
    super.initState();
    recorderController = RecorderController();
    audioPlayer = AudioPlayer();
    playerController = PlayerController(); // Initialize PlayerController
  }

  @override
  void dispose() {
    recorderController.dispose();
    super.dispose();
  }

  Future<void> startRecording(RecorderController controller) async {
    try {
      if (await controller.checkPermission()) {
        await controller.record();
        setState(() {
          isRecording = true;
          isWaveformVisible = true;
        });
      }
    } catch (e) {
      print('Error Start Recording: $e');
    }
  }

  Future<void> stopRecording(BuildContext context) async {
    try {
      final controller = recorderController;
      String? filePath = await controller.stop();
      setState(() {
        isRecording = false;
      });

      if (filePath != null) {
        // Read the file contents as bytes (Uint8List)
        File file = File(filePath);
        Uint8List bytes = await file.readAsBytes();

        // Access the MediaUploadModel using Provider
        MediaUploadModel model =
            Provider.of<MediaUploadModel>(context, listen: false);

        // Add the voice note to the model
        model.addVoiceNote(bytes);
      } else {
        print('Error: Stopped recording, but file path is null');
      }
    } catch (e) {
      print('Error Stopping Recording: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isRecording) // Show AudioWaveforms based on visibility flag
          AudioWaveforms(
            enableGesture: true,
            size: Size(MediaQuery.of(context).size.width / 2, 50),
            recorderController: recorderController,
            waveStyle: const WaveStyle(
              waveColor: Colors.white,
              extendWaveform: true,
              showMiddleLine: false,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: const Color(0xFF1E1B26),
            ),
            padding: const EdgeInsets.only(left: 18),
            margin: const EdgeInsets.symmetric(horizontal: 15),
          ),
        ChangeNotifierProvider(
          create: (context) => MediaUploadModel(),
          child: Consumer<MediaUploadModel>(
            builder: (context, model, _) {
              final List<Widget> containers = [
                // Inside ContainerGrid widget
                ContainerItem(
                  text: 'Photos',
                  iconData: Icons.image,
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    XFile? image = await _picker.pickImage(
                      source: ImageSource.gallery,
                    );

                    if (image != null) {
                      Provider.of<MediaUploadModel>(context, listen: false)
                          .addImage(image);

                      // Print the model here to check if the image is added
                      MediaUploadModel model =
                          Provider.of<MediaUploadModel>(context, listen: false);
                      print('Media Upload Model after adding image: $model');
                    }
                  },
                ),

                ContainerItem(
                  text: 'Videos',
                  iconData: Icons.business,
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    XFile? video = await _picker.pickVideo(
                      source: ImageSource.gallery,
                    );

                    if (video != null) {
                      Provider.of<MediaUploadModel>(context, listen: false)
                          .addVideo(video);
                    }
                  },
                ),
                ContainerItem(
                  text: 'Jobs',
                  iconData: Icons.shopping_bag_outlined,
                  iconColor: Colors.black,
                  onPressed: () {
                    // Add functionality for Photos
                    print('Photos clicked');
                  },
                ),
                ContainerItem(
                  text: 'Music',
                  iconData: Icons.music_note,
                  iconColor: Colors.red,
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: [
                        'mp3',
                        'wav'
                      ], // Add more audio extensions if needed
                    );

                    if (result != null && result.files.isNotEmpty) {
                      Provider.of<MediaUploadModel>(context, listen: false)
                          .addAudio(XFile(result.files.single.path!));
                    }
                  },
                ),
                ContainerItem(
                  text: 'Voice Note',
                  iconData: Icons.mic_none_outlined,
                  iconColor: Colors.black,
                  onPressed: () {
                    if (isRecording) {
                      stopRecording(context);
                    } else {
                      startRecording(recorderController);
                    }
                    // Provider.of<MediaUploadModel>(context, listen: false)
                    //     .addVoiceNote(recorderController);
                  },
                ),

                ContainerItem(
                  text: 'Word Doc',
                  iconData: Icons.insert_drive_file,
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: [
                        'docx'
                      ], // Add more extensions if needed
                    );

                    if (result != null && result.files.isNotEmpty) {
                      File wordDoc = File(result.files.single.path!);
                      // Now you can use the wordDoc file for further processing or uploading.
                      // For example, you can add it to your MediaUploadModel.

                      Provider.of<MediaUploadModel>(context, listen: false)
                          .addWordDoc(wordDoc);
                    }
                  },
                ),

                ContainerItem(
                  text: 'Excel doc',
                  iconData: Icons.insert_drive_file,
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: [
                        'xlxs',
                        'csv'
                      ], // Add more extensions if needed
                    );

                    if (result != null && result.files.isNotEmpty) {
                      File excelDoc = File(result.files.single.path!);
                      // Now you can use the wordDoc file for further processing or uploading.
                      // For example, you can add it to your MediaUploadModel.

                      Provider.of<MediaUploadModel>(context, listen: false)
                          .addExcelDoc(excelDoc);
                    }
                  },
                ),
                ContainerItem(
                  text: 'Others',
                  iconData: Icons.insert_drive_file,
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: [
                        'pdf', 'doc', 'docx', 'txt', 'xlsx', 'csv', 'ppt',
                        'pptx',
                        'apk', 'exe', 'msi', 'bat', 'com', 'cmd', 'jar', 'sh',
                        // Add more extensions as needed
                      ],
                    );

                    if (result != null && result.files.isNotEmpty) {
                      File otherFiles = File(result.files.single.path!);
                      // Now you can use the documentFile for further processing or uploading.
                      // For example, you can add it to your MediaUploadModel.

                      Provider.of<MediaUploadModel>(context, listen: false)
                          .addOtherFile(otherFiles);
                    }
                  },
                ),

                // ... (other ContainerItems with their onPressed functions)
              ];

              List<List<Widget>?> rows = [];
              for (var i = 0; i < containers.length; i += 4) {
                rows.add(containers.sublist(i, i + 4));
              }

              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  if (model.images != null || model.videos != null)
                    Wrap(
                      children: [
                        if (model.images != null)
                          for (var i = 0; i < model.images!.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      File(model.images![i].path),
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        Provider.of<MediaUploadModel>(context,
                                                listen: false)
                                            .removeMedia(imageIndex: i);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        if (model.videos != null)
                          for (var i = 0; i < model.videos!.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  VideoPlayerWidget(
                                    videoFile: File(model.videos![i].path),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        Provider.of<MediaUploadModel>(context,
                                                listen: false)
                                            .removeMedia(videoIndex: i);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        if (model.audios != null)
                          for (var i = 0; i < model.audios!.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  // You can customize the audio icon or display more audio details
                                  const Icon(Icons.music_note,
                                      size: 50, color: Colors.red),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        Provider.of<MediaUploadModel>(context,
                                                listen: false)
                                            .removeMedia(audioIndex: i);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        if (model.voiceNotes != null)
                          for (var i = 0; i < model.voiceNotes!.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  // You can customize the voice note icon or display more details
                                  const Icon(Icons.mic_none_outlined,
                                      size: 50, color: Colors.black),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        Provider.of<MediaUploadModel>(context,
                                                listen: false)
                                            .removeMedia(voiceNoteIndex: i);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        if (model.wordDocs != null)
                          for (var i = 0; i < model.wordDocs!.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  // You can customize the voice note icon or display more details
                                  const Icon(Icons.document_scanner,
                                      size: 50, color: Colors.black),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        Provider.of<MediaUploadModel>(context,
                                                listen: false)
                                            .removeMedia(wordDocsIndex: i);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        if (model.excelDocs != null)
                          for (var i = 0; i < model.excelDocs!.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  // You can customize the voice note icon or display more details
                                  const Icon(Icons.document_scanner,
                                      size: 50, color: Colors.black),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        Provider.of<MediaUploadModel>(context,
                                                listen: false)
                                            .removeMedia(excelDocsIndex: i);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ],
                    ),
                  for (var row in rows)
                    Row(
                      children: [
                        for (var container in row!)
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(5.0),
                              child: container,
                            ),
                          ),
                      ],
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
