import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
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
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Last updated: August 10, 2024',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24),
            _buildSection(
              title: 'Introduction',
              content: 'Welcome to SkillBuddy. We are committed to protecting your personal information and your right to privacy. This privacy policy explains how we collect, use, and disclose your information while you use our learning platform.',
            ),
            _buildSection(
              title: 'Information We Collect',
              content: 'We collect personal information that you voluntarily provide when you register on the SkillBuddy app, engage with our learning content, participate in community discussions, or contact us for support.',
            ),
            _buildSection(
              title: 'Use of Your Information',
              content: 'We use your personal information to personalize your learning experience, provide course recommendations, and improve our services. We do not share your personal information with third parties, except as necessary to provide our services or comply with legal obligations.',
            ),
            _buildSection(
              title: 'Data Security',
              content: 'We implement robust security measures to protect your personal information within the SkillBuddy app. However, no method of electronic transmission or storage is completely secure, and we cannot guarantee absolute security.',
            ),
            _buildSection(
              title: 'Your Privacy Rights',
              content: 'Depending on your location, you may have rights regarding your personal information, including the ability to access, update, or delete your data. If you wish to exercise these rights, please contact us through the SkillBuddy support channels.',
            ),
            _buildSection(
              title: 'Changes to This Policy',
              content: 'We may update this privacy policy periodically to reflect changes in our practices, operational needs, or legal requirements. Any changes will be communicated to you through the SkillBuddy app.',
            ),
            _buildSection(
              title: 'Contact Us',
              content: 'If you have any questions about this privacy policy, please contact us at support@skillbuddy.com.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
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
        Text(
          content,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
