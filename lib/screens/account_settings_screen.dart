import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/account_settings_provider.dart';
import '../providers/user_provider.dart';
import '../providers/skillbuddy_state.dart'; // Import the SkillBuddyState provider

class AccountSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountSettingsProvider>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final skillBuddyState = Provider.of<SkillBuddyState>(context); // Access SkillBuddyState

    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
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
            title: Text('Personal Information'),
            subtitle: Text(
              accountProvider.name.isNotEmpty
                  ? 'Name: ${accountProvider.name}\nEmail: ${skillBuddyState.userEmail}'
                  : 'Name: Enter your Name\nEmail: ${skillBuddyState.userEmail}',
            ),
            onTap: () {
              _showPersonalInfoDialog(context, accountProvider);
            },
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Phone Number'),
            subtitle: Text(
              accountProvider.phoneNumber.isNotEmpty
                  ? 'Phone: ${accountProvider.phoneNumber}'
                  : 'Phone: Enter your Phone number',
            ),
            onTap: () {
              _showPhoneNumberDialog(context, accountProvider);
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Change Password'),
            subtitle: Text('Change your account password'),
            onTap: () {
              Navigator.pushNamed(context, '/changePassword');
            },
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email Preferences'),
            subtitle: Text('Email notifications: ${accountProvider.emailPreferences ? "Enabled" : "Disabled"}'),
            onTap: () {
              Navigator.pushNamed(context, '/emailPreferences');
            },
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Security Settings'),
            subtitle: Text('Two-factor authentication: ${accountProvider.twoFactorAuth ? "Enabled" : "Disabled"}'),
            onTap: () {
              Navigator.pushNamed(context, '/securitySettings');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            subtitle: Text('Sign out of your account'),
            onTap: () {
              userProvider.logout();
              accountProvider.logout();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Logging out...')),
              );

              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
          ),
        ],
      ),
    );
  }

  void _showPersonalInfoDialog(BuildContext context, AccountSettingsProvider provider) {
    final _nameController = TextEditingController(text: provider.name);
    final _emailController = TextEditingController(text: provider.email);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Personal Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                provider.updateName(_nameController.text);
                provider.updateEmail(_emailController.text);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showPhoneNumberDialog(BuildContext context, AccountSettingsProvider provider) {
    final _phoneNumberController = TextEditingController(text: provider.phoneNumber);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Phone Number'),
          content: TextField(
            controller: _phoneNumberController,
            decoration: InputDecoration(labelText: 'Phone Number'),
            keyboardType: TextInputType.phone,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                provider.updatePhoneNumber(_phoneNumberController.text);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
