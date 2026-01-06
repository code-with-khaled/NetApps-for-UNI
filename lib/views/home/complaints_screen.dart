// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:network_apps/models/attachment.dart';
import 'package:network_apps/models/complaint.dart';
import 'package:network_apps/viewmodels/complaint_viewmodel.dart';
import 'package:network_apps/widgets/complaint_card.dart';
import 'package:provider/provider.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final vm = context.read<ComplaintViewModel>();
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !vm.isLoading &&
        vm.hasMoreComplaints) {
      Logger logger = Logger();
      logger.i("Fetching more complaints...");
      vm.fetchComplaints();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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

          return RefreshIndicator(
            onRefresh: () async {
              await vm.fetchComplaints(refresh: true);
            },

            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 8, bottom: 80),
              itemCount: vm.complaints.length + (vm.hasMoreComplaints ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < vm.complaints.length) {
                  final complaint = vm.complaints[index];
                  return ComplaintCard(complaint: complaint);
                } else {
                  // ✅ Only show loader if there are more complaints to fetch
                  if (vm.hasMoreComplaints) {
                    Logger logger = Logger();
                    logger.i("Loading more complaints...");
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    // ✅ If no more pages, return an empty widget
                    Logger logger = Logger();
                    logger.i("No more complaints to load.");
                    return const SizedBox.shrink();
                  }
                }
              },
            ),
          );
        },
      ),
    );
  }
}
