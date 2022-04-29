import 'package:corcon/model/single_row_login_model.dart';
import 'package:corcon/screens/home_screen.dart';
import 'package:corcon/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/common.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isPassVisible = true;

  loginUser(String id, String pwd) async {
    showLoaderDialog(context);
    var url = Uri.parse('${baseUrl}SetUserLogin');
    var response = await http.post(url, body: {'Id': id, 'Pwd': pwd});
    if (response.statusCode == 200) {
      final symposiaModel = singleRowLoginModelFromJson(response.body);
      if (symposiaModel.userDetails.first.sts > 0) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", true);
        prefs.setString("USERID", id);
        prefs.setString("USERNAME", symposiaModel.userDetails.first.name);
        prefs.setString("USEREMAIL", symposiaModel.userDetails.first.email);
        prefs.setString("REG_ID", symposiaModel.userDetails.first.regId);
        prefs.setString("USERPWD", pwd);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      } else {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Some error has occurred"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage(
                    './assets/images/corcon_ogo.png',
                  ),
                  width: 250,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailCtrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "user name should not be empty";
                    }
                    if (value == "") {
                      return "user name should not be empty";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Enter User Name",
                    // border: OutlineInputBorder(
                    //   borderSide: BorderSide(
                    //     width: 0.5,
                    //     color: Colors.black,
                    //   ),
                    // ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passCtrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'password should not be empty';
                    }
                    if (value == "") {
                      return "password should not be empty";
                    }
                    return null;
                  },
                  obscureText: isPassVisible,
                  decoration: InputDecoration(
                    labelText: "Enter Password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPassVisible = !isPassVisible;
                          });
                        },
                        icon: isPassVisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                    // border: const OutlineInputBorder(
                    //   borderSide: BorderSide(
                    //     width: 0.5,
                    //     color: Colors.black,
                    //   ),
                    // ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      loginUser(emailCtrl.text, passCtrl.text);
                    } else {}
                  },
                  child: const Text("Login"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegisterScreen()));
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: const Size.fromHeight(40),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Powered by ICS Intech"),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text("Loading...")),
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
