import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/admin_entity/department.dart';
import 'package:gmsflutter/service/admin_service/department_service.dart';

// Helper class for providing different colors based on index or name
class ColorPalette {
  static const List<Color> accentColors = [
    Color(0xFF4FC3F7), // Light Blue
    Color(0xFFAED581), // Light Green
    Color(0xFFFFB74D), // Orange
    Color(0xFFBA68C8), // Purple
    Color(0xFFE57373), // Red
    Color(0xFFFFD54F), // Yellow
  ];

  static Color getColor(int index) {
    return accentColors[index % accentColors.length];
  }
}

class ViewDepartment extends StatefulWidget {
  const ViewDepartment({Key? key}) : super(key: key);

  @override
  State<ViewDepartment> createState() => _ViewDepartmentState();
}

class _ViewDepartmentState extends State<ViewDepartment> {
  late Future<List<Department>> _departmentFuture;

  @override
  void initState() {
    super.initState();
    _departmentFuture = DepartmentService().fetchAllDepartment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Organizational Departments',
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey[700], // Darker, professional AppBar
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Department>>(
        future: _departmentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.blueGrey));
          } else if (snapshot.hasError) {
            // FABULOUS Error State
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.redAccent, size: 40),
                    const SizedBox(height: 10),
                    Text(
                      'Failed to load departments. Please check the service.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red[700], fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          } else {
            final departments = snapshot.data!;

            if (departments.isEmpty) {
              // SMART Empty State
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.business, color: Colors.blueGrey, size: 50),
                    SizedBox(height: 10),
                    Text('No Departments Registered Yet', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  ],
                ),
              );
            }

            // SMART: Use a custom list item builder
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: departments.length,
              itemBuilder: (context, index) {
                final department = departments[index];
                return _buildDepartmentCard(context, department, index);
              },
            );
          }
        },
      ),
    );
  }

  // --- Department Card Builder (Fabulous & Colorful) ---

  Widget _buildDepartmentCard(
      BuildContext context, Department department, int index) {

    // Get a unique color for the card's accent
    final accentColor = ColorPalette.getColor(index);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 6, // Higher elevation for a floating effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: accentColor.withOpacity(0.3), width: 1.5), // Subtle border
      ),
      child: InkWell(
        // Added InkWell for a ripple effect on tap (SMART UX)
        onTap: () {
          // TODO: Implement navigation to department details or employees list
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tapped on ${department.name}')),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Colored Icon (FABULOUS & COLORFUL)
              _buildLeadingIcon(accentColor),
              const SizedBox(width: 16),

              // Department Details (SMART Typography)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      department.name ?? 'Unnamed Department',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: Colors.blueGrey[900],
                        letterSpacing: -0.2, // Tighter spacing for a modern look
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: ${department.id ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Trailing Arrow with Color
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: accentColor, // Arrow uses the accent color
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for the leading icon
  Widget _buildLeadingIcon(Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        Icons.business_center,
        color: accentColor,
        size: 24,
      ),
    );
  }
}