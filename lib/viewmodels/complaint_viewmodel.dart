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

  int _currentPage = 1;
  int _lastPage = 1;

  bool get hasMoreComplaints => _currentPage <= _lastPage;

  Future<void> fetchComplaints({bool refresh = false}) async {
    if (isLoading) return;
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    if (refresh) {
      _currentPage = 1;
      complaints.clear();
    }

    try {
      final paginatedComplaints = await _complaintService.fetchComplaints(
        page: _currentPage,
      );

      complaints.addAll(paginatedComplaints.complaints);
      _currentPage = paginatedComplaints.currentPage + 1;
      _lastPage = paginatedComplaints.lastPage;
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
