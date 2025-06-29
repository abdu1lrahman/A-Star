import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/providers/theme_provider.dart';
import 'package:you_are_a_star/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Set<String> selectedInterests = {};
  File? _image;

  void fetchSavedIntrests() async {
    final prefs = await SharedPreferences.getInstance();
    var response = prefs.getStringList('intrests');
    if (response != null) {
      setState(() {
        selectedInterests = response.toSet();
      });
    }
  }

  Future<void> pickImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        prefs.setString('user_image', pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userinfos = Provider.of<UserProvider>(context, listen: true);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).account)),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // The user Image
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
          // The user name
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              userinfos.userName!,
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 245,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: themeProvider.currentAppTheme.fifthColor,
                  width: 4,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: Text(
                      S.of(context).personal_info,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                  ),
                  Divider(
                    color: themeProvider.currentAppTheme.sixthColor,
                    thickness: 3,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.account_box_outlined),
                        const SizedBox(width: 8),
                        Text(
                          S.of(context).username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(userinfos.userName!)
                      ],
                    ),
                  ),
                  Divider(
                    color: themeProvider.currentAppTheme.sixthColor,
                    thickness: 3,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_month_outlined),
                        const SizedBox(width: 8.0),
                        Text(
                          S.of(context).age1,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8.0),
                        Text(userinfos.userAge.toString()),
                      ],
                    ),
                  ),
                  Divider(
                    color: themeProvider.currentAppTheme.sixthColor,
                    thickness: 3,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.theater_comedy_sharp),
                        const SizedBox(width: 8.0),
                        Text(
                          S.of(context).gender1,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          userinfos.userGender == true
                              ? S.of(context).male
                              : S.of(context).female,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: themeProvider.currentAppTheme.sixthColor,
                    thickness: 3,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.interests),
                        const SizedBox(width: 8.0),
                        Text(
                          S.of(context).intrests,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          selectedInterests
                              .toString()
                              .replaceAll('{', '')
                              .replaceAll('}', '')
                              .replaceAll(',', ' .'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.079),
          Text(
            'This app was developed by Abdulrahman',
            style: TextStyle(fontSize: screenWidth * 0.04),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('built with Flutter Framework'),
              const SizedBox(width: 3),
              Image.asset(
                'assets/icons/flutter_icon.png',
                width: 30,
              ),
            ],
          ),
          const Text('All rights reserved 2025'),
        ],
      ),
    );
  }
}
