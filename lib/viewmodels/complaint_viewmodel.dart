import 'package:flutter/material.dart';
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
}
