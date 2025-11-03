import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
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
            Text(
              'About This App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'SkillBuddy is a mobile application designed to help users develop new skills and enhance their knowledge through personalized learning paths, interactive content, and community engagement. Our mission is to empower individuals to achieve their learning goals and stay competitive in today’s rapidly changing job market.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Features:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '• Personalized learning paths\n'
                  '• Interactive content and quizzes\n'
                  '• Community support and collaboration\n'
                  '• Up-to-date content on the latest skills and trends\n'
                  '• User-friendly interface with modern design\n'
                  '• Progress tracking and achievements\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Developed By:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Team RR\n'
                  'We are a group of passionate developers committed to creating innovative solutions that make learning accessible and engaging for everyone. If you have any questions or feedback, feel free to reach out to us.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Contact Us:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Email: support@skillbuddy.com\n'
                  'Phone: (+91) 46458-31940\n'
                  'Website: www.skillbuddy.com\n',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
