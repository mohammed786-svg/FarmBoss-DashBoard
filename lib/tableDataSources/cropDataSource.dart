import 'package:farmboss_dashboard/models/consumers_model.dart';
import 'package:farmboss_dashboard/models/cropModel.dart';
import 'package:farmboss_dashboard/models/producer_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CropDataSource extends DataGridSource {
  CropDataSource({required this.cropData}) {
    updateDataGridRow();
  }

  void updateDataGridRow() {
    _dataGridRow = cropData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'link', value: e.cropLink),
              DataGridCell<String>(columnName: 'id', value: e.cropID),
              DataGridCell<String>(columnName: 'name', value: e.cropName),
            ]))
        .toList();
  }

  List<DataGridRow> _dataGridRow = [];
  List<CropModel> cropData = [];

  @override
  List<DataGridRow> get rows => _dataGridRow;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(42.0),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(row.getCells()[0].value.toString()),
            )),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[1].value.toString()),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[2].value),
      ),
      /* Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[3].value.toString()),
      ), */

      /*Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Checkbox(
            value: row.getCells()[3].value,
            onChanged: (value) {
              print(value);

              final index = _dataGridRow.indexOf(row);
              print("index:$index");
              employeeData[index].isAvailable = value!;
              print("orgName::${employeeData[index].orgname}");
              PFGlb.orgId = employeeData[index].id;
              PFGlb.orgName = employeeData[index].orgname;
              //PFGlb.curOrg = PFGlb.orgName;
              print("orgnammmIDset:${PFGlb.orgId}");

              curOrangzt = "Current Organization Name : ${PFGlb.orgName}";

              row.getCells()[3] =
                  DataGridCell(value: value, columnName: 'isAvailable');
              notifyDataSourceListeners(
                  rowColumnIndex: RowColumnIndex(index, 3));
            },
          ))*/
    ]);
  }
}
