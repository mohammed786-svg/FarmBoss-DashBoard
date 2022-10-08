import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:farmboss_dashboard/components/app_constants.dart';
import 'package:flutter/material.dart';

class Search_Field extends StatelessWidget {
  Search_Field({Key? key, required this.onSearch, this.hintText})
      : super(key: key);
  final controller = TextEditingController();
  final Function(String value) onSearch;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(EvaIcons.search),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: .1),
        ),
        hintText: hintText ?? "search..",
      ),
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        if (onSearch != null) onSearch(controller.text);
      },
      textInputAction: TextInputAction.search,
      style: TextStyle(
        color: kFontColorPallets[1],
      ),
    );
  }
}
