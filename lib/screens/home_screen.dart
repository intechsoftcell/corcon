import 'dart:io';
import 'package:corcon/model/single_row_model.dart';
import 'package:corcon/model/user_login_model.dart';
import 'package:corcon/screens/feedback_screen.dart';
import 'package:corcon/screens/maps_screen.dart';
import 'package:corcon/screens/navigation_screen.dart';
import 'package:corcon/screens/notes_screen.dart';
import 'package:corcon/screens/profile_screen.dart';
import 'package:corcon/screens/view_paper_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import '../model/symposia_list_model.dart';
import '../utils/common.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  File? fileDataUploaded;

  double xOffset1 = 0;
  double yOffset1 = 0;
  double scaleFactor1 = 1;

  String selectedFile = "No File Selected";
  String selectedSymposia = "";
  String selectedPaperTitle = "";
  String selectedCategory = "";

  final formKey = GlobalKey<FormState>();

  List menuData = [
    {
      "name": "View Paper",
      "icon": const Icon(Icons.file_copy, color: Colors.white)
    },
    {
      "name": "Speakers",
      "icon": const Icon(Icons.speaker, color: Colors.white)
    },
    {"name": "Notes", "icon": const Icon(Icons.note, color: Colors.white)},
    {
      "name": "Sponsors",
      "icon": const Icon(Icons.attach_money, color: Colors.white)
    },
    {
      "name": "Exhibitors",
      "icon": const Icon(Icons.contact_phone, color: Colors.white)
    },
    {"name": "Maps", "icon": const Icon(Icons.map, color: Colors.white)},
    {"name": "Posters", "icon": const Icon(Icons.image, color: Colors.white)},
    {"name": "Feedback", "icon": const Icon(Icons.mail, color: Colors.white)},
    {"name": "Profile", "icon": const Icon(Icons.person, color: Colors.white)}
  ];

  Future<UserLoginModel> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String regId = prefs.getString("REG_ID")!;
    String userId = prefs.getString("USERID")!;
    String userName = prefs.getString("USERNAME")!;
    String userEmail = prefs.getString("USEREMAIL")!;
    return UserLoginModel(
        userId: userId, userName: userName, regId: regId, email: userEmail);
  }

  Future<SymposiaListModel> getSymposiaList(String regId) async {
    var url = Uri.parse('${baseUrl}GetSymposiaUserList');
    var response = await http.post(url, body: {'Reg_Id': regId});
    return symposiaListModelFromJson(response.body);
  }

  Future<int> uploadFile(String title, String papername, String uploadedby,
      String empcode, String regid, String type, emailid, File file) async {
    var uri = Uri.parse("${baseUrl}SetSymposiaDataUpload");
    var request = http.MultipartRequest("POST", uri);
    request.fields["title"] = title;
    request.fields["papername"] = papername;
    request.fields["uploadedby"] = uploadedby;
    request.fields["empcode"] = empcode;
    request.fields["regid"] = regid;
    request.fields["emailid"] = emailid;

    var multipartFile = await http.MultipartFile.fromPath('file', file.path);
    request.files.add(multipartFile);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
    printLog(result);
    final data = singleRowModelFromJson(result);
    return data.first.sts;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getUserName();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            backgroundStack(),
            IgnorePointer(
              ignoring: isDrawerOpen,
              child: AnimatedContainer(
                transform: Matrix4.translationValues(xOffset, yOffset, 0)
                  ..scale(scaleFactor),
                duration: const Duration(milliseconds: 250),
                child: foregroundStack(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget middleStack() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius:
            isDrawerOpen ? BorderRadius.circular(20) : BorderRadius.circular(0),
        color: Colors.deepOrange,
      ),
    );
  }

  Widget foregroundStack() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius:
            isDrawerOpen ? BorderRadius.circular(20) : BorderRadius.circular(0),
        color: Colors.white,
      ),
      child: FutureBuilder<UserLoginModel>(
        future: getUserName(),
        builder: (context, snapshotNew) {
          if (snapshotNew.hasData) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 60, left: 20, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Welcome",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: size.width * 0.65,
                              child: Text(
                                snapshotNew.data!.userName.toString(),
                                // overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              xOffset = 230;
                              yOffset = 150;
                              scaleFactor = 0.6;
                              isDrawerOpen = true;
                              xOffset1 = 220;
                              yOffset1 = 140;
                              scaleFactor1 = 0.6;
                            });
                          },
                          child: const Image(
                            image: AssetImage(
                              './assets/icons/menu.png',
                            ),
                            width: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<SymposiaListModel>(
                    future: getSymposiaList(snapshotNew.data!.regId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<String> symposiaListData = [];
                        List paperListData = [];
                        for (int i = 0; i < snapshot.data!.dtqty.length; i++) {
                          symposiaListData
                              .add(snapshot.data!.dtqty[i].symposiaName);
                        }
                        String selectedItem1 = "Select";
                        String selectedItem2 = "Select";
                        String selectedItem3 = "Select";
                        return Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: DropdownSearch<dynamic>(
                                  selectedItem: selectedItem1,
                                  dropdownSearchDecoration:
                                      const InputDecoration(
                                    labelText: "Select Symposia",
                                  ),
                                  onChanged: (e) {
                                    selectedSymposia = e;
                                    paperListData.clear();
                                    for (int i = 0;
                                        i < snapshot.data!.dtqty.length;
                                        i++) {
                                      if (snapshot
                                              .data!.dtqty[i].symposiaName ==
                                          e) {
                                        paperListData.add(
                                            snapshot.data!.dtqty[i].paperTitle);
                                      }
                                    }
                                  },
                                  showSearchBox: true,
                                  items: symposiaListData.toSet().toList(),
                                  validator: (value) {
                                    if (value == 'Select') {
                                      return "Symposia Name Required";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: DropdownSearch<dynamic>(
                                  selectedItem: selectedItem2,
                                  dropdownSearchDecoration:
                                      const InputDecoration(
                                    labelText: "Select Name of Paper",
                                  ),
                                  onChanged: (e) {
                                    selectedPaperTitle = e;
                                  },
                                  showSearchBox: true,
                                  items: paperListData,
                                  validator: (value) {
                                    if (value == 'Select') {
                                      return "Paper Name Required";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: DropdownSearch<dynamic>(
                                  selectedItem: selectedItem3,
                                  dropdownSearchDecoration:
                                      const InputDecoration(
                                    labelText: "Select Category",
                                  ),
                                  onChanged: (e) {
                                    selectedCategory = e;
                                  },
                                  showSearchBox: true,
                                  items: const ["Abstract"],
                                  validator: (value) {
                                    if (value == 'Select') {
                                      return "Category Required";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text("File-Type: pdf/docx"),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 60,
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20),
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.4,
                                      child: Text(
                                        selectedFile,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowMultiple: false,
                                          allowedExtensions: ['pdf', 'doc'],
                                        );
                                        if (result != null) {
                                          if (result.files.first.size >
                                              5000000) {
                                            showErrorMessage(
                                                context,
                                                "File Size Error",
                                                "Please check if file size is less than 5MB and then try again.");
                                            setState(() {
                                              selectedFile = "No File Selected";
                                            });
                                          } else {
                                            fileDataUploaded =
                                                File(result.files.single.path!);
                                            final filePath = fileDataUploaded!
                                                .absolute.path
                                                .toString()
                                                .split('/file_picker/');
                                            setState(() {
                                              selectedFile = filePath.last;
                                            });
                                          }
                                        } else {
                                          // User canceled the picker
                                        }
                                      },
                                      child: const Text("Browse"),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      if (selectedFile != "No File Selected") {
                                        showLoaderDialog(context);
                                        uploadFile(
                                                selectedSymposia,
                                                selectedPaperTitle,
                                                snapshotNew.data!.userName,
                                                snapshotNew.data!.userId,
                                                snapshotNew.data!.regId,
                                                selectedCategory,
                                                snapshotNew.data!.email,
                                                fileDataUploaded!)
                                            .then((value) {
                                          if (value == 1) {
                                            showSuccessDialog(context);
                                          } else {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HomeScreen()),
                                                    (route) => false)
                                                .then((value) {
                                              formKey.currentState!.reset();

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Failed to add data"),
                                                ),
                                              );
                                            });
                                          }
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text("Please select a file"),
                                          ),
                                        );
                                      }
                                    } else {}
                                  },
                                  child: const Text("Submit"),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  printLog(String data) {
    debugPrint('HomeScreen: $data');
  }

  showErrorMessage(
      BuildContext context, String errorTitle, String errorMessage) {
    Widget okButton = TextButton(
      child: const Text("Okay"),
      onPressed: () async {
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

  Widget backgroundStack() {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xff152238),
      width: size.width,
      height: size.height,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 60,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<UserLoginModel>(
                      future: getUserName(),
                      builder: (context, snapshot) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * 0.65,
                              child: Text(
                                snapshot.data == null
                                    ? ""
                                    : snapshot.data!.userName,
                                // overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              snapshot.data == null ? "" : snapshot.data!.regId,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 24,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            xOffset = 0;
                            yOffset = 0;
                            scaleFactor = 1;
                            isDrawerOpen = false;
                            xOffset1 = 0;
                            yOffset1 = 0;
                            scaleFactor1 = 1;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ListView.builder(
                padding: const EdgeInsets.only(left: 20),
                itemCount: menuData.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ViewPaperScreen()));
                      }
                      if (index == 2) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const NotesScreen()));
                      }
                      if (index == 5) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MapScreen()));
                      }
                      if (index == 7) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const FeedbackScreen()));
                      }
                      if (index == 8) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      }
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: menuData[index]["icon"],
                      title: Text(
                        menuData[index]["name"],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  showAlertLogoutDialog(context);
                },
                child: const ListTile(
                  leading: Icon(Icons.logout, color: Colors.white),
                  title: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Version: 1.0.0",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  showSuccessDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("Okay"),
      onPressed: () async {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Successful"),
      content: const Text("Data has been uploaded successfully"),
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
            margin: const EdgeInsets.only(left: 20),
            child: const Text(
              'Sending data...',
              style: TextStyle(fontSize: 14),
            ),
          ),
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

  showAlertLogoutDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("Okay"),
      onPressed: () async {
        showLogoutDialog(context);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear().then((value) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const NavigationScreen()),
              (route) => false);
        });
      },
    );
    Widget cancelBtn = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Logging Out"),
      content: const Text("Are you sure you want to logout?"),
      actions: [okButton, cancelBtn],
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  showLogoutDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text("Logging out...")),
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
