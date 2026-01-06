import 'package:flutter/material.dart';
import 'package:network_apps/models/government_entity.dart';
import 'package:network_apps/services/complaint_service.dart';

class GovernmentEntitiesViewModel extends ChangeNotifier {
  final ComplaintService _service = ComplaintService();

  List<GovernmentEntity> entities = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchEntities() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      entities = await _service.fetchGovernmentEntities();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
