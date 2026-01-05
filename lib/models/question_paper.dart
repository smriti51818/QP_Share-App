/// Model class to represent a Question Paper
/// Contains all the details about a question paper
class QuestionPaper {
  // Subject name (e.g., "Data Structures", "Operating Systems")
  final String subjectName;

  // Semester (e.g., "Sem 1", "Sem 2", "Sem 3")
  final String semester;

  // Regulation (e.g., "R2019", "R2021", "R2023")
  final String regulation;

  // Exam type (e.g., "Mid", "End", "Model")
  final String examType;

  // Year (e.g., 2022, 2023)
  final int year;

  // Local file path to the PDF
  final String filePath;

  // Unique ID for each paper (used for deletion)
  final String id;

  // Constructor
  QuestionPaper({
    required this.subjectName,
    required this.semester,
    required this.regulation,
    required this.examType,
    required this.year,
    required this.filePath,
    required this.id,
  });

  // Convert QuestionPaper to Map (for saving to SharedPreferences)
  Map<String, dynamic> toMap() {
    return {
      'subjectName': subjectName,
      'semester': semester,
      'regulation': regulation,
      'examType': examType,
      'year': year,
      'filePath': filePath,
      'id': id,
    };
  }

  // Create QuestionPaper from Map (for loading from SharedPreferences)
  factory QuestionPaper.fromMap(Map<String, dynamic> map) {
    return QuestionPaper(
      subjectName: map['subjectName'] ?? '',
      semester: map['semester'] ?? '',
      regulation: map['regulation'] ?? '',
      examType: map['examType'] ?? '',
      year: map['year'] ?? 0,
      filePath: map['filePath'] ?? '',
      id: map['id'] ?? '',
    );
  }

  // Get the PDF file name from the path
  String get fileName {
    // Extract just the filename from the full path
    // Example: "C:/Users/.../file.pdf" -> "file.pdf"
    return filePath.split('/').last.split('\\').last;
  }
}

