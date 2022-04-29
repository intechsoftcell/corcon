import 'package:corcon/model/booth_details_model.dart';
import 'package:corcon/screens/add_deletegate_screen.dart';
import 'package:corcon/screens/last_registration_screen.dart';
import 'package:corcon/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SymposiaUserDetails {
  String personName,
      personMobile,
      personEmail,
      orgMobile,
      orgEmail,
      accomodationType;
  SymposiaUserDetails(
      {required this.personName,
      required this.personMobile,
      required this.personEmail,
      required this.orgMobile,
      required this.orgEmail,
      required this.accomodationType});
}

class OpportunitySecondScreen extends StatefulWidget {
  String personName,
      personMobile,
      personEmail,
      orgMobile,
      orgEmail,
      accomodationType;
  Map<String, String> supportName;
  OpportunitySecondScreen(
      {Key? key,
      required this.supportName,
      required this.personName,
      required this.personMobile,
      required this.personEmail,
      required this.orgMobile,
      required this.orgEmail,
      required this.accomodationType})
      : super(key: key);

  @override
  State<OpportunitySecondScreen> createState() =>
      _OpportunitySecondScreenState();
}

class _OpportunitySecondScreenState extends State<OpportunitySecondScreen> {
  List<String> hallList = ['Stall 1', 'Stall 2', 'Stall 3'];
  int _selectedIndex = 0;
  List<int> selectedIndex1 = [];
  List<int> selectedIndex2 = [];
  List<int> selectedIndex3 = [];
  List<int> selectedIndex4 = [];
  List<int> selectedIndex5 = [];
  List<int> selectedIndex6 = [];
  List<String> boothBookedList = [];

  int initialCount = 0;

  bool hall1Visible = true;
  bool hall2Visible = false;
  bool hall3Visible = false;

  Future<List<String>> hall1FirstData() async {
    List<String> hall1First = [];
    for (int i = 12; i > 0; i--) {
      hall1First.add('A$i');
      if (hall1First.length == 12) {
        break;
      }
    }
    return hall1First;
  }

  Future<List<String>> hall2FirstData() async {
    List<String> hall2First = [];
    for (int i = 12; i > 0; i--) {
      hall2First.add('B$i');
      if (hall2First.length == 12) {
        break;
      }
    }
    return hall2First;
  }

  Future<List<String>> hall3FirstData() async {
    List<String> hall1First = [];
    for (int i = 12; i > 0; i--) {
      hall1First.add('C$i');
      if (hall1First.length == 12) {
        break;
      }
    }
    return hall1First;
  }

  Future<List<String>> hall4FirstData() async {
    List<String> hall2First = [];
    for (int i = 12; i > 0; i--) {
      hall2First.add('D$i');
      if (hall2First.length == 12) {
        break;
      }
    }
    return hall2First;
  }

  Future<List<String>> hall5FirstData() async {
    List<String> hall1First = [];
    for (int i = 12; i > 0; i--) {
      hall1First.add('G$i');
      if (hall1First.length == 12) {
        break;
      }
    }
    return hall1First;
  }

  Future<List<String>> hall6FirstData() async {
    List<String> hall2First = [];
    for (int i = 12; i > 0; i--) {
      hall2First.add('H$i');
      if (hall2First.length == 12) {
        break;
      }
    }
    return hall2First;
  }

  Future<List<BoothDetailsModel>> getBoothDetails() async {
    List<BoothDetailsModel> newData = [];
    var url = Uri.parse('${baseUrl}GetBoothDetails');
    var response = await http.post(url);
    for (int i = 0; i < response.body.length; i++) {
      newData.add(boothDetailsModelFromJson(response.body));
    }
    return newData;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<List<BoothDetailsModel>>(
          future: getBoothDetails(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return SingleChildScrollView(
                physics: const ScrollPhysics(),
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
                                child: const Icon(
                                    Icons.arrow_back_ios_new_outlined),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 30,
                                ),
                                child: SizedBox(
                                  width: size.width * 0.6,
                                  child: const Text(
                                    'Select Booth',
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
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          itemCount: hallList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                                if (index == 0) {
                                  hall1Visible = true;
                                  hall2Visible = false;
                                  hall3Visible = false;
                                }
                                if (index == 1) {
                                  hall1Visible = false;
                                  hall2Visible = true;
                                  hall3Visible = false;
                                }
                                if (index == 2) {
                                  hall1Visible = false;
                                  hall2Visible = false;
                                  hall3Visible = true;
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: _selectedIndex == index
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1,
                                  ),
                                  color: _selectedIndex == index
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    hallList[index],
                                    style: TextStyle(
                                      color: _selectedIndex == index
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      stallWidget(
                          size,
                          hall1Visible,
                          hall1FirstData(),
                          snapshot.data!.first.dtqty,
                          hall2FirstData(),
                          selectedIndex1,
                          selectedIndex2),
                      stallWidget(
                          size,
                          hall2Visible,
                          hall3FirstData(),
                          snapshot.data!.first.dtqty,
                          hall4FirstData(),
                          selectedIndex3,
                          selectedIndex4),
                      stallWidget(
                          size,
                          hall3Visible,
                          hall5FirstData(),
                          snapshot.data!.first.dtqty,
                          hall6FirstData(),
                          selectedIndex5,
                          selectedIndex6),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (widget.supportName['count'].toString() ==
                                  '0') {
                                List<SymposiaUserDetails> sympoList = [];
                                SymposiaUserDetails symposiaUserDetails =
                                    SymposiaUserDetails(
                                        personName: widget.personName,
                                        personMobile: widget.personMobile,
                                        personEmail: widget.personEmail,
                                        orgMobile: widget.orgMobile,
                                        orgEmail: widget.orgEmail,
                                        accomodationType:
                                            widget.accomodationType);
                                sympoList.add(symposiaUserDetails);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LastRegistrationScreen(
                                      data: widget.supportName,
                                      booth: const [],
                                      userDetails: sympoList,
                                      delegate: const [],
                                      room: const [],
                                    ),
                                  ),
                                );
                              } else {
                                List<SymposiaUserDetails> sympoList = [];
                                SymposiaUserDetails symposiaUserDetails =
                                    SymposiaUserDetails(
                                        personName: widget.personName,
                                        personMobile: widget.personMobile,
                                        personEmail: widget.personEmail,
                                        orgMobile: widget.orgMobile,
                                        orgEmail: widget.orgEmail,
                                        accomodationType:
                                            widget.accomodationType);
                                sympoList.add(symposiaUserDetails);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => AddDelegateScreen(
                                      data: widget.supportName,
                                      booth: const [],
                                      userDetails: sympoList,
                                    ),
                                  ),
                                );
                              }
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
                              if (widget.supportName['count'].toString() ==
                                  '0') {
                                List<SymposiaUserDetails> sympoList = [];
                                SymposiaUserDetails symposiaUserDetails =
                                    SymposiaUserDetails(
                                        personName: widget.personName,
                                        personMobile: widget.personMobile,
                                        personEmail: widget.personEmail,
                                        orgMobile: widget.orgMobile,
                                        orgEmail: widget.orgEmail,
                                        accomodationType:
                                            widget.accomodationType);
                                sympoList.add(symposiaUserDetails);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LastRegistrationScreen(
                                      data: widget.supportName,
                                      booth: boothBookedList,
                                      userDetails: sympoList,
                                      delegate: const [],
                                      room: const [],
                                    ),
                                  ),
                                );
                              } else {
                                if (initialCount == 0) {
                                  showErrorMessage(context, 'No Stall Selected',
                                      'Please select 1 stall to proceed or you can skip and add the stall later.');
                                } else {
                                  List<SymposiaUserDetails> sympoList = [];
                                  SymposiaUserDetails symposiaUserDetails =
                                      SymposiaUserDetails(
                                          personName: widget.personName,
                                          personMobile: widget.personMobile,
                                          personEmail: widget.personEmail,
                                          orgMobile: widget.orgMobile,
                                          orgEmail: widget.orgEmail,
                                          accomodationType:
                                              widget.accomodationType);
                                  sympoList.add(symposiaUserDetails);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddDelegateScreen(
                                          data: widget.supportName,
                                          booth: boothBookedList,
                                          userDetails: sympoList),
                                    ),
                                  );
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
              );
            } else {
              return SizedBox(
                width: size.width,
                height: size.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }

  Widget stallWidget(
      Size size,
      bool hallVisible,
      Future<List<String>> hallFuture1,
      List<Dtqty> listData1,
      Future<List<String>> hallFuture2,
      List<int> selectIndex1,
      List<int> selectIndex2) {
    List<String> occupiedList = [];
    for (int n = 0; n < listData1.length; n++) {
      occupiedList.add(listData1[n].boothName);
    }
    return Visibility(
      visible: hallVisible,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            // height: size.height * 0.9,
            // width: 100,
            child: SizedBox(
              // color: Colors.indigo,
              width: 100,
              child: FutureBuilder(
                future: hallFuture1,
                builder: (context, snapshot) {
                  final data =
                      snapshot.data == null ? [] : snapshot.data as List;
                  return ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: InkWell(
                          onTap: () {
                            if (!occupiedList.contains(data[index])) {
                              if (!selectIndex1.contains(index)) {
                                if (initialCount == 1) {
                                  setState(() {
                                    showDataDialog(
                                        context,
                                        'Extra Stall',
                                        'Are you sure you want to add more stall? They might increase charges.',
                                        selectIndex1,
                                        index,
                                        data);
                                  });
                                } else {
                                  initialCount += 1;
                                  setState(() {
                                    selectIndex1.add(index);
                                    boothBookedList.add(data[index]);
                                  });
                                }
                              }
                            } else {
                              showErrorMessage(context, 'Occupied Already!',
                                  'This stall has been occupied already please choose another stall');
                            }
                          },
                          child: Row(
                            children: [
                              // !selectIndex1.contains(index)
                              occupiedList.contains(data[index])
                                  ? const Icon(
                                      Icons.store_mall_directory,
                                      color: Colors.red,
                                      size: 32,
                                    )
                                  : (!selectIndex1.contains(index)
                                      ? const Icon(
                                          Icons.store_mall_directory_outlined,
                                          size: 32,
                                        )
                                      : const Icon(
                                          Icons.store_mall_directory,
                                          color: Colors.green,
                                          size: 32,
                                        )),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(data[index]),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Flexible(
            flex: 1,
            // height: size.height * 0.9,

            child: SizedBox(
              width: 100,
              child: FutureBuilder(
                future: hallFuture2,
                builder: (context, snapshot) {
                  final data =
                      snapshot.data == null ? [] : snapshot.data as List;
                  return ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: InkWell(
                          onTap: () {
                            if (!occupiedList.contains(data[index])) {
                              if (!selectIndex2.contains(index)) {
                                if (initialCount == 1) {
                                  setState(() {
                                    showDataDialog(
                                        context,
                                        'Extra Stall',
                                        'Are you sure you want to add more stall? They might increase charges.',
                                        selectIndex2,
                                        index,
                                        data);
                                  });
                                } else {
                                  initialCount += 1;
                                  setState(() {
                                    selectIndex2.add(index);
                                    boothBookedList.add(data[index]);
                                  });
                                }
                              }
                            } else {
                              showErrorMessage(context, 'Occupied Already!',
                                  'This stall has been occupied already please choose another stall');
                            }
                          },
                          child: Row(
                            children: [
                              occupiedList.contains(data[index])
                                  ? const Icon(
                                      Icons.store_mall_directory,
                                      color: Colors.red,
                                      size: 32,
                                    )
                                  : (!selectIndex2.contains(index)
                                      ? const Icon(
                                          Icons.store_mall_directory_outlined,
                                          size: 32,
                                        )
                                      : const Icon(
                                          Icons.store_mall_directory,
                                          color: Colors.green,
                                          size: 32,
                                        )),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(data[index]),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
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

  showDataDialog(BuildContext context, String titleDialog, String msgDialog,
      List<int> selectIndex2, int index, List data) {
    Widget okButton = TextButton(
      child: const Text("Okay"),
      onPressed: () async {
        initialCount += 1;
        setState(() {
          selectIndex2.add(index);
          boothBookedList.add(data[index]);
        });
        Navigator.of(context).pop();
      },
    );

    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () async {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(titleDialog),
      content: Text(msgDialog),
      actions: [cancelButton, okButton],
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
