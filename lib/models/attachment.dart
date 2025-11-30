class Attachment {
  final String id;
  final String fileName;
  final String type;
  final String url;

  Attachment({
    required this.id,
    required this.fileName,
    required this.type,
    required this.url,
  });

  bool get isImage => ["jpg", "jpeg", "png"].contains(type.toLowerCase());

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'],
      fileName: json['fileName'],
      type: json['fileType'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'fileName': fileName, 'fileType': type, 'url': url};
  }
}
