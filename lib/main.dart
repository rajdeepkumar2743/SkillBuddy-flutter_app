import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/skillbuddy_state.dart';
import 'providers/account_settings_provider.dart';
import 'providers/privacy_settings_provider.dart';
import 'providers/notification_settings_provider.dart';
import 'providers/user_provider.dart';
import 'theme.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/subscription_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/account_settings_screen.dart';
import 'screens/notification_settings_screen.dart';
import 'screens/privacy_settings_screen.dart';
import 'screens/help_support_screen.dart';
import 'screens/about_screen.dart';
import 'screens/feedback_screen.dart';
import 'screens/update_personal_info_screen.dart';
import 'screens/update_phone_number_screen.dart';
import 'screens/change_password_screen.dart';
import 'screens/email_preferences_screen.dart';
import 'screens/security_settings_screen.dart';
import 'screens/faq_screen.dart';
import 'screens/contact_us_screen.dart';
import 'screens/report_problem_screen.dart';
import 'screens/privacy_policy_screen.dart';
import 'screens/terms_of_service_screen.dart';
import 'screens/domain_selection_screen.dart';
import 'screens/courses_screen.dart';
import 'screens/course_detail_screen.dart';
import 'models/course.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  // Example course data
  List<Course> courses = [
    Course(title: 'Flutter Basics', description: 'Learn the basics of Flutter', category: 'Development', duration: '4 weeks', instructor: 'John Doe', rating: 4.5, imageUrl: '', domain: 'Development', importance: 'High', weeks: 4),
    // Add more courses here
  ];

  // Load enrollment status
  for (var course in courses) {
    course.isEnrolled = prefs.getBool('enrolled_${course.title}') ?? false;
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SkillBuddyState()..fetchCourses()), // Initialize courses
        ChangeNotifierProvider(create: (_) => AccountSettingsProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => NotificationSettingsProvider()),
        ChangeNotifierProvider(create: (_) => PrivacySettingsProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkillBuddy',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/domainSelection': (context) => DomainSelectionScreen(),
        '/home': (context) => HomeScreen(),
        '/subscriptions': (context) => SubscriptionScreen(),
        '/settings': (context) => SettingsScreen(),
        '/accountSettings': (context) => AccountSettingsScreen(),
        '/updatePersonalInfo': (context) => UpdatePersonalInfoScreen(),
        '/notificationSettings': (context) => NotificationSettingsScreen(),
        '/privacySettings': (context) => PrivacySettingsScreen(),
        '/helpSupport': (context) => HelpSupportScreen(),
        '/about': (context) => AboutScreen(),
        '/feedback': (context) => FeedbackScreen(),
        '/updatePhoneNumber': (context) => UpdatePhoneNumberScreen(),
        '/changePassword': (context) => ChangePasswordScreen(),
        '/emailPreferences': (context) => EmailPreferencesScreen(),
        '/securitySettings': (context) => SecuritySettingsScreen(),
        '/faq': (context) => FAQScreen(),
        '/contactUs': (context) => ContactUsScreen(),
        '/reportProblem': (context) => ReportProblemScreen(),
        '/privacyPolicy': (context) => PrivacyPolicyScreen(),
        '/termsOfService': (context) => TermsOfServiceScreen(),
        '/courses': (context) => CoursesScreen(), // Use Provider to access courses
        '/courseDetail': (context) => CourseDetailScreen(course: ModalRoute.of(context)!.settings.arguments as Course), // Add the route
      },
    );
  }
}
