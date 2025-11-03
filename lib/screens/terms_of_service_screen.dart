import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of Service'),
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
              'Terms of Service',
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
              ),
            ),
            SizedBox(height: 16),
            _buildSectionTitle('Introduction'),
            SizedBox(height: 8),
            _buildSectionContent(
              'Welcome to SkillBuddy. By using our app, you agree to be bound by these terms of service. Please read them carefully before using our app.',
            ),
            SizedBox(height: 16),
            _buildSectionTitle('Use of the Service'),
            SizedBox(height: 8),
            _buildSectionContent(
              'You agree to use the SkillBuddy app only for lawful purposes and in accordance with these terms. You are responsible for all activities that occur under your account.',
            ),
            SizedBox(height: 16),
            _buildSectionTitle('Account Registration'),
            SizedBox(height: 8),
            _buildSectionContent(
              'To access personalized learning paths and features of SkillBuddy, you may be required to register for an account. You agree to provide accurate and complete information during the registration process and to update such information as necessary.',
            ),
            SizedBox(height: 16),
            _buildSectionTitle('User Responsibilities'),
            SizedBox(height: 8),
            _buildSectionContent(
              'You are responsible for maintaining the confidentiality of your account information, including your password, and for all activities that occur under your account. You agree to notify us immediately of any unauthorized use of your account.',
            ),
            SizedBox(height: 16),
            _buildSectionTitle('Termination'),
            SizedBox(height: 8),
            _buildSectionContent(
              'We reserve the right to terminate or suspend your access to the SkillBuddy app at any time, without notice, for conduct that we believe violates these terms, is harmful to other users, or is otherwise illegal.',
            ),
            SizedBox(height: 16),
            _buildSectionTitle('Limitation of Liability'),
            SizedBox(height: 8),
            _buildSectionContent(
              'To the maximum extent permitted by law, SkillBuddy shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses, resulting from your use of the app.',
            ),
            SizedBox(height: 16),
            _buildSectionTitle('Governing Law'),
            SizedBox(height: 8),
            _buildSectionContent(
              'These terms shall be governed by and construed in accordance with the laws of the country in which you reside, without regard to its conflict of law principles.',
            ),
            SizedBox(height: 16),
            _buildSectionTitle('Changes to Terms'),
            SizedBox(height: 8),
            _buildSectionContent(
              'We may update these terms from time to time. If we make material changes, we will provide you with notice through the SkillBuddy app or by other means, so you have the opportunity to review the changes before they become effective.',
            ),
            SizedBox(height: 16),
            _buildSectionTitle('Contact Us'),
            SizedBox(height: 8),
            _buildSectionContent(
              'If you have any questions about these terms, please contact us at support@skillbuddy.com.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(fontSize: 16),
    );
  }
}
