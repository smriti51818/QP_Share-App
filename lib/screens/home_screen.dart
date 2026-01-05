import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/question_paper.dart';
import '../models/user.dart';
import '../widgets/filter_section.dart';
import '../widgets/paper_list.dart';
import '../widgets/add_paper.dart';

/// Main home screen of the app
/// Manages all question papers and filtering logic
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List to store all question papers
  List<QuestionPaper> _allPapers = [];

  // Filter values
  String? _selectedSemester;
  String? _selectedRegulation;
  String? _selectedSubject;

  // Counter for generating unique IDs
  int _idCounter = 1;

  // Current logged-in user
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    // Load saved papers and user info when app starts
    _loadPapers();
    _loadUser();
  }

  /// Load current user information
  Future<void> _loadUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final name = prefs.getString('user_name') ?? '';
      final rollNumber = prefs.getString('user_roll_number') ?? '';
      
      if (name.isNotEmpty && rollNumber.isNotEmpty) {
        setState(() {
          _currentUser = User(name: name, rollNumber: rollNumber);
        });
      }
    } catch (e) {
      debugPrint('Error loading user: $e');
    }
  }

  /// Handle logout
  Future<void> _handleLogout() async {
    // Show confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      // Clear login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', false);
      await prefs.remove('user_name');
      await prefs.remove('user_roll_number');

      // Navigate to login screen
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  /// Load papers from SharedPreferences
  Future<void> _loadPapers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final papersJson = prefs.getStringList('question_papers') ?? [];
      
      setState(() {
        _allPapers = papersJson.map((json) {
          final map = jsonDecode(json) as Map<String, dynamic>;
          return QuestionPaper.fromMap(map);
        }).toList();
        
        // Update ID counter to avoid conflicts
        if (_allPapers.isNotEmpty) {
          final maxId = _allPapers
              .map((p) => int.tryParse(p.id) ?? 0)
              .reduce((a, b) => a > b ? a : b);
          _idCounter = maxId + 1;
        }
      });
    } catch (e) {
      // If loading fails, start with empty list
      debugPrint('Error loading papers: $e');
    }
  }

  /// Save papers to SharedPreferences
  Future<void> _savePapers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final papersJson = _allPapers.map((paper) {
        return jsonEncode(paper.toMap());
      }).toList();
      
      await prefs.setStringList('question_papers', papersJson);
    } catch (e) {
      debugPrint('Error saving papers: $e');
    }
  }

  /// Get filtered list of papers based on selected filters
  List<QuestionPaper> get _filteredPapers {
    return _allPapers.where((paper) {
      // Filter by semester
      if (_selectedSemester != null && paper.semester != _selectedSemester) {
        return false;
      }
      
      // Filter by regulation
      if (_selectedRegulation != null && paper.regulation != _selectedRegulation) {
        return false;
      }
      
      // Filter by subject
      if (_selectedSubject != null && paper.subjectName != _selectedSubject) {
        return false;
      }
      
      return true;
    }).toList();
  }

  /// Get unique list of semesters from all papers
  List<String> get _availableSemesters {
    final semesters = _allPapers.map((p) => p.semester).toSet().toList();
    semesters.sort();
    return semesters;
  }

  /// Get unique list of regulations from all papers
  List<String> get _availableRegulations {
    final regulations = _allPapers.map((p) => p.regulation).toSet().toList();
    regulations.sort();
    return regulations;
  }

  /// Get unique list of subjects from all papers
  List<String> get _availableSubjects {
    final subjects = _allPapers.map((p) => p.subjectName).toSet().toList();
    subjects.sort();
    return subjects;
  }

  /// Add a new question paper
  void _addPaper(Map<String, dynamic> paperData) {
    final newPaper = QuestionPaper(
      subjectName: paperData['subjectName'],
      semester: paperData['semester'],
      regulation: paperData['regulation'],
      examType: paperData['examType'],
      year: paperData['year'],
      filePath: paperData['filePath'],
      id: _idCounter.toString(),
    );

    setState(() {
      _allPapers.add(newPaper);
      _idCounter++;
    });

    // Save to SharedPreferences
    _savePapers();
  }

  /// Delete a question paper by ID
  void _deletePaper(String id) {
    setState(() {
      _allPapers.removeWhere((paper) => paper.id == id);
    });

    // Save to SharedPreferences
    _savePapers();

    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Question paper deleted'),
        backgroundColor: Colors.red,
      ),
    );
  }

  /// Show bottom sheet to add a new paper
  void _showAddPaperSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AddPaper(
        onPaperAdded: _addPaper,
      ),
    );
  }

  /// Show user information dialog
  void _showUserInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('User Information'),
        content: _currentUser != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(Icons.person, 'Name', _currentUser!.name),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    Icons.badge,
                    'Roll Number',
                    _currentUser!.rollNumber,
                  ),
                ],
              )
            : const Text('No user information available'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  /// Build a row for displaying user info
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Question Papers'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          // Show user info and logout option
          if (_currentUser != null)
            PopupMenuButton<String>(
              icon: const Icon(Icons.account_circle),
              onSelected: (value) {
                if (value == 'logout') {
                  _handleLogout();
                } else if (value == 'info') {
                  _showUserInfo();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'info',
                  child: Row(
                    children: [
                      const Icon(Icons.person, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _currentUser!.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _currentUser!.rollNumber,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 20, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Logout', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
      body: Column(
        children: [
          // Filter section at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FilterSection(
              selectedSemester: _selectedSemester,
              selectedRegulation: _selectedRegulation,
              selectedSubject: _selectedSubject,
              semesters: _availableSemesters,
              regulations: _availableRegulations,
              subjects: _availableSubjects,
              onSemesterChanged: (value) {
                setState(() {
                  _selectedSemester = value;
                });
              },
              onRegulationChanged: (value) {
                setState(() {
                  _selectedRegulation = value;
                });
              },
              onSubjectChanged: (value) {
                setState(() {
                  _selectedSubject = value;
                });
              },
            ),
          ),

          // Paper count indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  'Showing ${_filteredPapers.length} of ${_allPapers.length} papers',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // List of papers
          Expanded(
            child: PaperList(
              papers: _filteredPapers,
              onDelete: _deletePaper,
            ),
          ),
        ],
      ),

      // Floating action button to add new paper
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPaperSheet,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

