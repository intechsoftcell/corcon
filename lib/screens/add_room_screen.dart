import 'package:corcon/screens/add_deletegate_screen.dart';
import 'package:corcon/screens/last_registration_screen.dart';
import 'package:corcon/screens/opportunity_second_screen.dart';
import 'package:flutter/material.dart';

class AddRoomModel {
  String name, email, mobile, roomNo;
  AddRoomModel(
      {required this.name,
      required this.email,
      required this.mobile,
      required this.roomNo});
}

class AddRoomScreen extends StatefulWidget {
  Map<String, String> data;
  List<AddDelegateModel> delegate;
  List<SymposiaUserDetails> userDetails;
  List booth;
  AddRoomScreen(
      {Key? key,
      required this.data,
      required this.booth,
      required this.userDetails,
      required this.delegate})
      : super(key: key);

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  List<TextEditingController> nameCtrl = [];
  List<TextEditingController> mobileCtrl = [];
  List<TextEditingController> emailCtrl = [];
  List<String> nameList = [];
  List<String> emailList = [];
  List<String> mobileList = [];
  List<String> roomList = [];
  final _formKey = GlobalKey<FormState>();
  bool isDataAdded = true;
  int increment = 0;
  Future<void> getDelegateModel() async {
    for (int i = 0; i < int.parse(widget.data['count'].toString()); i++) {
      nameList.add("NULL");
      emailList.add("NULL");
      mobileList.add("NULL");
      if (isDataAdded) {
        increment += 1;
        roomList.add(increment.toString() + "A");
        isDataAdded = false;
      } else {
        roomList.add(increment.toString() + "B");
        isDataAdded = true;
      }
    }
  }

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
                              'Room Details',
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
                Text('Number of Rooms: ${widget.data['count']}'),
                SizedBox(
                  // height: size.height,
                  width: size.width,
                  child: ListView.builder(
                    // itemCount: int.parse(widget.data['count'].toString()),
                    itemCount: roomList.length,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Room ${roomList[index]}:'),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              //controller: nameCtrl[index],
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
                            builder: (context) => LastRegistrationScreen(
                                  data: widget.data,
                                  booth: widget.booth,
                                  userDetails: widget.userDetails,
                                  delegate: const [],
                                  room: const [],
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
                          List<AddRoomModel> roomModelList = [];
                          for (int i = 0; i < nameList.length; i++) {
                            if (nameList[i] == 'NULL') {
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
                            } else {
                              isValidated.add(true);
                            }
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
                              for (int i = 0; i < nameList.length; i++) {
                                AddRoomModel delegateModel = AddRoomModel(
                                    name: nameList[i],
                                    email: emailList[i],
                                    mobile: mobileList[i],
                                    roomNo: roomList[i]);
                                roomModelList.add(delegateModel);
                              }
                            }).then((value) {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LastRegistrationScreen(
                                      data: widget.data,
                                      booth: widget.booth,
                                      userDetails: widget.userDetails,
                                      delegate: widget.delegate,
                                      room: roomModelList)));
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
}
