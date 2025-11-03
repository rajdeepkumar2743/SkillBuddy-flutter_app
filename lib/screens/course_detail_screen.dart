import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/course.dart';
import '../providers/skillbuddy_state.dart';

class CourseDetailScreen extends StatefulWidget {
  final Course course;

  CourseDetailScreen({required this.course});

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  bool _isAgreed = false; // Checkbox state

  double _calculateAmount(String importance, int weeks) {
    double baseAmount = 1500.0; // Base amount
    double amount = baseAmount;

    if (importance == 'High') {
      amount *= 1.5; // Increase amount for high importance
    } else if (importance == 'Medium') {
      amount *= 1.2; // Increase amount for medium importance
    }

    amount += weeks * 100; // Add additional amount based on weeks

    return amount;
  }

  void _showPaymentDialog(BuildContext context) {
    double amount = _calculateAmount(widget.course.importance, widget.course.weeks);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Required'),
          content: Container(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Course: ${widget.course.title}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Duration: ${widget.course.duration}'),
                  SizedBox(height: 16),
                  Text(
                    'To start this course, you need to make a payment of ₹${amount.toStringAsFixed(2)}.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Course Details:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(widget.course.description),
                  SizedBox(height: 16),
                  Text(
                    'Instructor:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(widget.course.instructor ?? 'Not Available'),
                  SizedBox(height: 16),
                  Text(
                    'Course Format:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(widget.course.format ?? 'Not Available'),
                  SizedBox(height: 16),
                  Text(
                    'Payment Details:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Amount: ₹${amount.toStringAsFixed(2)}'),
                  Text('Payment Method: Credit/Debit Card/UPI'),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'I agree to the terms and conditions',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Checkbox(
                        value: _isAgreed,
                        onChanged: (bool? value) {
                          setState(() {
                            _isAgreed = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Pay Now'),
              onPressed: () {
                if (_isAgreed) {
                  _handlePayment();
                  Navigator.of(context).pop(); // Close the dialog after payment
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('You must agree to the terms and conditions.'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handlePayment() {
    // Enroll the user in the course
    final skillBuddyState = Provider.of<SkillBuddyState>(context, listen: false);
    skillBuddyState.enrollInCourse(widget.course);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment successful! You can now access the course.'),
      ),
    );
  }

  void _addToWishlist() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.course.title} added to Wishlist.'),
      ),
    );
  }

  void _shareCourseDetails() {
    final String courseDetails =
        'Check out this course: ${widget.course.title}\nDuration: ${widget.course.duration}\n${widget.course.description}';
    Share.share(courseDetails, subject: 'Check out this course!');
  }

  @override
  Widget build(BuildContext context) {
    final skillBuddyState = Provider.of<SkillBuddyState>(context);
    bool isEnrolled = skillBuddyState.enrolledCourses.contains(widget.course);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.title),
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
      body: SingleChildScrollView( // Wrap the body with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.course.imageUrl.isNotEmpty
                  ? Image.network(
                widget.course.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              )
                  : SizedBox(height: 200), // Placeholder if no image

              SizedBox(height: 16),
              Text(
                widget.course.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                widget.course.description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Duration: ${widget.course.duration}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              Text(
                'Instructor: ${widget.course.instructor ?? 'Not Available'}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Course Format: ${widget.course.format ?? 'Not Available'}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              isEnrolled
                  ? ElevatedButton(
                onPressed: () {
                  // Allow access to the course
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseDetailScreen(course: widget.course),
                    ),
                  );
                },
                child: Text('Access Course'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )
                  : ElevatedButton(
                onPressed: () {
                  _showPaymentDialog(context);
                },
                child: Text('Start Course'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _addToWishlist,
                    child: Text('Add to Wishlist'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _shareCourseDetails,
                    child: Text('Share Course'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
