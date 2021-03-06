import 'dart:convert';

import 'package:corcon/api/pdf_api.dart';
import 'package:corcon/api/pdf_idcard_api.dart';
import 'package:corcon/screens/scanner_screen.dart';
import 'package:corcon/screens/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_login_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<UserLoginModel> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String regId = prefs.getString("REG_ID")!;
    String userId = prefs.getString("USERID")!;
    String userName = prefs.getString("USERNAME")!;
    String userEmail = prefs.getString("USEREMAIL")!;
    return UserLoginModel(
        userId: userId, userName: userName, regId: regId, email: userEmail);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF0F0F0),
      body: FutureBuilder<UserLoginModel>(
        future: getUserName(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            var jsonData = {
              'username': snapshot.data!.userName,
              'usermail': snapshot.data!.email,
              'regid': snapshot.data!.regId,
              // 'hall1': 1,
              // 'hall2': 1,
              // 'hall3': 1,
              // 'hall4': 1,
              // '14-09-2022': {'T': 1, 'B': 1, 'D': 1},
              // '15-09-2022': {'B': 2, 'T': 2, 'L': 1, 'D': 1},
              // '16-09-2022': {'B': 2, 'T': 2, 'L': 1, 'D': 1},
              // '17-09-2022': {'B': 2, 'T': 2, 'L': 1},
            };
            return Container(
              width: size.width,
              height: size.height,
              padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child:
                                const Icon(Icons.arrow_back_ios_new_outlined),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 30,
                            ),
                            child: const Text(
                              "View Profile",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          final pdfFile =
                              await PdfIdCartApi.generate(context, jsonData);
                          PdfApi.openFile(pdfFile);
                        },
                        child: const Icon(Icons.print),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        snapshot.data!.userName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        snapshot.data!.userId,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        snapshot.data!.regId,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  QrImage(
                    data: jsonData.toString(),
                    size: 200,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const UpdateProfileScreen()));
                        },
                        child: const Text("Edit Profile"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          try {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Scanner()));
                          } catch (e) {
                            e.toString();
                          }
                        },
                        child: const Text("Scan QR"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
