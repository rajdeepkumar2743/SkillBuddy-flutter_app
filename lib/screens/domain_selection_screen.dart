import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/skillbuddy_state.dart';

class DomainSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Your Domain'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6a5acd), Color(0xFFff7f50)], // Custom gradient color
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: DomainSelectionBody(),
    );
  }
}

class DomainSelectionBody extends StatefulWidget {
  @override
  _DomainSelectionBodyState createState() => _DomainSelectionBodyState();
}

class _DomainSelectionBodyState extends State<DomainSelectionBody> {
  String? _selectedDomain;

  final List<String> _domains = [
    'Development',
    'Design',
    'Programming',
    'Data Science',
    'Security',
    'Machine Learning',
    'Cloud Computing',
    'Web Development',
    'Database',
    'Artificial Intelligence',
    'Networking',
    'Software Engineering',
    'Blockchain',
    'Virtual Reality',
    'IoT',
    'Game Development',
    'DevOps',
    'Quantum Computing',
    'Ethics',
    'Algorithms',
    'Testing',
    'Operating Systems'
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Please select the domain you are interested in:',
            style: textTheme.titleLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ) ??
                TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _domains.length,
              itemBuilder: (context, index) {
                final domain = _domains[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        domain,
                        style: textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ) ??
                            TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      trailing: Radio<String>(
                        value: domain,
                        groupValue: _selectedDomain,
                        onChanged: (value) {
                          setState(() {
                            _selectedDomain = value;
                          });
                        },
                      ),
                      onTap: () {
                        setState(() {
                          _selectedDomain = domain;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                if (_selectedDomain != null) {
                  // Store the selected domain in SkillBuddyState
                  Provider.of<SkillBuddyState>(context, listen: false)
                      .setSelectedDomain(_selectedDomain!);

                  // Store selection state in SharedPreferences
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('domain_selected', true);

                  Navigator.pushNamed(
                    context,
                    '/home',
                    arguments: _selectedDomain, // Pass selected domain here
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select a domain'),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple, // Custom button color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
