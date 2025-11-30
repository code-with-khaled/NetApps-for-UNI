// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:network_apps/models/complaint.dart';
import 'package:network_apps/utils/helpers.dart';
import 'package:network_apps/viewmodels/complaint_detail_viewmodel.dart';
import 'package:provider/provider.dart';

class ComplaintDetailsScreen extends StatelessWidget {
  final int complaintId;
  final Complaint? initialComplaint;

  const ComplaintDetailsScreen({
    super.key,
    required this.complaintId,
    this.initialComplaint,
  });

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

    final complaint = initialComplaint!;

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

            Text(complaint.referenceNumber, style: TextStyle(fontSize: 12)),
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
                    color: _getStatusBgColor(complaint.status),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    complaint.status,
                    style: TextStyle(
                      color: _getStatusColor(complaint.status),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  "Submitted on ${Helpers.formatDate(complaint.createdAt)}",
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
                                      color: _getFileIconColor(file.type),
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
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return Colors.blue;
      case 'in progress':
        return Colors.orange;
      case 'resolved':
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  Color _getStatusBgColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return Colors.blue.shade100;
      case 'in progress':
        return Colors.orange.shade100;
      case 'resolved':
        return Colors.green.shade100;
      default:
        return Colors.red.shade100;
    }
  }

  Color _getFileIconColor(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return Colors.red;
      case 'doc':
      case 'docx':
        return Colors.blue;
      case 'xls':
      case 'xlsx':
        return Colors.green;
      case 'png':
      case 'jpg':
      case 'jpeg':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
