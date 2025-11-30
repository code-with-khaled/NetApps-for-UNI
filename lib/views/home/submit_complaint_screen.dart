import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:network_apps/widgets/custom_textfield.dart';
import 'package:logger/logger.dart';

class SubmitComplaintScreen extends StatefulWidget {
  const SubmitComplaintScreen({super.key});

  @override
  State<SubmitComplaintScreen> createState() => _SubmitComplaintScreenState();
}

class _SubmitComplaintScreenState extends State<SubmitComplaintScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _type = "";
  String? _selectedEntity;
  String _location = "";
  String _description = "";

  final List<PlatformFile> _files = [];
  final List<XFile> _images = [];

  final List<String> _ministries = [
    "Ministry of Health",
    "Ministry of Education",
    "Ministry of Finance",
    "Ministry of Interior",
  ];

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        _files.addAll(result.files);
      });
    }
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final result = await picker.pickMultiImage();
    if (result.isNotEmpty) {
      setState(() {
        _images.addAll(result);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var logger = Logger();

      logger.i("Type: $_type");
      logger.i("Entity: $_selectedEntity");
      logger.i("Location: $_location");
      logger.i("Description: $_description");
      logger.i("Files: ${_files.map((f) => f.name).toList()}");
      logger.i("Images: ${_images.map((i) => i.path).toList()}");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Complaint submitted!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            // Type
            Text(
              "Complaint type *",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 5),
            CustomTextField(
              hintText: "Enter Complaint Type",
              controller: _typeController,
              validator: (val) =>
                  val == null || val.isEmpty ? "Required" : null,
              onSaved: (val) => _type = val!,
            ),
            const SizedBox(height: 12),

            // Government Entity Dropdown
            Text(
              "Government Entity *",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 5),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Choose the Concerned Authority",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26),
                  borderRadius: BorderRadius.circular(6),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              items: _ministries.map((m) {
                return DropdownMenuItem(value: m, child: Text(m));
              }).toList(),
              onChanged: (val) => setState(() => _selectedEntity = val),
              validator: (val) => val == null ? "Required" : null,
            ),
            const SizedBox(height: 12),

            // Location
            Text(
              "Location *",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 5),
            CustomTextField(
              hintText: "Enter Location",
              prefixIcon: Icon(Icons.location_on),
              controller: _locationController,
              validator: (val) =>
                  val == null || val.isEmpty ? "Required" : null,
              onSaved: (val) => _location = val!,
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              "Desciption *",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 5),
            CustomTextField(
              hintText: "Describe your complaint in detail...",
              maxLines: 5,
              controller: _descriptionController,
              validator: (val) =>
                  val == null || val.isEmpty ? "Required" : null,
              onSaved: (val) => _description = val!,
            ),
            const SizedBox(height: 20),

            // Attachments Section
            Text(
              "Upload Attachments",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,

                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _pickFiles,
                    icon: const Icon(Icons.attach_file),
                    label: const Text("Add Files"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _pickImages,
                    icon: const Icon(Icons.image),
                    label: const Text("Add Photos"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Preview files
            if (_files.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _files.map((f) => Text("📄 ${f.name}")).toList(),
              ),

            // Preview images
            if (_images.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _images.map((img) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(img.path),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
              ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _submitForm,
              child: const Text("Submit Complaint"),
            ),
          ],
        ),
      ),
    );
  }
}
