



class Course {
  final String title;
  final String description;
  final String duration;
  

  Course({required this.title, required this.description, required this.duration});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title']??"",
      description: json['description']??"",
      duration: json['duration']??"",
    );
  }
}

class ApiResponse {
  final String status;
  final List<Course> courses;

  ApiResponse({required this.status, required this.courses});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> courseJsonList = json['data']['course'];
    List<Course> courses = courseJsonList.map((e) => Course.fromJson(e)).toList();

    return ApiResponse(status: json['status'], courses: courses);
  }
}
