import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:network_apps/services/complaint_service.dart';

class AddAttachmentsViewmodel extends ChangeNotifier {
  final ComplaintService _complaintService = ComplaintService();

  bool isLoading = false;
  String? errorMessage;
  bool success = false;

  Future<void> addAttachments(
    int complaintId,
    List<PlatformFile> files,
    List<XFile> images,
  ) async {
    isLoading = true;
    errorMessage = null;
    success = false;
    notifyListeners();

    try {
      await _complaintService.addAttachments(complaintId, files, images);
      success = true;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
