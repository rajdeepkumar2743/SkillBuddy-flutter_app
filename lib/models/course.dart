class Course {
  final String title;
  final String description;
  final String category;
  final String duration;
  final String instructor;
  final double rating;
  final String imageUrl;
  final String domain; // New attribute
  final String? format;
  final String importance; // New attribute
  final int weeks; // New attribute
  bool isEnrolled; // Add this field to track enrollment

  Course({
    required this.title,
    required this.description,
    required this.category,
    required this.duration,
    required this.instructor,
    required this.rating,
    required this.imageUrl,
    required this.domain, // Initialize new attribute
    this.format,
    required this.importance, // Initialize new attribute
    required this.weeks, // Initialize new attribute
    this.isEnrolled = false, // Default to false
  });

  // Factory constructor to create a Course instance from JSON
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'] ?? '', // Provide default values if necessary
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      duration: json['duration'] ?? '',
      instructor: json['instructor'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0, // Handle null values
      imageUrl: json['imageUrl'] ?? '',
      domain: json['domain'] ?? '', // Handle the new field
      format: json['format'], // Handle optional format field
      importance: json['importance'] ?? '', // Handle the new field
      weeks: (json['weeks'] as num?)?.toInt() ?? 0, // Handle null values
    );
  }

  // Method to convert a Course instance to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'duration': duration,
      'instructor': instructor,
      'rating': rating,
      'imageUrl': imageUrl,
      'domain': domain, // Add this line
      'format': format, // Optional field
      'importance': importance, // Add this line
      'weeks': weeks, // Add this line
    };
  }
}
