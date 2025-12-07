// ignore_for_file: unused_import

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:network_apps/models/complaint.dart';
import 'package:network_apps/utils/helpers.dart';
import 'package:network_apps/viewmodels/complaint_detail_viewmodel.dart';
import 'package:provider/provider.dart';

class ComplaintDetailsScreen extends StatefulWidget {
  final int complaintId;
  final Complaint? initialComplaint;

  const ComplaintDetailsScreen({
    super.key,
    required this.complaintId,
    this.initialComplaint,
  });

  @override
  State<ComplaintDetailsScreen> createState() => _ComplaintDetailsScreenState();
}

class _ComplaintDetailsScreenState extends State<ComplaintDetailsScreen> {
  final List<PlatformFile> _files = [];
  final List<XFile> _images = [];

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        _files.addAll(result.files);
      });
    }
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final result = await picker.pickMultiImage();
    if (result.isNotEmpty) {
      setState(() {
        _images.addAll(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(
    //   create: (_) =>
    //       ComplaintDetailViewModel()..fetchComplaintDetail(complaintId),
    //   child: Consumer<ComplaintDetailViewModel>(
    //     builder: (context, vm, child) {
    //       if (vm.isLoading && vm.complaint == null) {
    //         return const Scaffold(
    //           body: Center(child: CircularProgressIndicator()),
    //         );
    //       }

    //       if (vm.errorMessage != null) {
    //         return Scaffold(
    //           appBar: AppBar(title: const Text("Complaint Details")),
    //           body: Center(child: Text("Error: ${vm.errorMessage}")),
    //         );
    //       }

    //       if (vm.complaint == null) {
    //         return const Scaffold(
    //           body: Center(child: Text("Complaint not found")),
    //         );
    //       }

    //       final complaint = vm.complaint!;

    //       return Scaffold(
    //         backgroundColor: Colors.grey.shade200,
    //         appBar: AppBar(
    //           backgroundColor: Colors.deepPurple.shade400,
    //           title: Column(
    //             children: [
    //               Text(
    //                 "Complaint Details",
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //               Text(
    //                 complaint.referenceNumber,
    //                 style: TextStyle(color: Colors.white, fontSize: 12),
    //               ),
    //             ],
    //           ),
    //         ),
    //         body: Column(
    //           children: [
    //             Container(
    //               padding: EdgeInsets.all(12),
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 border: Border(bottom: BorderSide()),
    //               ),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Container(
    //                         padding: EdgeInsets.symmetric(
    //                           horizontal: 8,
    //                           vertical: 4,
    //                         ),
    //                         decoration: BoxDecoration(
    //                           color: _getStatusBgColor(complaint.status),
    //                           borderRadius: BorderRadius.circular(16),
    //                         ),
    //                         child: Text(
    //                           complaint.status,
    //                           style: TextStyle(
    //                             color: _getStatusColor(complaint.status),
    //                             fontWeight: FontWeight.w600,
    //                           ),
    //                         ),
    //                       ),
    //                       Text(
    //                         "Submitted on ${Helpers.formatDate(complaint.createdAt)}",
    //                         style: TextStyle(fontWeight: FontWeight.bold),
    //                       ),
    //                     ],
    //                   ),
    //                   // Row(
    //                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   //   children: [],
    //                   // ),
    //                 ],
    //               ),
    //             ),
    //             Expanded(
    //               child: SingleChildScrollView(
    //                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       "Complaint Information",
    //                       style: TextStyle(
    //                         color: Colors.grey.shade700,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                     Divider(),

    //                     Text("TYPE", style: TextStyle(fontSize: 16)),
    //                     Text(
    //                       complaint.type,
    //                       style: TextStyle(fontWeight: FontWeight.bold),
    //                     ),
    //                     SizedBox(height: 8),

    //                     Text(
    //                       "GOVERNMENT ENTITY",
    //                       style: TextStyle(color: Colors.grey.shade700),
    //                     ),
    //                     Text(
    //                       complaint.entity,
    //                       style: TextStyle(fontWeight: FontWeight.bold),
    //                     ),

    //                     Text(
    //                       "LOCATION",
    //                       style: TextStyle(color: Colors.grey.shade700),
    //                     ),
    //                     Text(
    //                       complaint.location,
    //                       style: TextStyle(fontWeight: FontWeight.bold),
    //                     ),

    //                     Text(
    //                       "DESCRIPTION",
    //                       style: TextStyle(color: Colors.grey.shade700),
    //                     ),
    //                     Text(
    //                       complaint.description,
    //                       style: TextStyle(fontSize: 12),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // );

    final complaint = widget.initialComplaint!;

    // ignore: unused_local_variable
    final photos = complaint.attachments
        .where((attachment) => attachment.isImage)
        .toList();

    final files = complaint.attachments
        .where((attachment) => !attachment.isImage)
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple.shade400,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Complaint Details",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4),

            Text(complaint.referenceNumber!, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.black12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Helpers.getStatusBgColor(complaint.status!),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    complaint.status!,
                    style: TextStyle(
                      color: Helpers.getStatusColor(complaint.status!),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  "Submitted on ${Helpers.formatDate(complaint.createdAt!)}",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Complaint Information",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),

                        Text(
                          "TYPE",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        Text(
                          complaint.type,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8),

                        Text(
                          "GOVERNMENT ENTITY",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        Text(
                          complaint.entity,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8),

                        Text(
                          "LOCATION",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        Text(
                          complaint.location,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8),

                        Text(
                          "DESCRIPTION",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        Text(
                          complaint.description,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),

                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Evidence Photos",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),

                        complaint.attachments.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Center(
                                  child: Text(
                                    "No attached photos.",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              )
                            : GridView.builder(
                                shrinkWrap:
                                    true, // important inside SingleChildScrollView
                                physics:
                                    const NeverScrollableScrollPhysics(), // let outer scroll handle it
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // 3 columns
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                    ),
                                // itemCount: photos.length,
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  // final attachment = complaint.attachments[index];
                                  return GestureDetector(
                                    onTap: () {
                                      // TODO: open full screen preview
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNubLmqdOK9pZWU-2IiD20cuSIdUUDi9-NvQ&s",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),

                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Attached Files",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),

                        files.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Center(
                                  child: Text(
                                    "No attached files.",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: files.length,
                                separatorBuilder: (_, _) =>
                                    const Divider(height: 1),
                                itemBuilder: (context, index) {
                                  final file = files[index];

                                  return ListTile(
                                    leading: Icon(
                                      Helpers.getFileIcon(file.type),
                                      color: Helpers.getFileIconColor(
                                        file.type,
                                      ),
                                    ),
                                    title: Text(file.fileName),
                                    subtitle: Text(file.type.toUpperCase()),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.download,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        // TODO: handle file download or open
                                      },
                                    ),
                                    onTap: () {
                                      // TODO: open file preview if supported
                                    },
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),

                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Comments",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Center(
                            child: Text(
                              "No comments available.",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 20),
                  SizedBox(height: 8),

                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add Additional Attachments",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _pickFiles,
                                icon: const Icon(Icons.attach_file),
                                label: const Text("Add Files"),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _pickImages,
                                icon: const Icon(Icons.image),
                                label: const Text("Add Photos"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Preview files
                        if (_files.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _files
                                .map(
                                  (f) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Helpers.getFileIcon(f.extension),
                                          color: Helpers.getFileIconColor(
                                            f.extension,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(child: Text(f.name)),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _files.remove(f);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        SizedBox(height: 8),

                        // Preview images
                        if (_images.isNotEmpty)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _images.map((img) {
                              return Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      File(img.path),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    right: 4,
                                    top: 4,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _images.remove(img);
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        SizedBox(height: 8),

                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // TODO: handle attachments addition
                                },
                                child: Text("Submit Attachments"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
