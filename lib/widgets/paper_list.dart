import 'package:flutter/material.dart';
import '../models/question_paper.dart';

/// Widget to display the list of question papers
/// Shows papers in a card layout with delete option
class PaperList extends StatelessWidget {
  // List of papers to display
  final List<QuestionPaper> papers;

  // Callback function when a paper is deleted
  final Function(String) onDelete;

  const PaperList({
    super.key,
    required this.papers,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // If no papers, show empty state
    if (papers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.description_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No papers found for selected filters',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the + button to add a paper',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    // Display list of papers
    return ListView.builder(
      itemCount: papers.length,
      itemBuilder: (context, index) {
        final paper = papers[index];
        return _buildPaperCard(context, paper);
      },
    );
  }

  /// Build a card widget for a single question paper
  Widget _buildPaperCard(BuildContext context, QuestionPaper paper) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject name (main title)
            Row(
              children: [
                Expanded(
                  child: Text(
                    paper.subjectName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Delete button
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () {
                    // Show confirmation dialog before deleting
                    _showDeleteDialog(context, paper);
                  },
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Paper details in a row
            Row(
              children: [
                // Semester badge
                _buildBadge(
                  Icons.calendar_today,
                  paper.semester,
                  Colors.blue,
                ),
                const SizedBox(width: 8),
                // Regulation badge
                _buildBadge(
                  Icons.rule,
                  paper.regulation,
                  Colors.green,
                ),
                const SizedBox(width: 8),
                // Exam type badge
                _buildBadge(
                  Icons.quiz,
                  paper.examType,
                  Colors.orange,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Year and file name
            Row(
              children: [
                Icon(Icons.calendar_month, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  'Year: ${paper.year}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const Spacer(),
                Icon(Icons.picture_as_pdf, size: 16, color: Colors.red[600]),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    paper.fileName,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build a small badge widget with icon and text
  Widget _buildBadge(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Show confirmation dialog before deleting a paper
  void _showDeleteDialog(BuildContext context, QuestionPaper paper) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Paper'),
        content: Text('Are you sure you want to delete "${paper.subjectName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onDelete(paper.id);
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

