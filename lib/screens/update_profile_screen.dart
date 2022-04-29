import 'package:corcon/model/single_row_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/common.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final regIdCtrl = TextEditingController();
  final userEmailCtrl = TextEditingController();
  final userNameCtrl = TextEditingController();
  final userIdCtrl = TextEditingController();
  final pass1Ctrl = TextEditingController();
  final pass2Ctrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<int> updateUserProfile() async {
    var url = Uri.parse('${baseUrl}UpdateProfile');
    var response = await http.post(url, body: {
      'regId': regIdCtrl.text.toString(),
      'username': userNameCtrl.text.toString(),
      'userid': userIdCtrl.text.toString(),
      'email': userEmailCtrl.text.toString(),
      'password': pass2Ctrl.text.toString(),
    });

    final singleRowData = singleRowModelFromJson(response.body);
    return singleRowData.first.sts;
  }

  Future<void> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String regId = prefs.getString("REG_ID")!;
    String userId = prefs.getString("USERID")!;
    String userName = prefs.getString("USERNAME")!;
    String userEmail = prefs.getString("USEREMAIL")!;
    String userPassword = prefs.getString("USERPWD")!;
    // final userProfileModel = UserProfileModel(
    //     regId: regId,
    //     userName: userName,
    //     userId: userId,
    //     email: userEmail,
    //     password1: userPassword,
    //     password2: userPassword);
    regIdCtrl.text = regId;
    userEmailCtrl.text = userEmail;
    userIdCtrl.text = userId;
    userNameCtrl.text = userName;
    pass1Ctrl.text = userPassword;
    pass2Ctrl.text = userPassword;
  }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back_ios_new_outlined),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 30,
                      ),
                      child: const Text(
                        "Update Profile",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: regIdCtrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Reg Id should not be empty';
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    enabled: false,
                    labelText: "Corcon ID",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: userNameCtrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Full name should not be empty';
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: userEmailCtrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email should not be empty';
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "User Email",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: userIdCtrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'User Id should not be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "User ID",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: pass1Ctrl,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password should not be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Enter password",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: pass2Ctrl,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password should not be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Re-Enter password",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (pass1Ctrl.text == pass2Ctrl.text) {
                        showLoaderDialog(context);
                        updateUserProfile().then((value) async {
                          if (value > 0) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString("USERID", userIdCtrl.text);
                            prefs.setString("USERNAME", userNameCtrl.text);
                            prefs.setString("USEREMAIL", userEmailCtrl.text);
                            prefs.setString("REG_ID", regIdCtrl.text);
                            prefs.setString("USERPWD", pass1Ctrl.text);
                            Navigator.of(context).pop();
                            await EasyLoading.showSuccess(
                                "User profile updated successfully");
                          } else {
                            await EasyLoading.showError(
                                "Failed to update profile");
                            Navigator.of(context).pop();
                          }
                        });
                      } else {
                        showAlertLogoutDialog(context);
                      }
                    }
                  },
                  child: const Center(
                    child: Text(
                      "Update Profile",
                      style: TextStyle(
                        color: Colors.white,
                      ),
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

  showAlertLogoutDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("Okay"),
      onPressed: () async {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Password Error"),
      content: const Text("Both the passwords are not similar."),
      actions: [okButton],
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text("Please wait...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
