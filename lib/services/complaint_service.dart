// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:network_apps/models/attachment.dart';
import 'package:network_apps/models/complaint.dart';
import 'package:network_apps/models/government_entity.dart';
import 'package:network_apps/models/paginated_complaints.dart';
import 'package:network_apps/utils/constants.dart';
import 'package:network_apps/utils/helpers.dart';

class ComplaintService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Constants.baseUrl));

  Future<List<GovernmentEntity>> fetchGovernmentEntities() async {
    final token = await Helpers.getAuthToken();
    if (token == null) throw Exception('No auth token found');

    final response = await _dio.get(
      '/government_entities',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      final data = response.data['governments'] as List<dynamic>;
      return data.map((json) => GovernmentEntity.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load government entities');
    }
  }

  // Future<List<Complaint>> fetchComplaints() async {
  //   final token = await Helpers.getAuthToken();
  //   if (token == null) throw Exception('No auth token found');

  //   final response = await _dio.get(
  //     '/myComplaints',
  //     options: Options(headers: {'Authorization': 'Bearer $token'}),
  //   );

  //   if (response.statusCode == 200) {
  //     List<dynamic> data = response.data;
  //     return data.map((json) => Complaint.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load complaints');
  //   }
  // }

  Future<PaginatedComplaints> fetchComplaints({int page = 1}) async {
    final token = await Helpers.getAuthToken();
    if (token == null) throw Exception('No auth token found');

    final response = await _dio.get(
      '/myComplaints',
      queryParameters: {'page': page},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      return PaginatedComplaints.fromJson(response.data);
    } else {
      throw Exception('Failed to load complaints');
    }
  }

  Future<Complaint> fetchComplaintDetails(int complaintId) async {
    final token = await Helpers.getAuthToken();
    if (token == null) throw Exception('No auth token found');

    final response = await _dio.get(
      '/show/$complaintId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      return Complaint.fromJson(response.data);
    } else {
      throw Exception('Failed to load complaint details');
    }
  }

  Future<List<Attachment>> fetchComplaintAttachments(int complaintId) async {
    final token = await Helpers.getAuthToken();
    if (token == null) throw Exception('No auth token found');

    final response = await _dio.get(
      '/myComplaintsAtt/$complaintId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      final data = response.data['attachments'] as List<dynamic>;
      return data.map((json) => Attachment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load attachments for complaint $complaintId');
    }
  }

  Future<void> submitComplaint(
    Complaint complaint,
    List<PlatformFile> files,
    List<XFile> images,
  ) async {
    final token = await Helpers.getAuthToken();
    if (token == null) throw Exception('No auth token found');

    final formData = FormData();

    formData.fields.addAll([
      MapEntry('type', complaint.type),
      MapEntry('government_entity_id', complaint.entity.id.toString()),
      MapEntry('location', complaint.location),
      MapEntry('description', complaint.description),
    ]);

    for (var file in files) {
      formData.files.add(
        MapEntry(
          'attachments[]',
          await MultipartFile.fromFile(file.path!, filename: file.name),
        ),
      );
    }

    for (var image in images) {
      formData.files.add(
        MapEntry(
          'attachments[]',
          await MultipartFile.fromFile(image.path, filename: image.name),
        ),
      );
    }

    final response = await _dio.post(
      '/submitComplaint',
      data: formData,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
        contentType: 'multipart/form-data',
        followRedirects: false,
      ),
    );

    print(response.statusCode);
    print(response.headers);
    print(response.realUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to submit complaint');
    }
  }

  Future<void> addAttachments(
    int complaintId,
    List<PlatformFile> files,
    List<XFile> images,
  ) async {
    final token = await Helpers.getAuthToken();
    if (token == null) throw Exception('No auth token found');

    final formData = FormData();

    for (var file in files) {
      formData.files.add(
        MapEntry(
          'attachments[]',
          await MultipartFile.fromFile(file.path!, filename: file.name),
        ),
      );
    }

    for (var image in images) {
      formData.files.add(
        MapEntry(
          'attachments[]',
          await MultipartFile.fromFile(image.path, filename: image.name),
        ),
      );
    }

    final response = await _dio.post(
      '/addAttachment/$complaintId',
      data: formData,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
        contentType: 'multipart/form-data',
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit complaint');
    }
  }
}
