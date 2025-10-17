import 'package:flutter/material.dart';
import 'package:gmsflutter/auth/login_page.dart';
import 'package:gmsflutter/purchase%20pages/save_item.dart';
import 'package:gmsflutter/purchase%20pages/save_vendor.dart';
import 'package:gmsflutter/purchase%20pages/view_half_po.dart';
import 'package:gmsflutter/purchase%20pages/view_inventory.dart';
import 'package:gmsflutter/purchase%20pages/view_item.dart';
import 'package:gmsflutter/purchase%20pages/view_requisition_list.dart';
import 'package:gmsflutter/purchase%20pages/view_vendor_list.dart';
import 'package:gmsflutter/service/auth_service.dart';

class PurchaseManagerProfile extends StatelessWidget {
  final Map<String, dynamic> profile;
  final AuthService _authService = AuthService();

  PurchaseManagerProfile({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String baseUrl = "http://localhost:8080/images/rolePurchaseManager/";
    final String? photoName = profile['photo'];
    final String? photoUrl = (photoName != null && photoName.isNotEmpty)
        ? "$baseUrl$photoName"
        : null;

    final String name = profile['name'] ?? 'Unknown';
    final String email = profile['email'] ?? 'Not Provided'; // ✅ Fixed this line

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Purchase Manager',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 3,
        iconTheme: const IconThemeData(color: Colors.white),
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
                      icon: Icons.add_box,
                      text: "Add Item",
                      onTap: () => _navigate(context, SaveItem())),
                  _buildDrawerItem(
                      icon: Icons.person_add,
                      text: "Add Vendor",
                      onTap: () => _navigate(context, SaveVendor())),
                  const Divider(),
                  _buildDrawerItem(
                      icon: Icons.view_list,
                      text: "View Item",
                      onTap: () => _navigate(context, ViewItem())),
                  _buildDrawerItem(
                      icon: Icons.assignment_turned_in,
                      text: "View PO",
                      onTap: () => _navigate(context, ViewHalfPO())),
                  _buildDrawerItem(
                      icon: Icons.receipt_long,
                      text: "View Requisitions",
                      onTap: () => _navigate(context, ViewRequisitionList())),
                  _buildDrawerItem(
                      icon: Icons.inventory,
                      text: "Inventory",
                      onTap: () => _navigate(context, ViewInventory())),
                  _buildDrawerItem(
                      icon: Icons.people,
                      text: "View Vendor List",
                      onTap: () => _navigate(context, ViewVendorList())),
                  const Divider(),
                  _buildDrawerItem(
                    icon: Icons.logout,
                    text: "Logout",
                    textColor: Colors.redAccent,
                    iconColor: Colors.redAccent,
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
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Center(
              child: Container(
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
                  backgroundColor: Colors.grey[100],
                  backgroundImage: (photoUrl != null)
                      ? NetworkImage(photoUrl)
                      : const AssetImage('assets/default_avatar.png')
                  as ImageProvider,
                ),
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
    Navigator.pop(context); // close drawer
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
