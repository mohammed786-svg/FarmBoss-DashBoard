import 'dart:convert';

import 'package:farmboss_dashboard/constants/app_constants.dart';
import 'package:farmboss_dashboard/farm_global_class.dart';
import 'package:farmboss_dashboard/models/consumers_model.dart';
import 'package:farmboss_dashboard/models/cropModel.dart';
import 'package:farmboss_dashboard/tableDataSources/cropDataSource.dart';
import 'package:farmboss_dashboard/utils/app_colors.dart';
import 'package:farmboss_dashboard/widgets/app_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart' as http;

class CropDetailsPage extends StatefulWidget {
  const CropDetailsPage({Key? key}) : super(key: key);

  @override
  State<CropDetailsPage> createState() => _CropDetailsPageState();
}

class _CropDetailsPageState extends State<CropDetailsPage> {
  CropDataSource? cropDataSource;

  List<CropModel> cropModel = <CropModel>[];

  final DataGridController _cropController = DataGridController();

  bool _isLoading = true, _showData = false, _showError = false;

  List _cropIDLst = [], _cropNameLst = [], _cropTypeLst = [], _linkLst = [];

  getCropAsync() async {
    String url = FarmGlb.endPoint;
    var todayDate = FarmGlb.getTodaysDate();
    //consumerDataSource = null;
    cropModel = [];
    print('todayDate::$todayDate');
    // todayDate = '2021-07-07';
    String tlvPkt =
        "select cropid,cropname,croptype,link from farmboss.croptbl order by cropid";
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
            Map<String, dynamic> cropMap = json.decode(response.body);
            print("consumerMap:$cropMap");
            var cropid = cropMap['1'];
            var cropname = cropMap['2'];
            var croptype = cropMap['3'];
            var link = cropMap['4'];

            _cropIDLst = cropid.toString().split(",");
            _cropNameLst = cropname.toString().split(",");
            _cropTypeLst = croptype.toString().split(",");
            _linkLst = link.toString().split(",");

            for (var i = 0; i < _cropIDLst.length; i++) {
              var id = _cropIDLst.elementAt(i).toString();
              var name = _cropNameLst.elementAt(i).toString();
              var type = _cropTypeLst.elementAt(i).toString();
              var link = _linkLst.elementAt(i).toString();

              cropModel
                  .add(CropModel(cropName: name, cropID: id, cropLink: link));
            }

            cropDataSource = CropDataSource(cropData: cropModel);
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
    getCropAsync();
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
                  scrollDirection: Axis.vertical,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: kSpacing,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kSpacing),
                            child: Text('Crop Management',
                                style: ralewayStyle.copyWith(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                )),
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
                                backgroundColor:
                                    Color.fromARGB(255, 255, 74, 64),
                                valueColor: AlwaysStoppedAnimation(
                                    Color.fromARGB(255, 55, 244, 26)),
                              ),
                            ),
                          ),
                          if (cropDataSource != null)
                            Row(
                              children: [
                                Visibility(
                                  visible: _showData,
                                  child: SizedBox(
                                    width: 800,
                                    child: Center(
                                      child: Card(
                                        child: SfDataGrid(
                                          columnWidthMode:
                                              ColumnWidthMode.lastColumnFill,
                                          source: cropDataSource!,
                                          columns: <GridColumn>[
                                            GridColumn(
                                                width: 200,
                                                columnName: 'link',
                                                label: Container(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  alignment: Alignment.center,
                                                  child: const Text('Profile'),
                                                )),
                                            GridColumn(
                                                columnName: 'id',
                                                width: 200,
                                                label: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 16.0),
                                                    alignment: Alignment.center,
                                                    child: const Text(
                                                      'Crop ID',
                                                    ))),
                                            GridColumn(
                                                width: 400,
                                                columnName: 'name',
                                                label: Container(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  alignment: Alignment.center,
                                                  child:
                                                      const Text('Crop Name'),
                                                )),
                                          ],
                                          controller: _cropController,
                                          selectionMode: SelectionMode.single,
                                          onSelectionChanged: (List<DataGridRow>
                                                  addedRows,
                                              List<DataGridRow> removedRows) {
                                            var index =
                                                _cropController.selectedIndex;
                                            final CropID =
                                                cropModel[index].cropID;
                                            print("CropID$CropID");
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(
                            height: kSpacing,
                          ),
                          _AddNewCropDetails(),
                          const SizedBox(
                            height: kSpacing,
                          ),
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}

class _AddNewCropDetails extends StatelessWidget {
  const _AddNewCropDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _cropNameController = TextEditingController();
    TextEditingController _cropTypeController = TextEditingController();
    TextEditingController _cropDescptionController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Add New Crop Details Here',
              style: ralewayStyle.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: kSpacing,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50.0,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: AppColors.whiteColor,
                  ),
                  child: CustomTextField(
                      controllerName: _cropNameController,
                      hintText: 'Enter Crop Name'),
                ),
                const SizedBox(
                  width: kSpacing,
                ),
                Container(
                  height: 50.0,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: AppColors.whiteColor,
                  ),
                  child: CustomTextField(
                      controllerName: _cropTypeController,
                      hintText: 'Enter Crop Type'),
                ),
              ],
            ),
            const SizedBox(
              height: kSpacing,
            ),
            Row(
              children: [
                Container(
                  height: 200.0,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: AppColors.whiteColor,
                  ),
                  child: CustomTextField(
                      controllerName: _cropDescptionController,
                      hintText: 'Enter Crop Description'),
                ),
                const SizedBox(
                  width: kSpacing,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      _pickFile();
                      //Navigator.pushReplacementNamed(context, MainRoute);
                    },
                    borderRadius: BorderRadius.circular(16.0),
                    child: Ink(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70.0, vertical: 18.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Color.fromARGB(255, 134, 255, 227)),
                      child: Text(
                        'Upload Image',
                        style: ralewayStyle.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.whiteColor,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: kSpacing,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  //Navigator.pushReplacementNamed(context, MainRoute);
                },
                borderRadius: BorderRadius.circular(16.0),
                child: Ink(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 70.0, vertical: 18.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: AppColors.mainBlueColor),
                  child: Text(
                    'Add Crop',
                    style: ralewayStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.whiteColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _pickFile() async {
  // opens storage to pick files and the picked file or files
  // are assigned into result and if no file is chosen result is null.
  // you can also toggle "allowMultiple" true or false depending on your need
  final result = await FilePicker.platform.pickFiles(allowMultiple: false);

  // if no file is picked
  if (result == null) return;

  // we will log the name, size and path of the
  // first picked file (if multiple are selected)
  print(result.files.first.name);
  print(result.files.first.size);
  //print(result.files.first.path);
  //print(result.files.first.bytes);
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controllerName,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController controllerName;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: controllerName,
      style: ralewayStyle.copyWith(
          fontWeight: FontWeight.w400,
          color: AppColors.blueDarkColor,
          fontSize: 12.0),
      decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.eco_sharp),
          ),
          contentPadding: EdgeInsets.only(top: 16.0),
          hintText: hintText,
          hintStyle: ralewayStyle.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.blueDarkColor.withOpacity(0.5),
              fontSize: 12.0)),
    );
  }
}
