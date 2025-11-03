import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/course.dart';
import '../services/api_service.dart';

class SkillBuddyState with ChangeNotifier {
  // User-related properties
  String _username = '';
  String _userEmail = ''; // Property for user email
  String _userPassword = ''; // Property for user password
  bool _isLoggedIn = false;

  // Loading and courses-related properties
  bool _isLoading = true;
  List<Course> _courses = [];
  List<Course> _filteredCourses = [];
  List<Course> _enrolledCourses = []; // Property for enrolled courses

  // Domain selection property
  String _selectedDomain = '';

  // Getters
  String get username => _username;
  String get userEmail => _userEmail; // Getter for user email
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  List<Course> get courses => _filteredCourses;
  List<Course> get enrolledCourses => _enrolledCourses; // Getter for enrolled courses

  // Method to handle user login
  Future<void> login(String email, String password) async {
    _userEmail = email; // Set user email upon login
    _userPassword = password; // Save user password
    _isLoggedIn = true;
    notifyListeners();
    await savePersonalInfo(email, password); // Use the public method to save email and password
  }

  // Method to handle user logout
  Future<void> logout() async {
    try {
      _username = '';
      _userEmail = ''; // Clear user email upon logout
      _userPassword = ''; // Clear user password
      _isLoggedIn = false;
      await _clearPersonalInfo(); // Clear email from SharedPreferences
      notifyListeners();
    } catch (e) {
      print('Logout failed: $e');
    }
  }

  // Method to fetch courses and update state
  Future<void> fetchCourses() async {
    _isLoading = true;
    notifyListeners();

    try {
      _courses = await ApiService.getCourses();
      _filterCourses(); // Filter courses based on the selected domain
    } catch (e) {
      print('Failed to fetch courses: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Method to set selected domain and filter courses
  void setSelectedDomain(String domain) {
    _selectedDomain = domain;
    _filterCourses();
    notifyListeners();
  }

  // Method to filter courses based on the selected domain
  void _filterCourses() {
    if (_selectedDomain.isEmpty) {
      _filteredCourses = _courses;
    } else {
      _filteredCourses = _courses.where((course) => course.domain == _selectedDomain).toList();
    }
  }

  // Method to enroll in a course
  void enrollInCourse(Course course) {
    if (!_enrolledCourses.contains(course)) {
      _enrolledCourses.add(course);
      notifyListeners();
    }
  }

  // Method to check if a course is enrolled
  bool isEnrolled(Course course) {
    return _enrolledCourses.contains(course);
  }

  // Public method to save personal information (user email and password) to SharedPreferences
  Future<void> savePersonalInfo(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', email);
    await prefs.setString('userPassword', password);
  }

  // Method to load personal information (user email and password) from SharedPreferences
  Future<void> loadPersonalInfo() async {
    final prefs = await SharedPreferences.getInstance();
    _userEmail = prefs.getString('userEmail') ?? '';
    _userPassword = prefs.getString('userPassword') ?? '';
    notifyListeners();
  }

  // Method to clear personal information (user email and password) from SharedPreferences
  Future<void> _clearPersonalInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userEmail');
    await prefs.remove('userPassword');
  }
}
