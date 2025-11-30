import 'package:flutter/material.dart';
import 'package:gmsflutter/auth/login_page.dart';
import 'package:gmsflutter/chat_page/chat_page.dart';
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

  ProductionManagerProfile({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String baseUrl = "http://localhost:8080/images/roleProductionManager/";
    final String? photoName = profile['photo'];
    final String? photoUrl = (photoName != null && photoName.isNotEmpty) ? "$baseUrl$photoName" : null;

    final String name = profile['name'] ?? 'Unknown User';
    final String email = profile['email'] ?? 'Not Provided';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Production Manager Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 3,
      ),

      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.deepPurpleAccent],
                ),
              ),
              accountName: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: (photoUrl != null)
                    ? NetworkImage(photoUrl)
                    : const AssetImage('assets/default_avatar.jpg') as ImageProvider,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildDrawerItem(
                    icon: Icons.save,
                    text: 'Add Cut Bundle',
                    onTap: () => _navigate(context, SaveCutBundle()),
                  ),
                  // _buildDrawerItem(
                  //   icon: Icons.analytics,
                  //   text: 'Production Summary',
                  //   onTap: () => _navigate(context, const AllSummaryPage()),
                  // ),
                  const Divider(),
                  _buildDrawerItem(
                    icon: Icons.view_list,
                    text: 'Line List',
                    onTap: () => _navigate(context, LinePage()),
                  ),
                  _buildDrawerItem(
                    icon: Icons.memory,
                    text: 'Machine List',
                    onTap: () => _navigate(context, MachinePage()),
                  ),
                  _buildDrawerItem(
                    icon: Icons.production_quantity_limits,
                    text: 'View Production Orders',
                    onTap: () => _navigate(context, ViewProductionOrder()),
                  ),
                  _buildDrawerItem(
                    icon: Icons.date_range,
                    text: 'View Day Wise Production',
                    onTap: () => _navigate(context, ViewDayWiseProduction()),
                  ),
                  _buildDrawerItem(
                    icon: Icons.content_cut,
                    text: 'View Cutting Plans',
                    onTap: () => _navigate(context, ViewCuttingPlan()),
                  ),
                  _buildDrawerItem(
                    icon: Icons.inventory,
                    text: 'View Cut Bundle',
                    onTap: () => _navigate(context, ViewCutBundle()),
                  ),
                  _buildDrawerItem(
                    icon: Icons.check_circle_outline,
                    text: "Chat Box",
                    onTap: () => _navigate(context, const ChatPage()),
                  ),
                  const Divider(),
                  _buildDrawerItem(
                    icon: Icons.logout,
                    iconColor: Colors.redAccent,
                    text: 'Logout',
                    textColor: Colors.redAccent,
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
            )
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
                border: Border.all(color: Colors.deepPurple, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[200],
                backgroundImage: (photoUrl != null)
                    ? NetworkImage(photoUrl)
                    : const AssetImage('assets/default_avatar.png') as ImageProvider,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.deepPurple),
                      title: Text(
                        name,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email, color: Colors.deepPurple),
                      title: Text(
                        email,
                        style: const TextStyle(fontSize: 16),
                      ),
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

  Widget _buildDrawerItem({
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
          color: textColor ?? Colors.black,
          fontWeight: FontWeight.w500,
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
