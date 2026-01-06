import 'package:network_apps/models/complaint.dart';

class PaginatedComplaints {
  final List<Complaint> complaints;
  final int currentPage;
  final int lastPage;
  final String? nextPageUrl;

  PaginatedComplaints({
    required this.complaints,
    required this.currentPage,
    required this.lastPage,
    this.nextPageUrl,
  });

  factory PaginatedComplaints.fromJson(Map<String, dynamic> json) {
    var complaintsJson = json['data'] as List<dynamic>;
    List<Complaint> complaintsList = complaintsJson
        .map((c) => Complaint.fromJson(c))
        .toList();

    return PaginatedComplaints(
      complaints: complaintsList,
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      nextPageUrl: json['next_page_url'],
    );
  }
}
