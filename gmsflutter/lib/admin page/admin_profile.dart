import 'package:flutter/material.dart';
import 'package:gmsflutter/admin%20page/view_attendance.dart';
import 'package:gmsflutter/admin%20page/view_department.dart';
import 'package:gmsflutter/admin%20page/view_designation.dart';
import 'package:gmsflutter/admin%20page/view_employee.dart';
import 'package:gmsflutter/admin%20page/view_leave.dart';
import 'package:gmsflutter/auth/login_page.dart';
import 'package:gmsflutter/service/auth_service.dart';

class AdminProfile extends StatelessWidget {
  final Map<String, dynamic> profile;
  final AuthService _authService = AuthService();

  AdminProfile({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String baseUrl = "http://localhost:8080/images/roleAdmin/";
    final String? photoName = profile['photo'];
    final String? photoUrl = (photoName != null && photoName.isNotEmpty)
        ? "$baseUrl$photoName"
        : null;

    final String name = profile['name'] ?? 'Unknown User';
    final String email = profile['email'] ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Profile',
          style: TextStyle(color: Colors.orangeAccent),
        ),
        backgroundColor: Colors.black12,
        centerTitle: true,
        elevation: 4,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.deepPurpleAccent),
              accountName: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: (photoUrl != null)
                    ? NetworkImage(photoUrl)
                    : const AssetImage('assets/default_avatar.jpg')
                          as ImageProvider,
              ),
            ),

            _buildDrawerItem(
              context,
              icon: Icons.person_add,
              text: 'Add Buyer',
              onTap: () {
                Navigator.pop(context);
                // Add navigation or functionality here if needed
              },
            ),

            const Divider(),

            _buildDrawerItem(
              context,
              icon: Icons.group,
              text: 'View Employee',
              onTap: () => _navigate(context, const ViewEmployee()),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.access_time,
              text: 'View Attendance',
              onTap: () => _navigate(context, const ViewAttendance()),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.beach_access,
              text: 'View Leaves',
              onTap: () => _navigate(context, const ViewLeave()),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.account_tree,
              text: 'View Department',
              onTap: () => _navigate(context, const ViewDepartment()),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.badge,
              text: 'View Designation',
              onTap: () => _navigate(context, const ViewDesignation()),
            ),

            const Divider(),

            _buildDrawerItem(
              context,
              icon: Icons.logout,
              iconColor: Colors.deepOrange,
              text: 'Logout',
              textColor: Colors.deepOrange,
              onTap: () async {
                await _authService.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => Login()),
                );
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 3),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[200],
                backgroundImage: (photoUrl != null)
                    ? NetworkImage(photoUrl)
                    : const AssetImage('assets/default_avatar.png')
                          as ImageProvider,
              ),
            ),
            const SizedBox(height: 20),

            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.green),
                      title: Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email, color: Colors.green),
                      title: Text(email, style: const TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Colors.deepPurple),
      title: Text(
        text,
        style: TextStyle(
          color: textColor ?? Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }

  void _navigate(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}
