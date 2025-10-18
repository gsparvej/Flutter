import 'package:flutter/material.dart';
import 'package:gmsflutter/entity/admin_entity/designation.dart';
import 'package:gmsflutter/service/admin_service/designation_service.dart';

// Helper class for providing a consistent color scheme
class ColorPalette {
  static const List<Color> accentColors = [
    Color(0xFF64B5F6), // Light Blue
    Color(0xFF81C784), // Light Green
    Color(0xFFFF8A65), // Light Orange/Coral
    Color(0xFFBA68C8), // Purple
  ];

  static Color getColor(int index) {
    return accentColors[index % accentColors.length];
  }

  static const Color primaryText = Color(0xFF212121);
  static const Color secondaryText = Color(0xFF757575);
}

class ViewDesignation extends StatefulWidget {
  const ViewDesignation({Key? key}) : super(key: key);

  @override
  State<ViewDesignation> createState() => _ViewDesignationState();
}

class _ViewDesignationState extends State<ViewDesignation> {
  late Future<List<Designation>> _designationFuture;

  @override
  void initState() {
    super.initState();
    // Renamed for clarity
    _designationFuture = DesignationService().fetchAllDesignationt();
  }

  // --- Widget Builders ---

  Widget _buildDesignationCard(BuildContext context, Designation designation, int index) {
    final accentColor = ColorPalette.getColor(index);
    final departmentName = designation.department?.name ?? 'No Department Assigned';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 5, // Enhanced elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: accentColor.withOpacity(0.4), width: 1.0),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Implement navigation to edit/view details
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tapped on ${designation.designationTitle}')),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Leading Icon Container (Colorful Accent)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.work_outline, // Relevant icon
                  color: accentColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),

              // Details (Smart Typography)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Designation Title (Bold, Primary Focus)
                    Text(
                      designation.designationTitle ?? 'Untitled Designation',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: ColorPalette.primaryText,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Department Subtitle (Secondary Focus)
                    Text(
                      'Dept: $departmentName',
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorPalette.secondaryText,
                        fontStyle: departmentName == 'No Department Assigned' ? FontStyle.italic : null,
                      ),
                    ),
                  ],
                ),
              ),

              // Trailing Arrow (Subtle)
              const Icon(
                Icons.chevron_right,
                size: 24,
                color: ColorPalette.secondaryText,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Main Build Method ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Organizational Designations',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF37474F), // Dark AppBar color
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Designation>>(
        future: _designationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF37474F)));
          }

          if (snapshot.hasError) {
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
                      'Failed to load designations: ${snapshot.error.toString().split(':')[0]}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red[700], fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          }

          final designations = snapshot.data!;

          if (designations.isEmpty) {
            // SMART Empty State
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.business_center_outlined, color: Colors.blueGrey, size: 50),
                  SizedBox(height: 10),
                  Text('No Designations Found.', style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            );
          }

          // SMART: Use ListView with enhanced cards
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: designations.length,
            itemBuilder: (context, index) {
              return _buildDesignationCard(context, designations[index], index);
            },
          );
        },
      ),
    );
  }
}