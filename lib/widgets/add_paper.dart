import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

/// Widget to add a new question paper
/// Shows a bottom sheet form with all required fields
class AddPaper extends StatefulWidget {
  // Callback function when paper is added
  final Function(Map<String, dynamic>) onPaperAdded;

  const AddPaper({
    super.key,
    required this.onPaperAdded,
  });

  @override
  State<AddPaper> createState() => _AddPaperState();
}

class _AddPaperState extends State<AddPaper> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final _subjectController = TextEditingController();
  final _yearController = TextEditingController();

  // Selected values for dropdowns
  String? _selectedSemester;
  String? _selectedRegulation;
  String? _selectedExamType;

  // Selected file path
  String? _selectedFilePath;
  String? _selectedFileName;

  // Available options for dropdowns
  final List<String> _semesters = [
    'Sem 1',
    'Sem 2',
    'Sem 3',
    'Sem 4',
    'Sem 5',
    'Sem 6',
    'Sem 7',
    'Sem 8',
  ];

  final List<String> _regulations = [
    'R2019',
    'R2021',
    'R2023',
    'R2024',
  ];

  final List<String> _examTypes = [
    'Mid',
    'End',
    'Model',
  ];

  @override
  void dispose() {
    // Clean up controllers
    _subjectController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  /// Pick a PDF file using file picker
  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedFilePath = result.files.single.path!;
          _selectedFileName = result.files.single.name;
        });
      }
    } catch (e) {
      // Show error if file picking fails
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Validate and submit the form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Check if file is selected
      if (_selectedFilePath == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a PDF file'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Create paper data map
      final paperData = {
        'subjectName': _subjectController.text.trim(),
        'semester': _selectedSemester!,
        'regulation': _selectedRegulation!,
        'examType': _selectedExamType!,
        'year': int.parse(_yearController.text.trim()),
        'filePath': _selectedFilePath!,
      };

      // Call callback to add paper
      widget.onPaperAdded(paperData);

      // Close bottom sheet
      Navigator.pop(context);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Question paper added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                'Add Question Paper',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Subject name field
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject Name *',
                  hintText: 'e.g., Data Structures',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter subject name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Semester dropdown
              DropdownButtonFormField<String>(
                value: _selectedSemester,
                decoration: const InputDecoration(
                  labelText: 'Semester *',
                  border: OutlineInputBorder(),
                ),
                items: _semesters.map((semester) {
                  return DropdownMenuItem<String>(
                    value: semester,
                    child: Text(semester),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSemester = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select semester';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Regulation dropdown
              DropdownButtonFormField<String>(
                value: _selectedRegulation,
                decoration: const InputDecoration(
                  labelText: 'Regulation *',
                  border: OutlineInputBorder(),
                ),
                items: _regulations.map((regulation) {
                  return DropdownMenuItem<String>(
                    value: regulation,
                    child: Text(regulation),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRegulation = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select regulation';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Exam type dropdown
              DropdownButtonFormField<String>(
                value: _selectedExamType,
                decoration: const InputDecoration(
                  labelText: 'Exam Type *',
                  border: OutlineInputBorder(),
                ),
                items: _examTypes.map((examType) {
                  return DropdownMenuItem<String>(
                    value: examType,
                    child: Text(examType),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedExamType = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select exam type';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Year field
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(
                  labelText: 'Year *',
                  hintText: 'e.g., 2022',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter year';
                  }
                  final year = int.tryParse(value.trim());
                  if (year == null || year < 2000 || year > 2100) {
                    return 'Please enter a valid year';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // File picker button
              OutlinedButton.icon(
                onPressed: _pickFile,
                icon: const Icon(Icons.upload_file),
                label: const Text('Select PDF File *'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),

              // Show selected file name
              if (_selectedFileName != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green[300]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green[700]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _selectedFileName!,
                          style: TextStyle(color: Colors.green[900]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Add Paper',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

