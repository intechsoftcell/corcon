import 'dart:io';
import 'dart:math';
import 'package:corcon/model/single_row_model.dart';
import 'package:corcon/screens/add_deletegate_screen.dart';
import 'package:corcon/screens/add_room_screen.dart';
import 'package:corcon/screens/navigation_screen.dart';
import 'package:corcon/screens/opportunity_second_screen.dart';
import 'package:corcon/utils/common.dart';
import 'package:corcon/utils/data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class LastRegistrationScreen extends StatefulWidget {
  Map<String, String> data;
  List<AddDelegateModel> delegate;
  List<AddRoomModel> room;
  List<SymposiaUserDetails> userDetails;
  List booth;
  LastRegistrationScreen(
      {Key? key,
      required this.data,
      required this.booth,
      required this.userDetails,
      required this.delegate,
      required this.room})
      : super(key: key);
  @override
  State<LastRegistrationScreen> createState() => _LastRegistrationScreenState();
}

class _LastRegistrationScreenState extends State<LastRegistrationScreen> {
  String firstSelectedImage = "No File Selected";
  String secondSelectedImage = "No File Selected";
  String thirdSelectedImage = "No File Selected";
  String fourthSelectedImage = "No File Selected";
  final websiteCtrl = TextEditingController();
  final faciaCtrl = TextEditingController();
  File? fileDataUploaded1,
      fileDataUploaded2,
      fileDataUploaded3,
      fileDataUploaded4;

  Future<int> uploadSponsorData(
      String reg_id,
      String name,
      String email,
      String mobile,
      String username,
      String password,
      String companyMobile,
      String companyEmail,
      String website,
      String faciaName,
      File? companyLogo,
      File? visitingcard,
      File? companyProfile,
      File? advertise) async {
    var uri = Uri.parse("${baseUrl}SponsorRegistration");
    var request = http.MultipartRequest("POST", uri);
    request.fields["reg_id"] = reg_id;
    request.fields["name"] = name;
    request.fields["email"] = email;
    request.fields["mobile"] = mobile;
    request.fields["username"] = username;
    request.fields["password"] = password;
    request.fields["companyMobile"] = companyMobile;
    request.fields["companyEmail"] = companyEmail;
    request.fields["website"] = website;
    request.fields["faciaName"] = faciaName;

    if (companyLogo != null) {
      var multipartFile1 =
          await http.MultipartFile.fromPath('companyLogo', companyLogo.path);
      request.files.add(multipartFile1);
    } else {
      request.fields['companyLogo'] = '';
    }
    if (visitingcard != null) {
      var multipartFile2 =
          await http.MultipartFile.fromPath('visitingCard', visitingcard.path);
      request.files.add(multipartFile2);
    } else {
      request.fields['visitingCard'] = '';
    }

    if (companyProfile != null) {
      var multipartFile3 = await http.MultipartFile.fromPath(
          'companyProfile', companyProfile.path);
      request.files.add(multipartFile3);
    } else {
      request.fields['companyProfile'] = '';
    }

    if (advertise != null) {
      var multipartFile4 =
          await http.MultipartFile.fromPath('advertise', advertise.path);
      request.files.add(multipartFile4);
    } else {
      request.fields['advertise'] = '';
    }

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
    print(result);
    final data = singleRowModelFromJson(result);
    return data.first.sts;
  }

  int countIncrement = 0;

  Future<int> uploadBoothData(Map<String, String> data, String boothName,
      List<SymposiaUserDetails> userDetails, int index) async {
    var uri = Uri.parse("${baseUrl}SetBoothDetails");
    var request = http.MultipartRequest("POST", uri);
    countIncrement = countIncrement + 1;

    if (countIncrement == 1) {
      if (data["type"] == null) {
        if (userDetails.first.accomodationType == "Without Accomodation") {
          request.fields["actualAmount"] =
              data["withoutAccomodation"].toString();
          request.fields["discount"] = '0';
          request.fields["discountAmnt"] = '0';
          request.fields["totalAmount"] =
              data["withoutAccomodation"].toString();
        }
        if (userDetails.first.accomodationType == "Single Sharing") {
          request.fields["actualAmount"] = data["singleSharing"].toString();
          request.fields["discount"] = '0';
          request.fields["discountAmnt"] = '0';
          request.fields["totalAmount"] = data["singleSharing"].toString();
        }
        if (userDetails.first.accomodationType == "Double Sharing") {
          request.fields["actualAmount"] = data["doubleSharing"].toString();
          request.fields["discount"] = '0';
          request.fields["discountAmnt"] = '0';
          request.fields["totalAmount"] = data["doubleSharing"].toString();
        }
        if (userDetails.first.accomodationType == "Triple Sharing") {
          request.fields["actualAmount"] = data["tripleSharing"].toString();
          request.fields["discount"] = '0';
          request.fields["discountAmnt"] = '0';
          request.fields["totalAmount"] = data["tripleSharing"].toString();
        }
      } else {
        request.fields["actualAmount"] = data["inclusiveGst"].toString();
        request.fields["discount"] = '0';
        request.fields["discountAmnt"] = '0';
        request.fields["totalAmount"] = data["inclusiveGst"].toString();
      }
    }
    if (countIncrement > 1) {
      if (data["type"] == null) {
        if (userDetails.first.accomodationType == "Without Accomodation") {
          double actualAmount =
              double.parse(data["withoutAccomodation"].toString());
          double discountAmount =
              double.parse(data["withoutAccomodation"].toString()) / 2;
          actualAmount = double.parse(data["withoutAccomodation"].toString());
          request.fields["actualAmount"] = actualAmount.toString();
          request.fields["discount"] = '50%';
          request.fields["discountAmnt"] = '$discountAmount';
          request.fields["totalAmount"] = '$discountAmount';
        }
        if (userDetails.first.accomodationType == "Single Sharing") {
          double actualAmount = double.parse(data["singleSharing"].toString());
          double discountAmount =
              double.parse(data["singleSharing"].toString()) / 2;
          actualAmount = double.parse(data["singleSharing"].toString());
          request.fields["actualAmount"] = actualAmount.toString();
          request.fields["discount"] = '50%';
          request.fields["discountAmnt"] = '$discountAmount';
          request.fields["totalAmount"] = '$discountAmount';
        }
        if (userDetails.first.accomodationType == "Double Sharing") {
          double actualAmount = double.parse(data["doubleSharing"].toString());
          double discountAmount =
              double.parse(data["doubleSharing"].toString()) / 2;
          actualAmount = double.parse(data["doubleSharing"].toString());
          request.fields["actualAmount"] = actualAmount.toString();
          request.fields["discount"] = '50%';
          request.fields["discountAmnt"] = '$discountAmount';
          request.fields["totalAmount"] = '$discountAmount';
        }
        if (userDetails.first.accomodationType == "Triple Sharing") {
          double actualAmount = double.parse(data["tripleSharing"].toString());
          double discountAmount =
              double.parse(data["tripleSharing"].toString()) / 2;
          actualAmount = double.parse(data["tripleSharing"].toString());
          request.fields["actualAmount"] = actualAmount.toString();
          request.fields["discount"] = '50%';
          request.fields["discountAmnt"] = '$discountAmount';
          request.fields["totalAmount"] = '$discountAmount';
        }
      } else {
        double actualAmount = double.parse(data["inclusiveGst"].toString());
        double discountAmount =
            double.parse(data["inclusiveGst"].toString()) / 2;
        actualAmount = double.parse(data["inclusiveGst"].toString());
        request.fields["actualAmount"] = actualAmount.toString();
        request.fields["discount"] = '50%';
        request.fields["discountAmnt"] = '$discountAmount';
        request.fields["totalAmount"] = '$discountAmount';
      }
    }
    request.fields["boothName"] = boothName;
    if (newHallList.contains(boothName)) {
      request.fields["sqmType"] = "9 SqM";
    } else {
      request.fields["sqmType"] = "12 SqM";
    }
    request.fields["isOccupied"] = "Yes";
    request.fields["regId"] = tempId;
    request.fields["boothStatus"] = "Active";
    request.fields["listNo"] = countIncrement.toString();

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
    print(result);
    final sts = singleRowModelFromJson(result);
    return sts.first.sts;
  }

  Future<int> uploadNoLastRegistration(
      String reg_id,
      String name,
      String email,
      String mobile,
      String username,
      String password,
      String companyMobile,
      String companyEmail) async {
    var uri = Uri.parse("${baseUrl}NoLastPageRegistration");
    var request = http.MultipartRequest("POST", uri);
    request.fields["reg_id"] = reg_id;
    request.fields["name"] = name;
    request.fields["email"] = email;
    request.fields["mobile"] = mobile;
    request.fields["username"] = username;
    request.fields["password"] = password;
    request.fields["companyMobile"] = companyMobile;
    request.fields["companyEmail"] = companyEmail;

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
    print(result);
    final data = singleRowModelFromJson(result);
    return data.first.sts;
  }

  Future<int> uploadDelegateData(
      String reg_id,
      String name,
      String email,
      String mobile,
      String username,
      String password,
      String companyMobile,
      String companyEmail,
      String website,
      File? companyLogo,
      File? visitingcard) async {
    var uri = Uri.parse("${baseUrl}DelegateRegistration");
    var request = http.MultipartRequest("POST", uri);
    request.fields["reg_id"] = reg_id;
    request.fields["name"] = name;
    request.fields["email"] = email;
    request.fields["mobile"] = mobile;
    request.fields["username"] = username;
    request.fields["password"] = password;
    request.fields["companyMobile"] = companyMobile;
    request.fields["companyEmail"] = companyEmail;
    request.fields["website"] = website;

    if (companyLogo != null) {
      var multipartFile1 =
          await http.MultipartFile.fromPath('companyLogo', companyLogo.path);
      request.files.add(multipartFile1);
    } else {
      request.fields['companyLogo'] = '';
    }
    if (visitingcard != null) {
      var multipartFile2 =
          await http.MultipartFile.fromPath('visitingCard', visitingcard.path);
      request.files.add(multipartFile2);
    } else {
      request.fields['visitingCard'] = '';
    }

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
    print(result);
    final data = singleRowModelFromJson(result);
    return data.first.sts;
  }

  String tempId = "";

  Future<int> sendDelegateList(
      String regId,
      String delegateNo,
      String delegateName,
      String uploadedPhoto,
      String emailid,
      String mobileno,
      String role,
      File delegateFile) async {
    var uri = Uri.parse("${baseUrl}SetDelegateList");
    var request = http.MultipartRequest("POST", uri);
    print('Path: ${delegateFile.path}');
    request.fields["regId"] = regId;
    request.fields["delegateNo"] = delegateNo;
    request.fields["delegateName"] = delegateName;
    request.fields["uploadedPhoto"] = uploadedPhoto;
    request.fields["emailid"] = emailid;
    request.fields["mobileno"] = mobileno;
    request.fields["role"] = role;

    var multipartFile1 =
        await http.MultipartFile.fromPath('delegateFile', delegateFile.path);
    request.files.add(multipartFile1);

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
    print(result);
    final data = singleRowModelFromJson(result);
    return data.first.sts;
  }

  Future<int> sendRoomList(String regId, String roomNo, String name,
      String emailid, String mobileno) async {
    var uri = Uri.parse("${baseUrl}SetRoomList");
    var request = http.MultipartRequest("POST", uri);
    request.fields["regId"] = regId;
    request.fields["roomNo"] = roomNo;
    request.fields["name"] = name;
    request.fields["uploadedPhoto"] = 'NULL';
    request.fields["emailid"] = emailid;
    request.fields["mobileno"] = mobileno;

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
    print(result);
    final data = singleRowModelFromJson(result);
    return data.first.sts;
  }

  @override
  void initState() {
    super.initState();
    Random random = Random();
    int min = 100;
    int max = 999;
    int randomNumber = random.nextInt(max - min);
    tempId = 'CORCON/2022/22-23/$randomNumber';
  }

  @override
  Widget build(BuildContext context) {
    print(
        'Data: ${widget.data}, Booth: ${widget.booth}, UserDetails: ${widget.userDetails}, Delegate: ${widget.delegate}, Room: ${widget.room}');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const PageScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
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
                          child: const Text(
                            'Registration Form',
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
                height: 60,
              ),
              TextFormField(
                controller: websiteCtrl,
                decoration: const InputDecoration(
                  labelText: "Website",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: int.parse(widget.data["count"]!) > 0,
                child: Column(
                  children: [
                    TextFormField(
                      controller: faciaCtrl,
                      decoration: const InputDecoration(
                        labelText: "Facia Name",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Colors.black,
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
              const Text("Upload Company Logo: png/jpeg"),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      child: Text(
                        firstSelectedImage,
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
                          allowedExtensions: ['png', 'jpeg', 'jpg'],
                        );
                        if (result != null) {
                          if (result.files.first.size > 5000000) {
                            showErrorMessage(context, "File Size Error",
                                "Please check if file size is less than 5MB and then try again.");
                            setState(() {
                              firstSelectedImage = "No File Selected";
                            });
                          } else {
                            fileDataUploaded1 = File(result.files.single.path!);
                            final filePath = fileDataUploaded1!.absolute.path
                                .toString()
                                .split('/file_picker/');
                            setState(() {
                              firstSelectedImage = filePath.last;
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
              const Text("Upload Visiting Card: png/jpeg"),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      child: Text(
                        secondSelectedImage,
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
                          allowedExtensions: ['png', 'jpeg', 'jpg'],
                        );
                        if (result != null) {
                          if (result.files.first.size > 5000000) {
                            showErrorMessage(context, "File Size Error",
                                "Please check if file size is less than 5MB and then try again.");
                            setState(() {
                              secondSelectedImage = "No File Selected";
                            });
                          } else {
                            fileDataUploaded2 = File(result.files.single.path!);
                            final filePath = fileDataUploaded2!.absolute.path
                                .toString()
                                .split('/file_picker/');
                            setState(() {
                              secondSelectedImage = filePath.last;
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
              Visibility(
                  visible: int.parse(widget.data["count"]!) > 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Upload Company Profile: pdf/docx"),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width * 0.4,
                              child: Text(
                                thirdSelectedImage,
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
                                  allowedExtensions: ['pdf', 'docx'],
                                );
                                if (result != null) {
                                  if (result.files.first.size > 5000000) {
                                    showErrorMessage(context, "File Size Error",
                                        "Please check if file size is less than 5MB and then try again.");
                                    setState(() {
                                      thirdSelectedImage = "No File Selected";
                                    });
                                  } else {
                                    fileDataUploaded3 =
                                        File(result.files.single.path!);
                                    final filePath = fileDataUploaded3!
                                        .absolute.path
                                        .toString()
                                        .split('/file_picker/');
                                    setState(() {
                                      thirdSelectedImage = filePath.last;
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
                      const Text("Upload Advertise: pdf/docx"),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width * 0.4,
                              child: Text(
                                fourthSelectedImage,
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
                                  allowedExtensions: ['pdf', 'docx'],
                                );
                                if (result != null) {
                                  if (result.files.first.size > 5000000) {
                                    showErrorMessage(context, "File Size Error",
                                        "Please check if file size is less than 5MB and then try again.");
                                    setState(() {
                                      fourthSelectedImage = "No File Selected";
                                    });
                                  } else {
                                    fileDataUploaded4 =
                                        File(result.files.single.path!);
                                    final filePath = fileDataUploaded4!
                                        .absolute.path
                                        .toString()
                                        .split('/file_picker/');
                                    setState(() {
                                      fourthSelectedImage = filePath.last;
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
                    ],
                  )),
              GestureDetector(
                onTap: () async {
                  countIncrement = 0;
                  if (int.parse(widget.data["count"].toString()) > 0) {
                    showLoaderDialog(context);
                    if (websiteCtrl.text.isEmpty ||
                        faciaCtrl.text.isEmpty ||
                        firstSelectedImage == "No File Selected" ||
                        secondSelectedImage == "No File Selected" ||
                        thirdSelectedImage == "No File Selected" ||
                        fourthSelectedImage == "No File Selected") {
                      Navigator.of(context).pop();
                      showNewErrorMessage(context, 'Skip and Register',
                          'Do you want to skip and register directly?.');
                    } else {
                      if (widget.delegate.isEmpty &&
                          widget.room.isEmpty &&
                          widget.booth.isEmpty) {
                        await uploadSponsorData(
                                tempId,
                                widget.userDetails.first.personName,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.orgMobile,
                                widget.userDetails.first.orgEmail,
                                websiteCtrl.text,
                                faciaCtrl.text,
                                firstSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded1!,
                                secondSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded2!,
                                thirdSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded3!,
                                fourthSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded4!)
                            .then((value) {
                          if (value == 1) {
                            Fluttertoast.showToast(
                              msg: "Registration Successful",
                              textColor: Colors.white,
                              backgroundColor: Colors.green,
                            );
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NavigationScreen()),
                                (route) => false);
                          }
                          if (value == 0) {
                            Fluttertoast.showToast(
                              msg: "Registration Failed",
                              textColor: Colors.white,
                              backgroundColor: Colors.red,
                            );
                            Navigator.of(context).pop();
                          }
                        });
                      } else if (widget.delegate.isEmpty &&
                          widget.room.isEmpty) {
                        await uploadSponsorData(
                                tempId,
                                widget.userDetails.first.personName,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.orgMobile,
                                widget.userDetails.first.orgEmail,
                                websiteCtrl.text,
                                faciaCtrl.text,
                                firstSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded1!,
                                secondSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded2!,
                                thirdSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded3!,
                                fourthSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded4!)
                            .then((value) {
                          if (value == 1) {
                            Future(
                              () {
                                for (int n = 0; n < widget.booth.length; n++) {
                                  uploadBoothData(
                                      widget.data,
                                      widget.booth[n].toString(),
                                      widget.userDetails,
                                      (n + 1));
                                }
                              },
                            ).then((value) {
                              Fluttertoast.showToast(
                                msg: "Registration Successful",
                                textColor: Colors.white,
                                backgroundColor: Colors.green,
                              );
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NavigationScreen()),
                                  (route) => false);
                            });
                            print('no empty');
                          }
                          if (value == 0) {
                            Fluttertoast.showToast(
                              msg: "Registration Failed",
                              textColor: Colors.white,
                              backgroundColor: Colors.red,
                            );
                            Navigator.of(context).pop();
                          }
                        });
                        print('12 empty');
                      } else if (widget.room.isEmpty && widget.booth.isEmpty) {
                        await uploadSponsorData(
                                tempId,
                                widget.userDetails.first.personName,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.orgMobile,
                                widget.userDetails.first.orgEmail,
                                websiteCtrl.text,
                                faciaCtrl.text,
                                firstSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded1!,
                                secondSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded2!,
                                thirdSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded3!,
                                fourthSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded4!)
                            .then((value) {
                          if (value == 1) {
                            Future(
                              () {
                                for (int n = 0;
                                    n < widget.delegate.length;
                                    n++) {
                                  File newFile =
                                      File(widget.delegate[n].image.toString());
                                  Random random = Random();
                                  int min = 100;
                                  int max = 999;
                                  int randomNumber = random.nextInt(max - min);
                                  String tempId1 =
                                      'CORCON/2022/22-23/$randomNumber';
                                  sendDelegateList(
                                      tempId,
                                      '${n + 1}',
                                      widget.delegate[n].name,
                                      widget.delegate[n].image,
                                      widget.delegate[n].email,
                                      widget.delegate[n].mobile,
                                      widget.delegate[n].admin.contains('Admin')
                                          ? 'AdminDelegate'
                                          : 'Delegate',
                                      newFile);
                                }
                              },
                            ).then((value) {
                              Fluttertoast.showToast(
                                msg: "Registration Successful",
                                textColor: Colors.white,
                                backgroundColor: Colors.green,
                              );
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NavigationScreen()),
                                  (route) => false);
                            });
                            print('no empty');
                          }
                        });
                        print('23 empty');
                      } else if (widget.delegate.isEmpty &&
                          widget.booth.isEmpty) {
                        await uploadSponsorData(
                                tempId,
                                widget.userDetails.first.personName,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.orgMobile,
                                widget.userDetails.first.orgEmail,
                                websiteCtrl.text,
                                faciaCtrl.text,
                                firstSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded1!,
                                secondSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded2!,
                                thirdSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded3!,
                                fourthSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded4!)
                            .then((value) {
                          if (value == 1) {
                            Future(
                              () {
                                for (int n = 0; n < widget.room.length; n++) {
                                  sendRoomList(
                                      tempId,
                                      widget.room[n].roomNo,
                                      widget.room[n].name,
                                      widget.room[n].email,
                                      widget.room[n].mobile);
                                }
                              },
                            ).then((value) {
                              Fluttertoast.showToast(
                                msg: "Registration Successful",
                                textColor: Colors.white,
                                backgroundColor: Colors.green,
                              );
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NavigationScreen()),
                                  (route) => false);
                            });
                            print('no empty');
                          }
                        });
                        print('13 empty');
                      } else {
                        await uploadSponsorData(
                                tempId,
                                widget.userDetails.first.personName,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.orgMobile,
                                widget.userDetails.first.orgEmail,
                                websiteCtrl.text,
                                faciaCtrl.text,
                                firstSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded1!,
                                secondSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded2!,
                                thirdSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded3!,
                                fourthSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded4!)
                            .then((value) {
                          if (value == 1) {
                            Future(
                              () {
                                for (int n = 0; n < widget.booth.length; n++) {
                                  uploadBoothData(
                                      widget.data,
                                      widget.booth[n].toString(),
                                      widget.userDetails,
                                      (n + 1));
                                }
                                for (int n = 0;
                                    n < widget.delegate.length;
                                    n++) {
                                  File newFile =
                                      File(widget.delegate[n].image.toString());
                                  Random random = Random();
                                  int min = 100;
                                  int max = 999;
                                  int randomNumber = random.nextInt(max - min);
                                  String tempId1 =
                                      'CORCON/2022/22-23/$randomNumber';
                                  sendDelegateList(
                                      tempId,
                                      '${n + 1}',
                                      widget.delegate[n].name,
                                      widget.delegate[n].image,
                                      widget.delegate[n].email,
                                      widget.delegate[n].mobile,
                                      widget.delegate[n].admin.contains('Admin')
                                          ? 'AdminDelegate'
                                          : 'Delegate',
                                      newFile);
                                }
                                for (int n = 0; n < widget.room.length; n++) {
                                  sendRoomList(
                                      tempId,
                                      widget.room[n].roomNo,
                                      widget.room[n].name,
                                      widget.room[n].email,
                                      widget.room[n].mobile);
                                }
                              },
                            ).then((value) {
                              Fluttertoast.showToast(
                                msg: "Registration Successful",
                                textColor: Colors.white,
                                backgroundColor: Colors.green,
                              );
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NavigationScreen()),
                                  (route) => false);
                            });
                            print('no empty');
                          }
                        });
                      }
                    }
                  } else {
                    showLoaderDialog(context);
                    if (websiteCtrl.text.isEmpty ||
                        firstSelectedImage == "No File Selected" ||
                        secondSelectedImage == "No File Selected") {
                      Navigator.of(context).pop();
                      showNewErrorMessage(context, 'Skip and Register',
                          'Do you want to skip and register directly?.');
                    } else {
                      if (widget.delegate.isEmpty &&
                          widget.room.isEmpty &&
                          widget.booth.isEmpty) {
                        await uploadDelegateData(
                                tempId,
                                widget.userDetails.first.personName,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.orgMobile,
                                widget.userDetails.first.orgEmail,
                                websiteCtrl.text,
                                firstSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded1!,
                                secondSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded2!)
                            .then((value) {
                          if (value == 1) {
                            Fluttertoast.showToast(
                              msg: "Registration Successful",
                              textColor: Colors.white,
                              backgroundColor: Colors.green,
                            );
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NavigationScreen()),
                                (route) => false);
                            print('no empty');
                          }
                          if (value == 0) {
                            Fluttertoast.showToast(
                              msg: "Registration Failed",
                              textColor: Colors.white,
                              backgroundColor: Colors.red,
                            );
                            Navigator.of(context).pop();
                          }
                        });
                      } else if (widget.delegate.isEmpty &&
                          widget.room.isEmpty) {
                        await uploadDelegateData(
                                tempId,
                                widget.userDetails.first.personName,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.orgMobile,
                                widget.userDetails.first.orgEmail,
                                websiteCtrl.text,
                                firstSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded1!,
                                secondSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded2!)
                            .then((value) {
                          if (value == 1) {
                            Future(
                              () {
                                for (int n = 0; n < widget.booth.length; n++) {
                                  uploadBoothData(
                                      widget.data,
                                      widget.booth[n].toString(),
                                      widget.userDetails,
                                      (n + 1));
                                }
                              },
                            ).then((value) {
                              Fluttertoast.showToast(
                                msg: "Registration Successful",
                                textColor: Colors.white,
                                backgroundColor: Colors.green,
                              );
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NavigationScreen()),
                                  (route) => false);
                            });
                            print('no empty');
                          }
                          if (value == 0) {
                            Fluttertoast.showToast(
                              msg: "Registration Failed",
                              textColor: Colors.white,
                              backgroundColor: Colors.red,
                            );
                            Navigator.of(context).pop();
                          }
                        });
                        print('12 empty');
                      } else if (widget.room.isEmpty && widget.booth.isEmpty) {
                        await uploadDelegateData(
                                tempId,
                                widget.userDetails.first.personName,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.orgMobile,
                                widget.userDetails.first.orgEmail,
                                websiteCtrl.text,
                                firstSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded1!,
                                secondSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded2!)
                            .then((value) {
                          if (value == 1) {
                            Future(
                              () {
                                for (int n = 0;
                                    n < widget.delegate.length;
                                    n++) {
                                  File newFile =
                                      File(widget.delegate[n].image.toString());
                                  Random random = Random();
                                  int min = 100;
                                  int max = 999;
                                  int randomNumber = random.nextInt(max - min);
                                  String tempId1 =
                                      'CORCON/2022/22-23/$randomNumber';
                                  sendDelegateList(
                                      tempId,
                                      '${n + 1}',
                                      widget.delegate[n].name,
                                      widget.delegate[n].image,
                                      widget.delegate[n].email,
                                      widget.delegate[n].mobile,
                                      widget.delegate[n].admin.contains('Admin')
                                          ? 'AdminDelegate'
                                          : 'Delegate',
                                      newFile);
                                }
                              },
                            ).then((value) {
                              Fluttertoast.showToast(
                                msg: "Registration Successful",
                                textColor: Colors.white,
                                backgroundColor: Colors.green,
                              );
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NavigationScreen()),
                                  (route) => false);
                            });
                            print('no empty');
                          }
                        });
                        print('23 empty');
                      } else if (widget.delegate.isEmpty &&
                          widget.booth.isEmpty) {
                        await uploadDelegateData(
                                tempId,
                                widget.userDetails.first.personName,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.orgMobile,
                                widget.userDetails.first.orgEmail,
                                websiteCtrl.text,
                                firstSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded1!,
                                secondSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded2!)
                            .then((value) {
                          if (value == 1) {
                            Future(
                              () {
                                for (int n = 0; n < widget.room.length; n++) {
                                  sendRoomList(
                                      tempId,
                                      widget.room[n].roomNo,
                                      widget.room[n].name,
                                      widget.room[n].email,
                                      widget.room[n].mobile);
                                }
                              },
                            ).then((value) {
                              Fluttertoast.showToast(
                                msg: "Registration Successful",
                                textColor: Colors.white,
                                backgroundColor: Colors.green,
                              );
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NavigationScreen()),
                                  (route) => false);
                            });
                            print('no empty');
                          }
                        });
                        print('13 empty');
                      } else {
                        await uploadDelegateData(
                                tempId,
                                widget.userDetails.first.personName,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.personEmail,
                                widget.userDetails.first.personMobile,
                                widget.userDetails.first.orgMobile,
                                widget.userDetails.first.orgEmail,
                                websiteCtrl.text,
                                firstSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded1!,
                                secondSelectedImage == "No File Selected"
                                    ? null
                                    : fileDataUploaded2!)
                            .then((value) {
                          if (value == 1) {
                            Future(
                              () {
                                for (int n = 0; n < widget.booth.length; n++) {
                                  uploadBoothData(
                                      widget.data,
                                      widget.booth[n].toString(),
                                      widget.userDetails,
                                      (n + 1));
                                }
                                for (int n = 0;
                                    n < widget.delegate.length;
                                    n++) {
                                  File newFile =
                                      File(widget.delegate[n].image.toString());
                                  Random random = Random();
                                  int min = 100;
                                  int max = 999;
                                  int randomNumber = random.nextInt(max - min);
                                  String tempId1 =
                                      'CORCON/2022/22-23/$randomNumber';
                                  sendDelegateList(
                                      tempId,
                                      '${n + 1}',
                                      widget.delegate[n].name,
                                      widget.delegate[n].image,
                                      widget.delegate[n].email,
                                      widget.delegate[n].mobile,
                                      widget.delegate[n].admin.contains('Admin')
                                          ? 'AdminDelegate'
                                          : 'Delegate',
                                      newFile);
                                }
                                for (int n = 0; n < widget.room.length; n++) {
                                  sendRoomList(
                                      tempId,
                                      widget.room[n].roomNo,
                                      widget.room[n].name,
                                      widget.room[n].email,
                                      widget.room[n].mobile);
                                }
                              },
                            ).then((value) {
                              Fluttertoast.showToast(
                                msg: "Registration Successful",
                                textColor: Colors.white,
                                backgroundColor: Colors.green,
                              );
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NavigationScreen()),
                                  (route) => false);
                            });
                            print('no empty');
                          }
                        });
                        print('no empty');
                      }
                    }
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
                      'Register',
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
    );
  }

  showErrorMessage(
      BuildContext context, String errorTitle, String errorMessage) {
    Widget okButton = TextButton(
      child: const Text("Okay"),
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

  showNewErrorMessage(
      BuildContext context, String errorTitle, String errorMessage) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () async {
        Navigator.of(context).pop();
      },
    );
    Widget okButton = TextButton(
      child: const Text("Submit"),
      onPressed: () async {
        Navigator.of(context).pop();
        showLoaderDialog(context);
        if (widget.delegate.isEmpty &&
            widget.room.isEmpty &&
            widget.booth.isEmpty) {
          await uploadNoLastRegistration(
                  tempId,
                  widget.userDetails.first.personName,
                  widget.userDetails.first.personEmail,
                  widget.userDetails.first.personMobile,
                  widget.userDetails.first.personEmail,
                  widget.userDetails.first.personMobile,
                  widget.userDetails.first.orgMobile,
                  widget.userDetails.first.orgEmail)
              .then((value) {
            if (value == 1) {
              Fluttertoast.showToast(
                msg: "Registration Successful",
                textColor: Colors.white,
                backgroundColor: Colors.green,
              );
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const NavigationScreen()),
                  (route) => false);
              print('no empty');
            }
            if (value == 0) {
              Fluttertoast.showToast(
                msg: "Registration Failed",
                textColor: Colors.white,
                backgroundColor: Colors.red,
              );
              Navigator.of(context).pop();
            }
          });
        } else if (widget.delegate.isEmpty && widget.room.isEmpty) {
          await uploadNoLastRegistration(
                  tempId,
                  widget.userDetails.first.personName,
                  widget.userDetails.first.personEmail,
                  widget.userDetails.first.personMobile,
                  widget.userDetails.first.personEmail,
                  widget.userDetails.first.personMobile,
                  widget.userDetails.first.orgMobile,
                  widget.userDetails.first.orgEmail)
              .then((value) {
            if (value == 1) {
              Future(
                () {
                  for (int n = 0; n < widget.booth.length; n++) {
                    uploadBoothData(widget.data, widget.booth[n].toString(),
                        widget.userDetails, (n + 1));
                  }
                },
              ).then((value) {
                Fluttertoast.showToast(
                  msg: "Registration Successful",
                  textColor: Colors.white,
                  backgroundColor: Colors.green,
                );
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const NavigationScreen()),
                    (route) => false);
              });
              print('no empty');
            }
            if (value == 0) {
              Fluttertoast.showToast(
                msg: "Registration Failed",
                textColor: Colors.white,
                backgroundColor: Colors.red,
              );
              Navigator.of(context).pop();
            }
          });
          print('12 empty');
        } else if (widget.room.isEmpty && widget.booth.isEmpty) {
          await uploadNoLastRegistration(
                  tempId,
                  widget.userDetails.first.personName,
                  widget.userDetails.first.personEmail,
                  widget.userDetails.first.personMobile,
                  widget.userDetails.first.personEmail,
                  widget.userDetails.first.personMobile,
                  widget.userDetails.first.orgMobile,
                  widget.userDetails.first.orgEmail)
              .then((value) {
            if (value == 1) {
              Future(
                () {
                  for (int n = 0; n < widget.delegate.length; n++) {
                    File newFile = File(widget.delegate[n].image.toString());
                    Random random = Random();
                    int min = 100;
                    int max = 999;
                    int randomNumber = random.nextInt(max - min);
                    String tempId1 = 'CORCON/2022/22-23/$randomNumber';
                    sendDelegateList(
                        tempId,
                        '${n + 1}',
                        widget.delegate[n].name,
                        widget.delegate[n].image,
                        widget.delegate[n].email,
                        widget.delegate[n].mobile,
                        widget.delegate[n].admin.contains('Admin')
                            ? 'AdminDelegate'
                            : 'Delegate',
                        newFile);
                  }
                },
              ).then((value) {
                Fluttertoast.showToast(
                  msg: "Registration Successful",
                  textColor: Colors.white,
                  backgroundColor: Colors.green,
                );
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const NavigationScreen()),
                    (route) => false);
              });
              print('no empty');
            }
            if (value == 0) {
              Fluttertoast.showToast(
                msg: "Registration Failed",
                textColor: Colors.white,
                backgroundColor: Colors.red,
              );
              Navigator.of(context).pop();
            }
          });
          print('23 empty');
        } else if (widget.delegate.isEmpty && widget.booth.isEmpty) {
          await uploadNoLastRegistration(
                  tempId,
                  widget.userDetails.first.personName,
                  widget.userDetails.first.personEmail,
                  widget.userDetails.first.personMobile,
                  widget.userDetails.first.personEmail,
                  widget.userDetails.first.personMobile,
                  widget.userDetails.first.orgMobile,
                  widget.userDetails.first.orgEmail)
              .then((value) {
            if (value == 1) {
              Future(
                () {
                  for (int n = 0; n < widget.room.length; n++) {
                    sendRoomList(
                        tempId,
                        widget.room[n].roomNo,
                        widget.room[n].name,
                        widget.room[n].email,
                        widget.room[n].mobile);
                  }
                },
              ).then((value) {
                Fluttertoast.showToast(
                  msg: "Registration Successful",
                  textColor: Colors.white,
                  backgroundColor: Colors.green,
                );
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const NavigationScreen()),
                    (route) => false);
              });
              print('no empty');
            }
            if (value == 0) {
              Fluttertoast.showToast(
                msg: "Registration Failed",
                textColor: Colors.white,
                backgroundColor: Colors.red,
              );
              Navigator.of(context).pop();
            }
          });
          print('13 empty');
        } else {
          await uploadNoLastRegistration(
                  tempId,
                  widget.userDetails.first.personName,
                  widget.userDetails.first.personEmail,
                  widget.userDetails.first.personMobile,
                  widget.userDetails.first.personEmail,
                  widget.userDetails.first.personMobile,
                  widget.userDetails.first.orgMobile,
                  widget.userDetails.first.orgEmail)
              .then((value) {
            if (value == 1) {
              Future(
                () {
                  for (int n = 0; n < widget.booth.length; n++) {
                    uploadBoothData(widget.data, widget.booth[n].toString(),
                        widget.userDetails, (n + 1));
                  }
                  for (int n = 0; n < widget.delegate.length; n++) {
                    File newFile = File(widget.delegate[n].image.toString());
                    Random random = Random();
                    int min = 100;
                    int max = 999;
                    int randomNumber = random.nextInt(max - min);
                    String tempId1 = 'CORCON/2022/22-23/$randomNumber';
                    sendDelegateList(
                        tempId,
                        '${n + 1}',
                        widget.delegate[n].name,
                        widget.delegate[n].image,
                        widget.delegate[n].email,
                        widget.delegate[n].mobile,
                        widget.delegate[n].admin.contains('Admin')
                            ? 'AdminDelegate'
                            : 'Delegate',
                        newFile);
                  }
                  for (int n = 0; n < widget.room.length; n++) {
                    sendRoomList(
                        tempId,
                        widget.room[n].roomNo,
                        widget.room[n].name,
                        widget.room[n].email,
                        widget.room[n].mobile);
                  }
                },
              ).then((value) {
                Fluttertoast.showToast(
                  msg: "Registration Successful",
                  textColor: Colors.white,
                  backgroundColor: Colors.green,
                );
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const NavigationScreen()),
                    (route) => false);
              });
              print('no empty');
            }
            if (value == 0) {
              Fluttertoast.showToast(
                msg: "Registration Failed",
                textColor: Colors.white,
                backgroundColor: Colors.red,
              );
              Navigator.of(context).pop();
            }
          });
          print('no empty');
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(errorTitle),
      content: Text(errorMessage),
      actions: [cancelButton, okButton],
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
            child: const Text("Please wait..."),
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
}
