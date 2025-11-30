import 'package:dio/dio.dart';
import 'package:network_apps/models/attachment.dart';
import 'package:network_apps/models/complaint.dart';
import 'package:network_apps/utils/constants.dart';

class ComplaintService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseUrl));

  Future<List<Complaint>> fetchComplaints() async {
    final response = await _dio.get('/complaints');

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return data.map((json) => Complaint.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load complaints');
    }
  }

  Future<Complaint> fetchComplaintDetails(int id) async {
    final response = await _dio.get('/complaints/$id');

    if (response.statusCode == 200) {
      return Complaint.fromJson(response.data);
    } else {
      throw Exception('Failed to load complaint details');
    }
  }

  Future<List<Attachment>> fetchComplaintAttachments(int complaintId) async {
    final response = await _dio.get('/complaints/$complaintId/attachments');

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return data.map((json) => Attachment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load attachments for complaint $complaintId');
    }
  }

  Future<void> submitComplaint(Complaint complaint) async {
    final response = await _dio.post('/complaints', data: complaint.toJson());

    if (response.statusCode != 201) {
      throw Exception('Failed to submit complaint');
    }
  }
}
