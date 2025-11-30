import 'package:flutter/material.dart';
import 'package:gmsflutter/auth/login_page.dart';
import 'package:gmsflutter/chat_page/chat_page.dart';
import 'package:gmsflutter/merchandiser%20page/save_buyer.dart';
import 'package:gmsflutter/merchandiser%20page/view_bom_style.dart';
import 'package:gmsflutter/merchandiser%20page/view_buyer.dart';
import 'package:gmsflutter/merchandiser%20page/view_half_order.dart';
import 'package:gmsflutter/merchandiser%20page/view_raw_materials_check.dart';
import 'package:gmsflutter/merchandiser%20page/view_uom.dart';
import 'package:gmsflutter/service/auth_service.dart';

class MerchandiserProfile extends StatelessWidget {
  final Map<String, dynamic> profile;
  final AuthService _authService = AuthService();

  MerchandiserProfile({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String baseUrl =
        "http://localhost:8080/images/roleMerchandiserManager/";
    final String? photoName = profile['photo'];
    final String? photoUrl =
    (photoName != null && photoName.isNotEmpty) ? "$baseUrl$photoName" : null;

    final String name = profile['name'] ?? 'Unknown';
    final String email = profile['email'] ?? 'Not Provided';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Merchandiser Profile',
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
                    : const AssetImage('assets/default_avatar.jpg')
                as ImageProvider,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildDrawerItem(
                      icon: Icons.person_add,
                      text: "Add Buyer",
                      onTap: () {
                        Navigator.push(
                            context, 
                        MaterialPageRoute(builder: (context) => SaveBuyer()));
                        // Add your navigation logic for "Add Buyer"
                      }),
                  const Divider(),
                  _buildDrawerItem(
                      icon: Icons.person,
                      text: "View Buyer",
                      onTap: () => _navigate(context, ViewBuyer())),
                  _buildDrawerItem(
                      icon: Icons.accessibility_new,
                      text: "View UOM",
                      onTap: () => _navigate(context, ViewUom())),
                  _buildDrawerItem(
                      icon: Icons.style,
                      text: "View BOM Style",
                      onTap: () => _navigate(context, ViewBomStyle())),
                  _buildDrawerItem(
                      icon: Icons.list_alt,
                      text: "View Half Order",
                      onTap: () => _navigate(context, ViewHalfOrder())),
                  _buildDrawerItem(
                      icon: Icons.check_circle_outline,
                      text: "Raw Materials Check",
                      onTap: () => _navigate(context, ViewRawMaterialsCheck())),
                  _buildDrawerItem(
                    icon: Icons.chat_bubble_outline,
                    text: "Chat Box",
                    onTap: () => _navigate(context, const ChatPage()),
                  ),

                  const Divider(),
                  _buildDrawerItem(
                    icon: Icons.logout,
                    text: "Logout",
                    iconColor: Colors.redAccent,
                    textColor: Colors.redAccent,
                    onTap: () async {
                      await _authService.logout();
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) =>  Login()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.deepPurple, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
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
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.deepPurple),
                      title: Text(
                        name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
    Navigator.pop(context); // Close the drawer
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
