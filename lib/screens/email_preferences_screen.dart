import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/account_settings_provider.dart';

class EmailPreferencesScreen extends StatefulWidget {
  @override
  _EmailPreferencesScreenState createState() => _EmailPreferencesScreenState();
}

class _EmailPreferencesScreenState extends State<EmailPreferencesScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AccountSettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Email Preferences'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text('Receive Email Notifications'),
              subtitle: Text(
                provider.emailPreferences
                    ? 'You will receive email notifications.'
                    : 'You will not receive email notifications.',
              ),
              value: provider.emailPreferences,
              onChanged: (bool value) {
                provider.updateEmailPreferences(value);
              },
              secondary: Icon(Icons.email, color: Colors.blue),
            ),
            SizedBox(height: 20),
            // Additional options if needed
            // For example:
            // ListTile(
            //   leading: Icon(Icons.update, color: Colors.purpleAccent),
            //   title: Text('Email Frequency'),
            //   subtitle: Text('Select how often you want to receive emails.'),
            //   onTap: () {
            //     // Navigate to frequency selection
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
