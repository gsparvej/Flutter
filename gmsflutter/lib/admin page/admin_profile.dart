

import 'package:flutter/material.dart';
import 'package:gmsflutter/admin%20page/view_attendance.dart';
import 'package:gmsflutter/admin%20page/view_department.dart';
import 'package:gmsflutter/admin%20page/view_designation.dart';
import 'package:gmsflutter/admin%20page/view_employee.dart';
import 'package:gmsflutter/admin%20page/view_leave.dart';
import 'package:gmsflutter/auth/login_page.dart';
import 'package:gmsflutter/merchandiser%20page/view_buyer.dart';
import 'package:gmsflutter/merchandiser%20page/view_uom.dart';
import 'package:gmsflutter/service/auth_service.dart';


class AdminProfile extends StatelessWidget {
  final Map<String, dynamic> profile;
  final AuthService _authService = AuthService();
  // final BuyerService buyerService = BuyerService();

  AdminProfile({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ----------------------------
    // BASE URL for loading images
    // ----------------------------
    final String baseUrl =
        "http://localhost:8080/images/roleAdmin/";
    final String? photoName = profile['photo'];
    final String? photoUrl = (photoName != null && photoName.isNotEmpty)
        ? "$baseUrl$photoName"
        : null;

    // ----------------------------
    // SCAFFOLD: Main screen layout
    // ----------------------------

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

      // ----------------------------
      // DRAWER: Side navigation menu
      // ----------------------------
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // 🟣 Drawer Header with user info
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.deepPurpleAccent),
              accountName: Text(
                profile['name'] ?? 'Unknown User',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(profile['user']?['email'] ?? 'N/A'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: (photoUrl != null)
                    ? NetworkImage(photoUrl)
                    : const AssetImage('assets/default_avatar.jpg')
                as ImageProvider,
              ),
            ),
            // 🟣 Menu Items (you can add more later)
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Add Buyer'),
              onTap: () async{
                Navigator.pop(context);
              },
            ),

            const Divider(),



            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Employee'),
              onTap: () async{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewEmployee(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Attendance'),
              onTap: () async{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewAttendance(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Leaves'),
              onTap: () async{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewLeave(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Department'),
              onTap: () async{
                Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => ViewDepartment())
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Designation'),
              onTap: () async{
                Navigator.push(
                  context, 
                MaterialPageRoute(builder: (context) => ViewDesignation()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Raw Materials Check'),
              onTap: () async{
                Navigator.pop(context);
              },
            ),


            const Divider(),

            // 🔴 Logout Option
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.deepOrange),
              title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.deepOrange)
              ),
              onTap: () async {
                await _authService.logout();
                Navigator.push(context,
                  MaterialPageRoute(builder: (_) => Login()),
                );
              },


            ),



          ],
        ),
      ),

      // ----------------------------
      // BODY: Main content area
      // ----------------------------

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: Colors.green,
                  width: 3,
                ),
              ),
              child: CircleAvatar(
                radius: 60, // image size
                backgroundColor: Colors.grey[200],
                backgroundImage: (photoUrl != null)
                    ? NetworkImage(photoUrl) // from backend
                    : const AssetImage('assets/default_avatar.png')
                as ImageProvider,
              ),
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}