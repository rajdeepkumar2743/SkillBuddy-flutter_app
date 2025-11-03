import 'package:flutter/material.dart';

class ReportProblemScreen extends StatefulWidget {
  @override
  _ReportProblemScreenState createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report a Problem'),
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
              'Please describe the issue you are experiencing:',
              style: Theme.of(context).textTheme.titleMedium, // Use subtitle1 for newer versions or adjust accordingly
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Describe the issue',
                contentPadding: EdgeInsets.all(12.0),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Logic to report the problem
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Your report has been submitted!')),
                );
                // Clear the field after submission
                _descriptionController.clear();
              },
              child: Text('Submit Report'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Button color
                overlayColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0), // Button padding
                textStyle: TextStyle(fontSize: 16), // Text style
              ),
            ),
          ],
        ),
      ),
    );
  }
}
