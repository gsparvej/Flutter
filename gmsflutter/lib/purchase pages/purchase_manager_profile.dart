

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
  // final BuyerService buyerService = BuyerService();

  PurchaseManagerProfile({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ----------------------------
    // BASE URL for loading images
    // ----------------------------
    final String baseUrl =
        "http://localhost:8080/images/rolePurchaseManager/";
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
          'Purchase Manager Profile',
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
              title: const Text('Add Item'),
              onTap: () async{
                Navigator.push(
                    context,
                MaterialPageRoute(
                    builder: (context) => SaveItem())
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Add Vendor'),
              onTap: () async{
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SaveVendor())
                );
              },
            ),

            const Divider(),


            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Item'),
              onTap: () async{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewItem(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View PO'),
              onTap: () async{
                Navigator.push(
                    context,
                MaterialPageRoute(
                    builder: (context) => ViewHalfPO())
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Requisitions'),
              onTap: () async{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewRequisitionList(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Inventory'),
              onTap: () async{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewInventory(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Vendor List'),
              onTap: () async{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewVendorList(),
                  ),
                );
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