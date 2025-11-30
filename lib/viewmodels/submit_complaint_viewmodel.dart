import 'package:flutter/material.dart';
import 'package:network_apps/models/complaint.dart';
import 'package:network_apps/services/complaint_service.dart';

class SubmitComplaintViewModel extends ChangeNotifier {
  final ComplaintService _complaintService = ComplaintService();

  bool isSubmitting = false;
  String? errorMessage;
  bool success = false;

  Future<void> submitComplaint(Complaint complaint) async {
    isSubmitting = true;
    errorMessage = null;
    success = false;
    notifyListeners();

    try {
      await _complaintService.submitComplaint(complaint);
      success = true;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }
}
