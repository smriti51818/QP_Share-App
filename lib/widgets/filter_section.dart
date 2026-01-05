import 'package:flutter/material.dart';

/// Widget to display filter dropdowns
/// Allows filtering papers by Semester, Regulation, and Subject
class FilterSection extends StatelessWidget {
  // Current selected values for filters
  final String? selectedSemester;
  final String? selectedRegulation;
  final String? selectedSubject;

  // Lists of available options
  final List<String> semesters;
  final List<String> regulations;
  final List<String> subjects;

  // Callback functions when filters change
  final Function(String?) onSemesterChanged;
  final Function(String?) onRegulationChanged;
  final Function(String?) onSubjectChanged;

  const FilterSection({
    super.key,
    required this.selectedSemester,
    required this.selectedRegulation,
    required this.selectedSubject,
    required this.semesters,
    required this.regulations,
    required this.subjects,
    required this.onSemesterChanged,
    required this.onRegulationChanged,
    required this.onSubjectChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter title
          const Text(
            'Filter Papers',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Semester filter dropdown
          DropdownButtonFormField<String>(
            value: selectedSemester,
            decoration: const InputDecoration(
              labelText: 'Semester',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            hint: const Text('All Semesters'),
            items: [
              const DropdownMenuItem<String>(
                value: null,
                child: Text('All Semesters'),
              ),
              ...semesters.map((semester) {
                return DropdownMenuItem<String>(
                  value: semester,
                  child: Text(semester),
                );
              }),
            ],
            onChanged: onSemesterChanged,
          ),

          const SizedBox(height: 12),

          // Regulation filter dropdown
          DropdownButtonFormField<String>(
            value: selectedRegulation,
            decoration: const InputDecoration(
              labelText: 'Regulation',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            hint: const Text('All Regulations'),
            items: [
              const DropdownMenuItem<String>(
                value: null,
                child: Text('All Regulations'),
              ),
              ...regulations.map((regulation) {
                return DropdownMenuItem<String>(
                  value: regulation,
                  child: Text(regulation),
                );
              }),
            ],
            onChanged: onRegulationChanged,
          ),

          const SizedBox(height: 12),

          // Subject filter dropdown
          DropdownButtonFormField<String>(
            value: selectedSubject,
            decoration: const InputDecoration(
              labelText: 'Subject',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            hint: const Text('All Subjects'),
            items: [
              const DropdownMenuItem<String>(
                value: null,
                child: Text('All Subjects'),
              ),
              ...subjects.map((subject) {
                return DropdownMenuItem<String>(
                  value: subject,
                  child: Text(subject),
                );
              }),
            ],
            onChanged: onSubjectChanged,
          ),
        ],
      ),
    );
  }
}

