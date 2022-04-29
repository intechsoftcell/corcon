import 'package:corcon/model/single_row_model.dart';
import 'package:corcon/screens/register_second_screen.dart';
import 'package:corcon/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameCtrl = TextEditingController();
  final username1Ctrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final pass2Ctrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isPassVisible1 = true;
  bool isPassVisible2 = true;

  @override
  void dispose() {
    super.dispose();
    usernameCtrl.dispose();
    username1Ctrl.dispose();
    emailCtrl.dispose();
    mobileCtrl.dispose();
    passCtrl.dispose();
    pass2Ctrl.dispose();
  }

  Future<int> checkEmail() async {
    var url = Uri.parse('${baseUrl}CheckEmail');
    var response = await http.post(url, body: {"email": emailCtrl.text});
    return singleRowModelFromJson(response.body.toString()).first.sts;
  }

  Future<int> checkUsername() async {
    var url = Uri.parse('${baseUrl}CheckUsername');
    var response = await http.post(url, body: {"username": username1Ctrl.text});
    return singleRowModelFromJson(response.body.toString()).first.sts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            "Register",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.help),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // const Image(
                //   image: AssetImage(
                //     './assets/images/corcon_ogo.png',
                //   ),
                //   width: 150,
                // ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: usernameCtrl,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
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
                    labelText: "Enter Full Name",
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
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "email should not be empty";
                    }
                    if (value == "") {
                      return "email should not be empty";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    checkEmail().then((value1) {
                      if (value1 == 1) {
                        showErrorMessage(
                            context,
                            emailCtrl,
                            "Email Taken Already",
                            "The email is taken already, please try and insert other email.");
                      }
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Enter Email",
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
                  controller: mobileCtrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "mobile number should not be empty";
                    }
                    if (value.length < 10) {
                      return "mobile number should 10 digits";
                    }
                    if (value == "") {
                      return "mobile number should not be empty";
                    }
                    return null;
                  },
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Enter Mobile Number",
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
                  controller: username1Ctrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "username should not be empty";
                    }
                    if (value == "") {
                      return "username should not be empty";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    checkUsername().then((value1) {
                      if (value1 == 1) {
                        showErrorMessage(
                            context,
                            username1Ctrl,
                            "Username Taken Already",
                            "The username is taken already, please try and insert other username.");
                      }
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Enter Username",
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
                  controller: passCtrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'password should not be empty';
                    }
                    if (value.length < 6) {
                      return 'length should not be less than 6';
                    }
                    if (value == "") {
                      return "password should not be empty";
                    }
                    return null;
                  },
                  obscureText: isPassVisible1,
                  decoration: InputDecoration(
                    labelText: "Enter Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPassVisible1 = !isPassVisible1;
                        });
                      },
                      icon: isPassVisible1
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    border: const OutlineInputBorder(
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'confirm password should not be empty';
                    }
                    if (value.length < 6) {
                      return 'length should not be less than 6';
                    }
                    if (value == "") {
                      return "confirm password should not be empty";
                    }
                    return null;
                  },
                  obscureText: isPassVisible2,
                  decoration: InputDecoration(
                    labelText: "Re-enter Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPassVisible2 = !isPassVisible2;
                        });
                      },
                      icon: isPassVisible2
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    border: const OutlineInputBorder(
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
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (passCtrl.text == pass2Ctrl.text) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterSecondScreen(
                                    name: usernameCtrl.text.toString(),
                                    email: emailCtrl.text.toString(),
                                    mobile: mobileCtrl.text.toString(),
                                    username: username1Ctrl.text.toString(),
                                    pass1: passCtrl.text.toString(),
                                    pass2: pass2Ctrl.text.toString())));
                      } else {
                        showAlertLogoutDialog(context);
                      }
                    } else {}
                  },
                  child: const Text("Next"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Already a user? Click Here."),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showErrorMessage(BuildContext context, TextEditingController controller,
      String errorTitle, String errorMessage) {
    Widget okButton = TextButton(
      child: const Text("Okay"),
      onPressed: () async {
        controller.text = "";
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(errorTitle),
      content: Text(errorMessage),
      actions: [okButton],
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
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
