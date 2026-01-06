class GovernmentEntity {
  final int id;
  final String name;
  final String description;
  final String location;
  final String contactEmail;
  final String contactPhone;

  GovernmentEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.contactEmail,
    required this.contactPhone,
  });

  factory GovernmentEntity.fromJson(Map<String, dynamic> json) {
    return GovernmentEntity(
      id: json['entity_id'],
      name: json['name'],
      description: json['description'],
      location: json['location'],
      contactEmail: json['contact_email'],
      contactPhone: json['contact_phone'],
    );
  }
}
