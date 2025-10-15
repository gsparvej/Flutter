import 'package:flutter/material.dart';
import 'package:gmsflutter/auth/login_page.dart';
import 'package:gmsflutter/production%20pages/line_view_and_save.dart';
import 'package:gmsflutter/production%20pages/machine_view_and_save.dart';
import 'package:gmsflutter/production%20pages/production_summary.dart';
import 'package:gmsflutter/production%20pages/save_cut_bundle.dart';
import 'package:gmsflutter/production%20pages/view_cut_bundle.dart';
import 'package:gmsflutter/production%20pages/view_cutting_plan.dart';
import 'package:gmsflutter/production%20pages/view_day_wise_production.dart';
import 'package:gmsflutter/production%20pages/view_production_order.dart';
import 'package:gmsflutter/service/auth_service.dart';

class ProductionManagerProfile extends StatelessWidget {
  final Map<String, dynamic> profile;
  final AuthService _authService = AuthService();

  // final BuyerService buyerService = BuyerService();

  ProductionManagerProfile({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ----------------------------
    // BASE URL for loading images
    // ----------------------------
    final String baseUrl =
        "http://localhost:8080/images/roleProductionManager/";
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
          'Production Manager Profile',
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
              title: const Text('Add Cut Bundle'),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SaveCutBundle()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Production Summary'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const AllSummaryPage(), // ✅ No orderId passed
                  ),
                );
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Line List'),
              onTap: () async {
                Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => LinePage())
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Machine List'),
              onTap: () async {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => MachinePage())
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Production Orders'),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewProductionOrder(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Day Wise Production'),
              onTap: () async {
                Navigator.push(
                    context,
                MaterialPageRoute(
                    builder: (context) => ViewDayWiseProduction())
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Cutting Plans'),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewCuttingPlan()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Cut Bundle'),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewCutBundle()),
                );
              },
            ),
            const Divider(),

            // 🔴 Logout Option
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.deepOrange),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onTap: () async {
                await _authService.logout();
                Navigator.push(
                  context,
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
                border: Border.all(color: Colors.green, width: 3),
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
