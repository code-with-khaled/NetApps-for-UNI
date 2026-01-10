class GovernmentEntity {
  final int id;
  final String name;
  String? description;
  String? location;
  String? contactEmail;
  String? contactPhone;

  GovernmentEntity({
    required this.id,
    required this.name,
    this.description,
    this.location,
    this.contactEmail,
    this.contactPhone,
  });

  factory GovernmentEntity.fromJson(Map<String, dynamic> json) {
    return GovernmentEntity(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      contactEmail: json['contact_email'] ?? '',
      contactPhone: json['contact_phone'] ?? '',
    );
  }
}
