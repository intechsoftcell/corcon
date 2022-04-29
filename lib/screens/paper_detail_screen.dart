import 'package:corcon/model/single_row_model.dart';
import 'package:corcon/screens/opportunity_second_screen.dart';
import 'package:corcon/utils/common.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaperDetailScreen extends StatefulWidget {
  Map<String, String> data;
  PaperDetailScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<PaperDetailScreen> createState() => _PaperDetailScreenState();
}

class _PaperDetailScreenState extends State<PaperDetailScreen> {
  final organizationNameCtrl = TextEditingController();
  final personNameCtrl = TextEditingController();
  final personMobileCtrl = TextEditingController();
  final personEmailCtrl = TextEditingController();
  final orgAdressCtrl = TextEditingController();
  final orgMobileCtrl = TextEditingController();
  final orgEmailCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<int> checkUsername() async {
    var url = Uri.parse('${baseUrl}CheckUsername');
    var response =
        await http.post(url, body: {"username": personEmailCtrl.text});
    return singleRowModelFromJson(response.body.toString()).first.sts;
  }

  String selectedAccomodation = "";

  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          child: const Icon(Icons.arrow_back_ios_new_outlined),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 30,
                          ),
                          child: SizedBox(
                            width: size.width * 0.6,
                            child: Text(
                              '${widget.data['category']}',
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
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
                  height: 20,
                ),
                const Text('Personal Details:-'),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: personNameCtrl,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: "Name of Head",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter name of head";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: personMobileCtrl,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelText: "Mobile No.",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter mobile number";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: personEmailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email Address",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  onChanged: (e) async {
                    checkUsername().then((value1) {
                      if (value1 == 1) {
                        showErrorMessage(
                          context,
                          personEmailCtrl,
                          "Taken already",
                          "Please try another email id",
                        );
                      }
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Organization Details:-'),
                const SizedBox(
                  height: 20,
                ),
                // TextFormField(
                //   controller: orgAdressCtrl,
                //   keyboardType: TextInputType.streetAddress,
                //   decoration: const InputDecoration(
                //     labelText: "Address",
                //     border: OutlineInputBorder(
                //       borderSide: BorderSide(
                //         width: 0.5,
                //         color: Colors.black,
                //       ),
                //     ),
                //   ),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return "Please enter address";
                //     }
                //     return null;
                //   },
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                TextFormField(
                  controller: orgMobileCtrl,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelText: "Mobile No.",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter mobile number";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: orgEmailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email Address",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownSearch<dynamic>(
                  selectedItem: "Select",
                  dropdownSearchDecoration: const InputDecoration(
                    labelText: "Select Symposia",
                  ),
                  onChanged: (e) {
                    setState(() {
                      selectedAccomodation = e.toString();
                    });
                  },
                  showSearchBox: true,
                  items: const [
                    "Without Accomodation",
                    "Single Sharing",
                    "Double Sharing",
                    "Triple Sharing"
                  ],
                  validator: (value) {
                    if (value == 'Select') {
                      return "Please select accomodation type";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                // TextFormField(
                //   controller: usernameCtrl,
                //   keyboardType: TextInputType.emailAddress,
                //   decoration: const InputDecoration(
                //     labelText: "Username",
                //     border: OutlineInputBorder(
                //       borderSide: BorderSide(
                //         width: 0.5,
                //         color: Colors.black,
                //       ),
                //     ),
                //   ),
                //   onChanged: (e) {
                //     checkUsername().then((value1) {
                //       if (value1 == 1) {
                //         showErrorMessage(
                //           context,
                //           usernameCtrl,
                //           "Username Taken Already",
                //           "The username is taken already, please try and insert other username.",
                //         );
                //       }
                //     });
                //   },
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return "Please enter username";
                //     }
                //     return null;
                //   },
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // TextFormField(
                //   controller: passwordCtrl,
                //   keyboardType: TextInputType.emailAddress,
                //   obscureText: isObscureText,
                //   decoration: InputDecoration(
                //     labelText: "Password",
                //     suffixIcon: IconButton(
                //       onPressed: () {
                //         setState(() {
                //           if (isObscureText) {
                //             isObscureText = false;
                //           } else {
                //             isObscureText = true;
                //           }
                //         });
                //       },
                //       icon: isObscureText
                //           ? const Icon(Icons.visibility_off)
                //           : const Icon(Icons.visibility),
                //     ),
                //     border: const OutlineInputBorder(
                //       borderSide: BorderSide(
                //         width: 0.5,
                //         color: Colors.black,
                //       ),
                //     ),
                //   ),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return "Please enter password";
                //     }
                //     return null;
                //   },
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => OpportunitySecondScreen(
                              supportName: widget.data,
                              personName: personNameCtrl.text,
                              personMobile: personMobileCtrl.text,
                              personEmail: personEmailCtrl.text,
                              orgMobile: orgMobileCtrl.text,
                              orgEmail: orgEmailCtrl.text,
                              accomodationType: selectedAccomodation),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff152238),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
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
}
