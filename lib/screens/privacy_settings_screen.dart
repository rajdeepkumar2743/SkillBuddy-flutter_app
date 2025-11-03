import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/privacy_settings_provider.dart';

class PrivacySettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final privacyProvider = Provider.of<PrivacySettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Settings'),
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
        child: ListView(
          children: [
            _buildSection(
              title: 'Profile Privacy',
              subtitle: 'Only you can see your profile details.',
              value: privacyProvider.privateProfile,
              onChanged: (bool value) {
                privacyProvider.setPrivateProfile(value);
              },
            ),
            _buildSection(
              title: 'Data Sharing',
              subtitle: 'Allow sharing your data with our partners for better service.',
              value: privacyProvider.dataSharing,
              onChanged: (bool value) {
                privacyProvider.setDataSharing(value);
              },
            ),
            _buildSection(
              title: 'Location Tracking',
              subtitle: 'Allow the app to track your location for better service recommendations.',
              value: privacyProvider.locationTracking,
              onChanged: (bool value) {
                privacyProvider.setLocationTracking(value);
              },
            ),
            SizedBox(height: 32),
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Your privacy is important to us. We use your data to enhance your experience and provide better services. For more information, please review our Privacy Policy.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Privacy settings updated')),
                );
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        SwitchListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          value: value,
          onChanged: onChanged,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
