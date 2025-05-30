import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/presentation/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    final userinfos = Provider.of<UserProvider>(context, listen: true);
    // final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController nameController = TextEditingController(text: userinfos.userName);
    TextEditingController ageController = TextEditingController(text: userinfos.userAge.toString());

    File? _image;

    Future<void> pickImage() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          prefs.setString('user_image', pickedFile.path);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).account)),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: InkWell(
              onTap: pickImage,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 60.0,
                child: ClipOval(
                  child: userinfos.getUserAvatar(),
                ),
              ),
            ),
          ),
          if (_image != null)
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('user_image', '');
                setState(() {
                  _image = null;
                });
              },
              child: const Text(
                'remove image',
                style: TextStyle(color: Colors.red),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              textAlign: TextAlign.center,
              textCapitalization: TextCapitalization.characters,
              controller: nameController,
              decoration: InputDecoration(
                prefixIcon: Image.asset(
                  'assets/icons/name_icon.png',
                  width: 40,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 14.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                      prefixIcon: Image.asset(
                        'assets/icons/age_icon.png',
                        width: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14.0),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: double.infinity,
                    height: 56,
                    child: userinfos.userGender == true
                        ? Image.asset('assets/icons/male_icon.png')
                        : Image.asset('assets/icons/female_icon.png'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
