import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/skillbuddy_state.dart'; // Ensure SkillBuddyState is managing the courses

class SubscriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final skillBuddyState = Provider.of<SkillBuddyState>(context);
    final courses = skillBuddyState.courses; // Access courses from SkillBuddyState

    return Scaffold(
      appBar: AppBar(title: Text('Subscriptions')),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (ctx, i) => SubscriptionCard(course: courses[i]),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final Course course;

  SubscriptionCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text('${course.title} Subscription'),
        subtitle: Text('Get regular updates on ${course.title} at a discounted rate.'),
        trailing: SubscriptionButton(course: course),
      ),
    );
  }
}

class SubscriptionButton extends StatelessWidget {
  final Course course;

  SubscriptionButton({required this.course});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle subscription logic here
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Subscribed!'),
            content: Text('You have successfully subscribed to ${course.title} course updates.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
      child: Text('Subscribe'),
    );
  }
}
