import 'dart:convert';

import 'package:farmboss_dashboard/components/app_constants.dart';
import 'package:farmboss_dashboard/farm_global_class.dart';
import 'package:farmboss_dashboard/models/producer_model.dart';
import 'package:farmboss_dashboard/tableDataSources/producerDataSource.dart';
import 'package:farmboss_dashboard/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProducerDetailsPage extends StatefulWidget {
  const ProducerDetailsPage({super.key});

  @override
  State<ProducerDetailsPage> createState() => _ProducerDetailsPageState();
}

class _ProducerDetailsPageState extends State<ProducerDetailsPage> {
  ProducerDataSource? producerDataSource;
  List<ProducerModel> producerModel = <ProducerModel>[];
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
    producerModel = [];
    print('todayDate::$todayDate');
    // todayDate = '2021-07-07';
    String tlvPkt =
        "select fusertbl.usrid,usrname,regdt,mobno,profimg,review from farmboss.producer_profiletbl,farmboss.fusertbl where producer_profiletbl.pusrid=fusertbl.usrid";
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
            Map<String, dynamic> producerMap = json.decode(response.body);
            print("producerMap:$producerMap");
            var usrid = producerMap['1'];
            var usrname = producerMap['2'];
            var regdt = producerMap['3'];
            var mobno = producerMap['4'];
            var profimg = producerMap['5'];
            var review = producerMap['6'];

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

              producerModel.add(ProducerModel(
                  producerID: id,
                  producerName: name,
                  registrationDate: regdt,
                  mobileNo: mobno,
                  profileImage: profimg,
                  reviews: review));
            }

            producerDataSource =
                ProducerDataSource(producerData: producerModel);
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
                              'Producers Details',
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
                            if (producerDataSource != null)
                              Visibility(
                                visible: _showData,
                                child: Expanded(
                                    child: Card(
                                  child: SfDataGrid(
                                    columnWidthMode:
                                        ColumnWidthMode.lastColumnFill,
                                    source: producerDataSource!,
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
                                            child: const Text('Producer Name'),
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
                                      final ProducerID =
                                          producerModel[index].producerID;
                                      print("ConsumerID$ProducerID");
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
