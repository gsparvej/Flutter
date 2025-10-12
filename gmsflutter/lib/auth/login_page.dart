
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gmsflutter/admin%20page/admin_profile.dart';
import 'package:gmsflutter/merchandiser%20page/merchandiser_profile.dart';
import 'package:gmsflutter/purchase%20pages/purchase_manager_profile.dart';
import 'package:gmsflutter/service/auth_service.dart';
import 'package:gmsflutter/service/merchandiser_service/merchandiser_profile_service.dart';
import 'package:gmsflutter/service/purchase_service/purchase_manager_profile_service.dart';


class Login extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool _obscurePassword = true;

  final storage = new FlutterSecureStorage();
  AuthService authService = AuthService();
  MerchandiserManagerService merchandiserManagerService =
  MerchandiserManagerService();
  PurchaseManagerService purchaseManagerService = PurchaseManagerService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.00),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(
                labelText: "example@gamil.com",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_rounded),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: password,
              decoration: InputDecoration(
                labelText: "password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.password),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                loginUser(context);
              },
              child: Text(
                "Login",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w800),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                foregroundColor: Colors.orangeAccent,
              ),
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }

  Future<void> loginUser(BuildContext context) async {
    try {
      final response = await authService.login(email.text, password.text);

      // Successful login , role-based navigation
      final role = await authService.getUserRole();
      if (role == 'ADMIN') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminProfile()),
        );
      } else if (role == 'MERCHANDISERMANAGER') {
        final profile = await merchandiserManagerService
            .getMerchandiserManagerProfile();
        if(profile != null){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MerchandiserProfile(profile: profile),
            ),
          );

        } else {
          print('Unknown role: $role');
        }

      }
      else if (role == 'PURCHASEMANAGER') {
        final profile = await purchaseManagerService
            .getPurchaseManagerProfile();
        if(profile != null){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PurchaseManagerProfile(profile: profile),
            ),
          );

        } else {
          print('Unknown role: $role');
        }

      }



    }

    catch (error) {
      print('Login Failed: $error');
    }
  }
}