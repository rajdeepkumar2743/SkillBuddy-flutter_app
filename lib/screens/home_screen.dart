import 'package:flutter/material.dart';
import '../models/course.dart';
import '../services/api_service.dart'; // Import ApiService
import 'course_detail_screen.dart';
import '../widgets/footer_section.dart'; // Import the FooterSection

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Course> _courses = [];
  List<Course> _filteredCourses = [];
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _fetchCourses(); // Fetch courses when the screen initializes
  }

  Future<void> _fetchCourses() async {
    try {
      List<Course> courses = await ApiService.getCourses();
      setState(() {
        _courses = courses;
        _filteredCourses = _courses; // Set initial filtered courses
        _isLoading = false; // Set loading to false after data is fetched
      });
    } catch (e) {
      // Handle any errors that might occur
      print('Error fetching courses: $e');
      setState(() {
        _isLoading = false; // Set loading to false even if there is an error
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Add navigation logic here based on index
    switch (index) {
      case 0:
      // Already on Home screen
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/courses'); // Adjust route if needed
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/settings'); // Adjust route if needed
        break;
    }
  }

  void _filterCourses(String query) {
    final filteredCourses = _courses.where((course) {
      final courseTitle = course.title.toLowerCase();
      final searchQuery = query.toLowerCase();
      return courseTitle.contains(searchQuery);
    }).toList();

    setState(() {
      _filteredCourses = filteredCourses;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the domain passed as an argument
    final String? selectedDomain = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text('SkillBuddy'),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeaderSection(),
          SizedBox(height: 6),
          SizedBox(height: 15),
          SearchBar(onSearch: _filterCourses), // Pass the callback
          SizedBox(height: 10),
          if (_isLoading)
            Center(child: CircularProgressIndicator())
          else
            Expanded(
              child: _filteredCourses.isEmpty
                  ? Center(child: Text('No courses available'))
                  : ListView.builder(
                itemCount: _filteredCourses.length,
                itemBuilder: (context, index) {
                  return CourseCard(course: _filteredCourses[index]);
                },
              ),
            ),
        ],
      ),
      bottomNavigationBar: FooterSection(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ), // Use FooterSection here
    );
  }
}

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 95,
              height: 100,
            ),
            SizedBox(height: 0),
            Text(
              'Welcome to SkillBuddy',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              'Your Personal Learning Companion',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  final Function(String) onSearch;

  SearchBar({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          onChanged: onSearch, // Pass the callback to handle search
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search for skills, courses, or topics',
            icon: Icon(Icons.search, color: Colors.blueAccent),
          ),
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;

  CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(Icons.book, color: Colors.blueAccent),
        title: Text(course.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Text(course.description, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        trailing: Icon(Icons.arrow_forward, color: Colors.blueAccent),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CourseDetailScreen(course: course)),
          );
        },
      ),
    );
  }
}

// FooterSection widget handling the BottomNavigationBar
class FooterSection extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  FooterSection({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.blueAccent, width: 2.0),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 24), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book, size: 24), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.settings, size: 24), label: 'Settings'),
        ],
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        showSelectedLabels: true,
      ),
    );
  }
}
