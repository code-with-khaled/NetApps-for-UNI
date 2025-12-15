import 'package:network_apps/models/attachment.dart';

class Complaint {
  final int? id;
  final String? referenceNumber;
  final String type;
  final int entity;
  final String location;
  final String description;
  final DateTime? createdAt;
  final String? status;
  final List<Attachment> attachments;

  Complaint({
    this.id,
    this.referenceNumber,
    required this.type,
    required this.location,
    required this.entity,
    required this.description,
    this.createdAt,
    this.status,
    this.attachments = const [],
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['complaint_id'],
      referenceNumber: json['reference_number'],
      type: json['type'],
      location: json['location'],
      entity: json['government_entity_id'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'entity': entity,
      'location': location,
      'description': description,
      'attachments': attachments
          .map((attachment) => attachment.toJson())
          .toList(),
    };
  }
}
