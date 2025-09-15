import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/presentation/widgets/animated_numbers.dart';
import 'package:you_are_a_star/presentation/widgets/custom_dialog.dart';
import 'package:you_are_a_star/providers/user_provider.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController =
      TextEditingController(text: UserProvider().userName);
  final TextEditingController _ageController =
      TextEditingController(text: UserProvider().userAge.toString());
  final TextEditingController _genderController =
      TextEditingController(text: UserProvider().userGender == true ? "Male" : "Female");

  @override
  void didChangeDependencies() {
    UserProvider().loadImage();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final userinfos = Provider.of<UserProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).account),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Top rounded container
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        height: screenHeight * 0.14,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                    ),

                    // Profile circle avatar, overlapping bottom center
                    Positioned(
                      bottom: -50, // Half the avatar's height to overlap
                      left: 0,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            debugPrint("HELOOWORLD++++++++++++++++");
                            userinfos.pickImage();
                          },
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 4,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 60.0,
                                  child: ClipOval(
                                    child: userinfos.getUserAvatar(),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 2,
                                right: 2,
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 55),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    // initialValue: userinfos.userName,
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(S.of(context).name1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                            onPressed: () {
                              Navigator.of(context).pop();
                              userinfos.changeName(value);
                              Fluttertoast.showToast(msg: "Name Changed succesfully");
                            },
                            title: Text(S.of(context).change_name),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                  child: TextFormField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(S.of(context).age1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                            onPressed: () {
                              Navigator.of(context).pop();
                              userinfos.changeAge(int.parse(value));
                              Fluttertoast.showToast(msg: "Age Changed Succesfully");
                            },
                            title: Text(S.of(context).change_age),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                  child: TextFormField(
                    controller: _genderController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(S.of(context).gender1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Status",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary.computeLuminance() > 0.5
                                  ? Colors.grey[800]
                                  : Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Quotes count",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary.computeLuminance() >
                                                0.5
                                            ? Colors.grey[800]
                                            : Colors.white,
                                  ),
                                ),
                                AnimatedCounter(
                                  targetCount: userinfos.quotesCount,
                                  duration: Duration(milliseconds: 1500),
                                ),
                              ],
                            ),
                            const SizedBox(width: 40),
                            Column(
                              children: [
                                Text(
                                  "Messages count",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary.computeLuminance() >
                                                0.5
                                            ? Colors.grey[800]
                                            : Colors.white,
                                  ),
                                ),
                                AnimatedCounter(
                                  targetCount: userinfos.messagesCount,
                                  duration: Duration(milliseconds: 2000),
                                ),
                              ],
                            )
                          ],
                        ),
                        Text(
                          S.of(context).this_app_was_developed,
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Theme.of(context).colorScheme.primary.computeLuminance() > 0.5
                                ? Colors.grey[800]
                                : Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          S.of(context).rights,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary.computeLuminance() > 0.5
                                ? Colors.grey[800]
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
