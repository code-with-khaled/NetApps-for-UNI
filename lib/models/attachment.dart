import 'package:network_apps/utils/helpers.dart';

class Attachment {
  final int id;
  final String? fileName;
  final String type;
  final String url;

  Attachment({
    required this.id,
    this.fileName,
    required this.type,
    required this.url,
  });

  // bool get isImage => ["jpg", "jpeg", "png"].contains(type.toLowerCase());

  bool get isImage => type == "document" ? false : true;

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'],
      type: json['type'],
      url: json['file_path'],
      fileName: Helpers.extractFileName(json['file_path']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'fileName': fileName, 'type': type, 'url': url};
  }
}
