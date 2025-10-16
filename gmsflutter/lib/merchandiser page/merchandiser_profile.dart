

import 'package:flutter/material.dart';
import 'package:gmsflutter/auth/login_page.dart';
import 'package:gmsflutter/merchandiser%20page/view_bom_style.dart';
import 'package:gmsflutter/merchandiser%20page/view_buyer.dart';
import 'package:gmsflutter/merchandiser%20page/view_half_order.dart';
import 'package:gmsflutter/merchandiser%20page/view_raw_materials_check.dart';
import 'package:gmsflutter/merchandiser%20page/view_uom.dart';
import 'package:gmsflutter/service/auth_service.dart';


class MerchandiserProfile extends StatelessWidget {
  final Map<String, dynamic> profile;
  final AuthService _authService = AuthService();
  // final BuyerService buyerService = BuyerService();

  MerchandiserProfile({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ----------------------------
    // BASE URL for loading images
    // ----------------------------
    final String baseUrl =
        "http://localhost:8080/images/roleMerchandiserManager/";
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
          'Merchandiser Profile',
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
              title: const Text('View Buyer'),
              onTap: () async{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewBuyer(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View UOM'),
              onTap: () async{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewUom(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View BOM Style'),
              onTap: () async{
                Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => ViewBomStyle()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Half Order'),
              onTap: () async{
                Navigator.push(
                  context, 
                MaterialPageRoute(builder: (context) => ViewHalfOrder()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Raw Materials Check'),
              onTap: () async{
                Navigator.push(
                  context, 
                MaterialPageRoute(builder: (context) => ViewRawMaterialsCheck())
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