import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/skillbuddy_state.dart';
import '../models/course.dart';
import '../screens/course_detail_screen.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';

class CoursesScreen extends StatefulWidget {
  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  int _selectedIndex = 1; // Set the default index to the Courses tab

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return; // Prevent re-navigation to the same screen
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
          break;
        case 1:
        // Already on the Courses screen, do nothing
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SettingsScreen()),
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SkillBuddyState>(
      builder: (context, skillBuddyState, child) {
        final courses = skillBuddyState.enrolledCourses;

        return WillPopScope(
          onWillPop: () async {
            return false; // Prevent going back to the previous screen (DomainSelectionScreen)
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text('Enrolled Courses'),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6a5acd), Color(0xFFff7f50)], // Custom gradient color
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              automaticallyImplyLeading: false, // Remove the back arrow
            ),
            body: courses.isEmpty
                ? Center(
              child: Text(
                'No courses enrolled yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    leading: course.imageUrl.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        course.imageUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    )
                        : Icon(
                      Icons.book,
                      size: 80,
                      color: Colors.grey,
                    ),
                    title: Text(
                      course.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      course.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      // Navigate to CourseDetailScreen with the selected course
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CourseDetailScreen(course: course),
                        ),
                      );
                    },
                  ),
                );
              },
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
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.book), label: 'Courses'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'Settings'),
                ],
                selectedItemColor: Colors.blueAccent,
                unselectedItemColor: Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }
}
