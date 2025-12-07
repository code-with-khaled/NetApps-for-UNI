import 'package:flutter/material.dart';
import 'package:network_apps/viewmodels/submit_complaint_viewmodel.dart';
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
    ChangeNotifierProvider(
      create: (_) => SubmitComplaintViewModel(),
      child: const SubmitComplaintScreen(),
    ),
    const NotificationsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // TODO: call your AuthViewModel.logout() or clear session
              Navigator.pushReplacementNamed(context, '/auth');
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
