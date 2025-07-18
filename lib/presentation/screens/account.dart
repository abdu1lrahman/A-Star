import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/presentation/screens/intrests.dart';
import 'package:you_are_a_star/providers/prefs.dart';
import 'package:you_are_a_star/providers/user_provider.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Set<String> selectedInterests = {};

  void fetchSavedIntrests() async {
    var response = Prefs.prefs.getStringList('intrests');
    if (response != null) {
      setState(() {
        selectedInterests = response.toSet();
      });
    }
  }

  @override
  void initState() {
    fetchSavedIntrests();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).loadImage();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    fetchSavedIntrests();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final userinfos = Provider.of<UserProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).account)),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              // The user Image
              Center(
                child: InkWell(
                  onTap: userinfos.pickImage,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60.0,
                    child: ClipOval(
                      child: userinfos.getUserAvatar(),
                    ),
                  ),
                ),
              ),
              if (userinfos.image != null)
                TextButton(
                  onPressed: () async {
                    userinfos.removeImage();
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
                  height: 255,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xff9D8189),
                      width: 4,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 8.0),
                        child: Text(
                          S.of(context).personal_info,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                      ),
                      const Divider(
                        color: Color(0xffb4919b),
                        thickness: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.account_circle,
                                color: Colors.black),
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
                      const Divider(
                        color: Color(0xffb4919b),
                        thickness: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_month,
                                color: Colors.black),
                            const SizedBox(width: 8.0),
                            Text(
                              S.of(context).age1,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8.0),
                            Text(userinfos.userAge.toString()),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Color(0xffb4919b),
                        thickness: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.theater_comedy_sharp,
                                color: Colors.black),
                            const SizedBox(width: 8.0),
                            Text(
                              S.of(context).gender1,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
                      const Divider(
                        color: Color(0xffb4919b),
                        thickness: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.interests, color: Colors.black),
                            const SizedBox(width: 8.0),
                            Text(
                              S.of(context).intrests,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8.0),
                            Flexible(
                              child: Text(
                                selectedInterests
                                    .map(
                                      (e) => S.of(context).getInterestLabel(e),
                                    )
                                    .join(' · '),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
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
                S.of(context).this_app_was_developed,
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).built_with),
                  const SizedBox(width: 3),
                  Image.asset(
                    'assets/icons/flutter_icon.png',
                    width: 30,
                  ),
                ],
              ),
              Text(S.of(context).rights),
            ],
          ),
        ],
      ),
    );
  }
}
