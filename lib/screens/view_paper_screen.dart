import 'package:corcon/model/view_paper_model.dart';
import 'package:corcon/utils/common.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ViewPaperScreen extends StatefulWidget {
  const ViewPaperScreen({Key? key}) : super(key: key);

  @override
  State<ViewPaperScreen> createState() => _ViewPaperScreenState();
}

class _ViewPaperScreenState extends State<ViewPaperScreen> {
  List listData = [
    'SrNo',
    'Name of Person',
    'Symposia Name',
    'Paper Name',
    'Status',
    'Stage'
  ];

  List<ViewPaperModel> valueData = [];

  Future<List<ViewPaperModel>> getPaperDetails(
      String regId, String username, String type) async {
    List<ViewPaperModel> mList = [];
    var url = Uri.parse('${baseUrl}GetPaperDetails');
    var response = await http
        .post(url, body: {'regId': regId, 'username': username, 'type': type});
    for (int i = 0; i < response.body.length; i++) {
      mList.add(viewPaperModelFromJson(response.body));
    }
    return mList;
  }

  bool isAvailable = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                top: 50,
                right: 20,
              ),
              child: Row(
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
                          "View Paper",
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
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: DropdownSearch<dynamic>(
                selectedItem: "Select",
                dropdownSearchDecoration: const InputDecoration(
                  labelText: "Select Category",
                ),
                onChanged: (e) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String regId = prefs.getString("REG_ID")!;
                  String username = prefs.getString("USERID")!;
                  valueData.clear();
                  valueData =
                      await getPaperDetails(regId, username, e.toString());
                  if (valueData.isNotEmpty) {
                    isAvailable = true;
                  }
                  setState(() {});
                },
                showSearchBox: true,
                items: const [
                  "Select Category",
                  "Abstract",
                  "Final Paper",
                  "Presentation"
                ],
                validator: (value) {
                  if (value == 'Select') {
                    return "Symposia Name Required";
                  }
                  return null;
                },
              ),
            ),
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: isAvailable ? valueData.first.dtqty.length : 0,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                if (valueData.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => PaperDetailScreen(
                        //         data: valueData.first.dtqty[index]),
                        //   ),
                        // );
                      },
                      child: Card(
                        child: ListTile(
                          leading: Text('${index + 1}'),
                          title: Text(
                            'IAF: ${valueData.first.dtqty[index].iaf}',
                            // overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Paper Title: ${valueData.first.dtqty[index].paperName}\nName of Person : ${valueData.first.dtqty[index].uploadedBy}\nStatus: ${valueData.first.dtqty[index].status}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
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
      ),
    );
  }
}
