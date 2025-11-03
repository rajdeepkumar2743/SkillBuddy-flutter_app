import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/skillbuddy_state.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 2; // Default index for the 'Settings' tab

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/courses');
        break;
      case 2:
      // Current screen (Settings)
        break;
    }
  }

  void _logout() async {
    final skillBuddyState = Provider.of<SkillBuddyState>(context, listen: false);

    // Call the logout method and wait for its completion
    await skillBuddyState.logout();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logging out...')),
    );

    // Delay navigation to show logout message
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6a5acd), Color(0xFFff7f50)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Account'),
            subtitle: Text('Manage your account settings'),
            onTap: () {
              Navigator.pushNamed(context, '/accountSettings');
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            subtitle: Text('Manage notification preferences'),
            onTap: () {
              Navigator.pushNamed(context, '/notificationSettings');
            },
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Privacy'),
            subtitle: Text('Manage privacy settings'),
            onTap: () {
              Navigator.pushNamed(context, '/privacySettings');
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help & Support'),
            subtitle: Text('Get help and support'),
            onTap: () {
              Navigator.pushNamed(context, '/helpSupport');
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            subtitle: Text('About this app'),
            onTap: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: _logout,
            child: Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlueAccent,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.blueAccent, width: 2.0),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Courses'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
