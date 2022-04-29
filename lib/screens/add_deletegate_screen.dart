import 'dart:io';

import 'package:corcon/screens/add_room_screen.dart';
import 'package:corcon/screens/opportunity_second_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddDelegateModel {
  String name, email, mobile, admin, image;
  AddDelegateModel({
    required this.name,
    required this.email,
    required this.mobile,
    required this.admin,
    required this.image,
  });
}

class AddDelegateScreen extends StatefulWidget {
  Map<String, String> data;
  List<SymposiaUserDetails> userDetails;
  List booth;
  AddDelegateScreen(
      {Key? key,
      required this.data,
      required this.booth,
      required this.userDetails})
      : super(key: key);

  @override
  State<AddDelegateScreen> createState() => _AddDelegateScreenState();
}

class _AddDelegateScreenState extends State<AddDelegateScreen> {
  List<String> mListNew = [];
  List<String> nameList = [];
  List<String> emailList = [];
  List<String> mobileList = [];
  List<String> imageList = [];
  List<TextEditingController> nameCtrl = [];
  List<TextEditingController> mobileCtrl = [];
  List<TextEditingController> emailCtrl = [];
  Future<void> getDelegateModel() async {
    for (int i = 0; i < int.parse(widget.data['count'].toString()); i++) {
      mListNew.add("NULL");
      nameList.add("NULL");
      emailList.add("NULL");
      mobileList.add("NULL");
      imageList.add("NULL");
    }
    // DelegateModel delegateModel = DelegateModel(
    //     category: widget.data['category'].toString(),
    //     benefits: widget.data['benefits'].toString(),
    //     withoutAcc: widget.data['withoutAccomodation'].toString(),
    //     triple: widget.data['tripleAccomodation'].toString(),
    //     double: widget.data['doubleAccomodation'].toString(),
    //     single: widget.data['singleAccomodation'].toString(),
    //     rateUsd: widget.data['rateUSD'].toString(),
    //     count: widget.data['count'].toString());
    // return delegateModel;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getDelegateModel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Padding(
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
                          child: const Icon(Icons.arrow_back_ios_new_outlined),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 30,
                          ),
                          child: SizedBox(
                            width: size.width * 0.6,
                            child: const Text(
                              'Delegates Details',
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
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
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text('Number of Delegates: ${widget.data['count']}'),
                SizedBox(
                  // height: size.height,
                  width: size.width,
                  child: ListView.builder(
                    itemCount: mListNew.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.black, width: 1),
                            bottom: BorderSide(color: Colors.black, width: 1),
                            left: BorderSide(color: Colors.black, width: 1),
                            right: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              // controller: nameCtrl[index],
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                              decoration: const InputDecoration(
                                labelText: "Name",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 0.5,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  nameList[index] = value;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter name.";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              //controller: emailCtrl[index],
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: "Email",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 0.5,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  emailList[index] = value;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter email.";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              //controller: mobileCtrl[index],
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
                              onChanged: (String value) {
                                setState(() {
                                  mobileList[index] = value;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter mobile no.";
                                }
                                return null;
                              },
                            ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // TextFormField(
                            //   decoration: const InputDecoration(
                            //     labelText: "Email Address",
                            //     border: OutlineInputBorder(
                            //       borderSide: BorderSide(
                            //         width: 0.5,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                index == 0
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            mListNew[index] = 'Admin';
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: "Admin",
                                              groupValue: mListNew[index],
                                              onChanged: (e) {
                                                setState(() {
                                                  mListNew[index] =
                                                      e.toString();
                                                });
                                              },
                                            ),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                              child: Text("Admin"),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                ElevatedButton(
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowMultiple: false,
                                      allowedExtensions: ['png', 'jpeg', 'jpg'],
                                    );
                                    if (result != null) {
                                      if (result.files.first.size > 5000000) {
                                        showErrorMessage(
                                            context,
                                            "File Size Error",
                                            "Please check if file size is less than 5MB and then try again.");
                                      } else {
                                        File? fileDataUploaded =
                                            File(result.files.single.path!);
                                        final filePath = fileDataUploaded
                                            .absolute.path
                                            .toString();
                                        setState(() {
                                          imageList[index] = filePath;
                                        });
                                      }
                                    } else {
                                      // User canceled the picker
                                    }
                                  },
                                  child: const Text('UPLOAD IMAGE'),
                                  style: ElevatedButton.styleFrom(
                                    primary: imageList[index] == 'NULL'
                                        ? Colors.grey
                                        : const Color(0xff152238),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddRoomScreen(
                                  data: widget.data,
                                  booth: widget.booth,
                                  userDetails: widget.userDetails,
                                  delegate: const [],
                                )));
                      },
                      child: Container(
                        width: size.width * 0.4,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: const Color(0xff152238), width: 1),
                        ),
                        child: const Center(
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: Color(0xff152238),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          List<bool> isValidated = [];
                          List<AddDelegateModel> delegateModelList = [];
                          for (int i = 0; i < mListNew.length; i++) {
                            if (mListNew[0] == 'NULL') {
                              isValidated.add(false);
                              const snackBar = SnackBar(
                                content:
                                    Text('Please see if admin is selected'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              break;
                            } else if (nameList[i] == 'NULL') {
                              isValidated.add(false);
                              const snackBar = SnackBar(
                                content:
                                    Text('Please check if names are inserted'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              break;
                            } else if (emailList[i] == 'NULL') {
                              isValidated.add(false);
                              const snackBar = SnackBar(
                                content:
                                    Text('Please check if emails are inserted'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              break;
                            } else if (mobileList[i] == 'NULL') {
                              isValidated.add(false);
                              const snackBar = SnackBar(
                                content: Text(
                                    'Please check if mobile numbers are inserted'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              break;
                            } else if (imageList[i] == 'NULL') {
                              isValidated.add(false);
                              const snackBar = SnackBar(
                                content:
                                    Text('Please check if images are attached'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              break;
                            } else {
                              isValidated.add(true);
                            }
                            print(
                                '\nRadio: ${mListNew[i]}\nName: ${nameList[i]}\nEmail: ${emailList[i]}\nMobile: ${mobileList[i]}\nImage: ${imageList[i]}');
                          }
                          if (!isValidated.contains(false)) {
                            showLoaderDialog(context);
                            const snackBar = SnackBar(
                              content: Text('Success'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Future.delayed(
                                const Duration(
                                  seconds: 3,
                                ), () {
                              for (int i = 0; i < mListNew.length; i++) {
                                AddDelegateModel delegateModel =
                                    AddDelegateModel(
                                        name: nameList[i],
                                        email: emailList[i],
                                        mobile: mobileList[i],
                                        admin: mListNew[i],
                                        image: imageList[i]);
                                delegateModelList.add(delegateModel);
                              }
                            }).then((value) {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddRoomScreen(
                                      data: widget.data,
                                      booth: widget.booth,
                                      userDetails: widget.userDetails,
                                      delegate: delegateModelList)));
                            });
                          }
                        }
                      },
                      child: Container(
                        width: size.width * 0.4,
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
                  ],
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

  showErrorMessage(
      BuildContext context, String errorTitle, String errorMessage) {
    Widget okButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
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
