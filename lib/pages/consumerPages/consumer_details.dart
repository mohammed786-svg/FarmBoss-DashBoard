// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:farmboss_dashboard/components/app_constants.dart';
import 'package:farmboss_dashboard/farm_global_class.dart';
import 'package:farmboss_dashboard/models/consumers_model.dart';
import 'package:farmboss_dashboard/tableDataSources/consumerDataSource.dart';
import 'package:farmboss_dashboard/widgets/app_styles.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ConsumerDetailsPage extends StatefulWidget {
  const ConsumerDetailsPage({Key? key}) : super(key: key);

  @override
  State<ConsumerDetailsPage> createState() => _ConsumerDetailsPageState();
}

class _ConsumerDetailsPageState extends State<ConsumerDetailsPage> {
  ConsumerDataSource? consumerDataSource;
  List<ConsumerModel> consumerModel = <ConsumerModel>[];
  final DataGridController _consumerController = DataGridController();
  bool _isLoading = true, _showData = false, _showError = false;
  List _usridLst = [],
      _usrnameLst = [],
      _regdtLst = [],
      _mobnoLst = [],
      _profimgLst = [],
      _reviewLst = [];

  getConsumersAsync() async {
    String url = FarmGlb.endPoint;
    var todayDate = FarmGlb.getTodaysDate();
    //consumerDataSource = null;
    consumerModel = [];
    print('todayDate::$todayDate');
    // todayDate = '2021-07-07';
    String tlvPkt =
        "select fusertbl.usrid,usrname,regdt,mobno,profimg,review from farmboss.consumer_profiletbl,farmboss.fusertbl where consumer_profiletbl.usrid=fusertbl.usrid";
    final Map dict = {"tlvNo": "709", "query": tlvPkt, "uid": "-1"};

    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            "Accept": "application/json",
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(dict));

      if (response.statusCode == 200) {
        var res = response.body;
        if (res.contains("ErrorCode#2")) {
          setState(() {
            _isLoading = false;
          });
          FarmGlb.showToast('No Home Work Found');
          return;
        } else if (res.contains("ErrorCode#8")) {
          FarmGlb.showToast('Something Went Wrong');
          return;
        } else {
          try {
            Map<String, dynamic> consumerMap = json.decode(response.body);
            print("consumerMap:$consumerMap");
            var usrid = consumerMap['1'];
            var usrname = consumerMap['2'];
            var regdt = consumerMap['3'];
            var mobno = consumerMap['4'];
            var profimg = consumerMap['5'];
            var review = consumerMap['6'];

            _usridLst = usrid.toString().split(",");
            _usrnameLst = usrname.toString().split(",");
            _regdtLst = regdt.toString().split(",");
            _mobnoLst = mobno.toString().split(",");
            _profimgLst = profimg.toString().split(",");
            _reviewLst = review.toString().split(",");

            for (var i = 0; i < _usridLst.length; i++) {
              var id = _usridLst.elementAt(i).toString();
              var name = _usrnameLst.elementAt(i).toString();
              var regdt = _regdtLst.elementAt(i).toString();
              var mobno = _mobnoLst.elementAt(i).toString();
              var profimg = _profimgLst.elementAt(i).toString();
              var review = _reviewLst.elementAt(i).toString();

              consumerModel.add(ConsumerModel(
                  consumerID: id,
                  consumerName: name,
                  registrationDate: regdt,
                  mobileNo: mobno,
                  profileImage: profimg,
                  reviews: review));
            }

            consumerDataSource =
                ConsumerDataSource(consumerData: consumerModel);
            setState(() {
              _isLoading = false;
              _showData = true;
            });
          } catch (e) {
            print(e);
            return "Failed";
          }
        }
      }
    } catch (e) {
      print("handle Exception here::$e");
      if (e.toString().contains("XMLHttpRequest")) {
        print('no net handle here');
        setState(() {
          ErrorMessage = "No Internet Connection Found";
          _isLoading = false;
          _showError = true;
        });
        return;
      }
      setState(() {
        _isLoading = false;
        if (e.toString().contains("Connection refused")) {
          FarmGlb.showSnackBar(
              context, 'No Internet Connection Found / Server is Down');
        } else if (e.toString().contains("Operation timed out")) {
          FarmGlb.showSnackBar(context, 'Operation Timed Out');
        }
      });
    }
    return "Success";
  }

  var ErrorMessage = "";

  @override
  void initState() {
    super.initState();
    getConsumersAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showError == true
          ? Visibility(
              visible: _showError,
              child: Center(
                child: Text(
                  ErrorMessage,
                  style: ralewayStyle.copyWith(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: kSpacing,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Consumer Details',
                              style: ralewayStyle.copyWith(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: kSpacing,
                        ),
                        Visibility(
                          visible: _isLoading,
                          child: Container(
                            alignment: Alignment.topCenter,
                            margin: const EdgeInsets.all(20),
                            child: const LinearProgressIndicator(
                              backgroundColor: Color.fromARGB(255, 255, 74, 64),
                              valueColor: AlwaysStoppedAnimation(
                                  Color.fromARGB(255, 55, 244, 26)),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            if (consumerDataSource != null)
                              Visibility(
                                visible: _showData,
                                child: Expanded(
                                    child: Card(
                                  child: SfDataGrid(
                                    columnWidthMode:
                                        ColumnWidthMode.lastColumnFill,
                                    source: consumerDataSource!,
                                    columns: <GridColumn>[
                                      GridColumn(
                                          width: 100,
                                          columnName: 'profimg',
                                          label: Container(
                                            padding: const EdgeInsets.all(16.0),
                                            alignment: Alignment.center,
                                            child: const Text('Profile'),
                                          )),
                                      GridColumn(
                                          columnName: 'id',
                                          width: 80,
                                          label: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                'ID',
                                              ))),
                                      GridColumn(
                                          width: 200,
                                          columnName: 'name',
                                          label: Container(
                                            padding: const EdgeInsets.all(16.0),
                                            alignment: Alignment.center,
                                            child: const Text('Consumer Name'),
                                          )),
                                      GridColumn(
                                          width: 200,
                                          columnName: 'regdt',
                                          label: Container(
                                            padding: const EdgeInsets.all(16.0),
                                            alignment: Alignment.center,
                                            child:
                                                const Text('Registrated Date'),
                                          )),
                                      GridColumn(
                                          columnName: 'mobno',
                                          label: Container(
                                            padding: const EdgeInsets.all(16.0),
                                            alignment: Alignment.center,
                                            child: const Text('Phone Number'),
                                          )),
                                      GridColumn(
                                          width: 100,
                                          columnName: 'review',
                                          label: Container(
                                            padding: const EdgeInsets.all(16.0),
                                            alignment: Alignment.center,
                                            child: const Text('Reviews'),
                                          )),
                                    ],
                                    controller: _consumerController,
                                    selectionMode: SelectionMode.single,
                                    onSelectionChanged:
                                        (List<DataGridRow> addedRows,
                                            List<DataGridRow> removedRows) {
                                      var index =
                                          _consumerController.selectedIndex;
                                      final ConsumerID =
                                          consumerModel[index].consumerID;
                                      print("ConsumerID$ConsumerID");
                                    },
                                  ),
                                )),
                              )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
    );
  }
}
