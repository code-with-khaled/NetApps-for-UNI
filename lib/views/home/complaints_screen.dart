// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:network_apps/models/attachment.dart';
import 'package:network_apps/models/complaint.dart';
import 'package:network_apps/viewmodels/complaint_viewmodel.dart';
import 'package:network_apps/widgets/complaint_card.dart';
import 'package:provider/provider.dart';

class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ComplaintViewModel()..fetchComplaints(),
      child: Consumer<ComplaintViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (vm.errorMessage != null) {
            return Center(child: Text("Error: ${vm.errorMessage}"));
          }
          if (vm.complaints.isEmpty) {
            return const Center(child: Text("No complaints found"));
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            itemCount: vm.complaints.length,
            itemBuilder: (context, index) {
              final complaint = vm.complaints[index];
              return ComplaintCard(complaint: complaint);
            },
          );
        },
      ),
    );
  }
}
