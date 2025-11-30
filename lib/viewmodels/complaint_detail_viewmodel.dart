import 'package:flutter/material.dart';
import 'package:network_apps/models/attachment.dart';
import 'package:network_apps/models/complaint.dart';
import 'package:network_apps/services/complaint_service.dart';

class ComplaintDetailViewModel extends ChangeNotifier {
  final ComplaintService _complaintService = ComplaintService();

  Complaint? complaint;
  List<Attachment> attachments = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchComplaintDetail(int complaintId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      complaint = await _complaintService.fetchComplaintDetails(complaintId);
      attachments = await _complaintService.fetchComplaintAttachments(
        complaintId,
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
