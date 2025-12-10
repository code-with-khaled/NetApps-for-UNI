import 'package:flutter/material.dart';
import 'package:network_apps/viewmodels/auth_viewmodel.dart';

import 'package:network_apps/views/home/complaints_screen.dart';
import 'package:network_apps/views/home/notifications_screen.dart';
import 'package:network_apps/views/home/submit_complaint_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<String> _titles = [
    "Complaints",
    "Submit Complaint",
    "Notifications",
  ];

  // Screens for each tab
  final List<Widget> _screens = [
    const ComplaintsScreen(),
    const SubmitComplaintScreen(),
    const NotificationsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void returnToAuth() {
    Navigator.of(context).pushNamedAndRemoveUntil('/auth', (route) => false);
  }

  void showError(String? errorMessage) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Error: $errorMessage")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade400,
        title: Text(
          _titles[_selectedIndex],
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Consumer<AuthViewModel>(
            builder: (context, authVM, _) {
              return IconButton(
                icon: authVM.isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.logout, color: Colors.white),
                onPressed: authVM.isLoading
                    ? null
                    : () async {
                        final success = await authVM.logout();
                        if (!success) {
                          showError(authVM.errorMessage);
                        }
                        if (success && mounted) {
                          returnToAuth();
                        }
                      },
              );
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex], // show selected tab
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Complaints"),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: "Submit",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifications",
          ),
        ],
      ),
    );
  }
}
