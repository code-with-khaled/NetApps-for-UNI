import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:network_apps/models/complaint.dart';
import 'package:network_apps/services/complaint_service.dart';

class ComplaintViewModel extends ChangeNotifier {
  final ComplaintService _complaintService = ComplaintService();

  List<Complaint> complaints = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchComplaints() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      complaints = await _complaintService.fetchComplaints();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> submitComplaint(
    Complaint complaint,
    List<PlatformFile> files,
    List<XFile> images,
  ) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await _complaintService.submitComplaint(complaint, files, images);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
