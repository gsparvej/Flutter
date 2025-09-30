

 import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:radio_group_v2/radio_group_v2.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState()=> _RegistrationState();
 }

 class _RegistrationState extends State<Registration> {

   bool _obscurePassword= true;

   final TextEditingController name = TextEditingController();
   final TextEditingController email = TextEditingController();
   final TextEditingController password = TextEditingController();

   final TextEditingController confirmPassword = TextEditingController();
   final TextEditingController cell = TextEditingController();
   final TextEditingController address = TextEditingController();



   final RadioGroupController genderController = RadioGroupController();
   final DateTimeFieldPickerPlatform dob = DateTimeFieldPickerPlatform.material;

   String? selectedGender;
   DateTime? selectedDOB;

   final _formKey = GlobalKey<FormState>();





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(
                      height: 20.0
                  ),

                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: "example@gmail.com",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.alternate_email),
                    ),
                  ),
                  SizedBox(
                      height: 20.0
                  ),
                  TextField(
                    obscureText: _obscurePassword,
                    controller: password,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword? Icons.visibility_off : Icons.visibility
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },

                      ),
                    ),
                  ),
                  SizedBox(
                      height: 20.0
                  ),
            TextField(

              controller: confirmPassword,
              decoration: InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
                  SizedBox(
                      height: 20.0
                  ),
                  TextField(
                    controller: cell,
                    decoration: InputDecoration(
                      labelText: "017********",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: address,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.maps_home_work_rounded),
                    ),
                  ),
                  SizedBox(
                      height: 20
                  ),
                  DateTimeFormField(
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth'
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    pickerPlatform: dob,

                    onChanged: (DateTime? value){
                      setState(() {
                        selectedDOB = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // Gender Selection ekhan theke suru korte hbe
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Gender:" ,
                        )
                      ],
                    ),
                    ,
                  )





                ],
              ),
          ),
        ),
      ),


    );
  }

 }
