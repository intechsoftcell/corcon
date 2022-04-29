import 'dart:math';
import 'package:corcon/model/symposia_data.dart';
import 'package:corcon/model/symposia_model.dart';
import 'package:corcon/model/single_row_model.dart';
import 'package:corcon/screens/login_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/common.dart';

class RegisterSecondScreen extends StatefulWidget {
  String email;
  String mobile;
  String name;
  String username;
  String pass1;
  String pass2;

  RegisterSecondScreen(
      {Key? key,
      required this.name,
      required this.email,
      required this.mobile,
      required this.username,
      required this.pass1,
      required this.pass2})
      : super(key: key);

  @override
  State<RegisterSecondScreen> createState() => _RegisterSecondScreenState();
}

class _RegisterSecondScreenState extends State<RegisterSecondScreen> {
  final dropDownCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isPassVisible1 = true;
  bool isPassVisible2 = true;

  List<SymposiaData> data = [];
  List<String> fetchData = [];

  bool isVisibleList = false;

  List<TextEditingController> titleCtrl1 = [];
  List<TextEditingController> titleCtrl2 = [];
  List<TextEditingController> titleCtrl3 = [];
  String selectedRadio = "";

  Future<void> fetchSymposia() async {
    var url = Uri.parse('${baseUrl}GetSymposiaResult');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      final symposiaModel = symposiaModelFromJson(response.body.toString());
      fetchData.add("Select");
      for (int i = 0; i < symposiaModel.dtqty.length; i++) {
        fetchData.add(symposiaModel.dtqty[i].symposiaName);
      }
    }
  }

  Future<void> finalCorconRefill(String tempId) async {
    for (int i = 0; i < data.length; i++) {
      if (titleCtrl1[i].text.isNotEmpty) {
        insertCorconSymposia(
            tempId, data[i].title, titleCtrl1[i].text.toString());
      }
      if (titleCtrl2[i].text.isNotEmpty) {
        insertCorconSymposia(
            tempId, data[i].title, titleCtrl2[i].text.toString());
      }
      if (titleCtrl3[i].text.isNotEmpty) {
        insertCorconSymposia(
            tempId, data[i].title, titleCtrl3[i].text.toString());
      }
    }
  }

  Future<int> insertCorconSymposia(
      String regId, String symposiaName, String paperTitle) async {
    var url = Uri.parse('${baseUrl}SetSymposiaUserDetails');
    var response = await http.post(url, body: {
      'Reg_Id': regId,
      'SymposiaName': symposiaName,
      'PaperTitle': paperTitle,
    });
    final rowModel = singleRowModelFromJson(response.body);
    return rowModel.first.sts;
  }

  Future<int> registerUser(String regId) async {
    showLoaderDialog(context);
    var url = Uri.parse('${baseUrl}SetRegistration');
    var response = await http.post(url, body: {
      'reg_id': regId,
      'name': widget.name,
      'email': widget.email,
      'mobile': widget.mobile,
      'username': widget.username,
      'password': widget.pass1,
      'presentationType': selectedRadio,
    });
    final rowModel = singleRowModelFromJson(response.body);
    return rowModel.first.sts;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      showLoaderDialog(context);
    });
    fetchSymposia().then((value) => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
                            "Symposia",
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
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    "Type of Presentation",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedRadio = "Oral";
                          });
                        },
                        child: Row(children: [
                          Radio(
                              value: "Oral",
                              groupValue: selectedRadio,
                              onChanged: (e) {
                                setState(() {
                                  selectedRadio = e.toString();
                                });
                              }),
                          const Text("Oral"),
                        ]),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedRadio = "Poster";
                          });
                        },
                        child: Row(
                          children: [
                            Radio(
                                value: "Poster",
                                groupValue: selectedRadio,
                                onChanged: (e) {
                                  setState(() {
                                    selectedRadio = e.toString();
                                  });
                                }),
                            const Text("Poster"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
                const SizedBox(
                  height: 10,
                ),
                DropdownSearch(
                  showSearchBox: true,
                  items: fetchData,
                  dropdownSearchDecoration: const InputDecoration(
                    labelText: "Select Symposia",
                  ),
                  onChanged: (value) {
                    dropDownCtrl.text = value.toString();
                    setState(() {
                      if (value != "Select") {
                        isVisibleList = true;
                        final simpData =
                            SymposiaData(value.toString(), "", "", "");
                        data.add(simpData);
                        fetchData.remove(value);
                      } else {
                        isVisibleList = false;
                        data.clear();
                      }
                    });
                  },
                ),
                Visibility(
                  visible: isVisibleList,
                  child: ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        titleCtrl1.add(TextEditingController());
                        titleCtrl2.add(TextEditingController());
                        titleCtrl3.add(TextEditingController());
                        return Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${index + 1}) ${data[index].title}'),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: titleCtrl1[index],
                                onChanged: (value) {
                                  setState(() {
                                    data[index].data1 = value;
                                  });
                                },
                                textCapitalization:
                                    TextCapitalization.sentences,
                                validator: (value) {
                                  if (value == "") {
                                    return "atleast enter first title";
                                  }
                                  if (value!.isEmpty) {
                                    return "atleast enter first title";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: "Enter Title Of Paper",
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
                                controller: titleCtrl2[index],
                                onChanged: (value) {
                                  setState(() {
                                    data[index].data2 = value;
                                  });
                                },
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: const InputDecoration(
                                  labelText: "Enter Title Of Paper",
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
                                controller: titleCtrl3[index],
                                onChanged: (value) {
                                  setState(() {
                                    data[index].data3 = value;
                                  });
                                },
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: const InputDecoration(
                                  labelText: "Enter Title Of Paper",
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
                              Container(
                                height: 0.5,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Random random = Random();
                      int min = 1000;
                      int max = 9999;
                      int randomNumber = random.nextInt(max - min);
                      String tempId = 'CORCON/2022/22-23/$randomNumber';
                      registerUser(tempId).then((value) {
                        if (value == 1) {
                          if (data.isNotEmpty) {
                            finalCorconRefill(tempId).then((value) {
                              Future.delayed(const Duration(seconds: 5), () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                    (route) => false);
                              });
                            });
                          } else {
                            Future.delayed(const Duration(seconds: 5), () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                  (route) => false);
                            });
                          }
                        } else if (value == 2) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("User present already"),
                            ),
                          );
                        } else if (value == 0) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Some error has occurred"),
                            ),
                          );
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Validation error"),
                        ),
                      );
                    }
                  },
                  child: const Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
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
