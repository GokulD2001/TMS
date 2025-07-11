import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class SingleSelectDropDownMVC extends StatefulWidget {
  final List<Map<String, dynamic>> dropdownItems;
  final String dropDownName;
  final bool optionalisEmpty;
  final String star;
  final Function(String) onChanged;
  final Function(String?) onSaved;
  final String? selectedId;
  final bool clearButtonProps;
  final bool isEnabled;
  final TextStyle? labelStyle;

  const SingleSelectDropDownMVC({
    Key? key,
    required this.selectedId,
    required this.dropdownItems,
    required this.dropDownName,
    required this.onChanged,
    required this.onSaved,
    required this.star,
    required this.optionalisEmpty,
    this.labelStyle,
    this.isEnabled = true,
    this.clearButtonProps = true,
  }) : super(key: key);

  @override
  State<SingleSelectDropDownMVC> createState() =>
      SingleSelectDropDownMVCState();
}

class SingleSelectDropDownMVCState extends State<SingleSelectDropDownMVC> {
  String? selectedLabel;

  @override
  void initState() {
    super.initState();
    if (widget.selectedId != null) {
      final entry = widget.dropdownItems.firstWhere(
        (item) => item['id'] == widget.selectedId,
        orElse: () => {},
      );
      if (entry.isNotEmpty) {
        selectedLabel = '${entry['name']} (ID: ${entry['id']})';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemLabels = widget.dropdownItems
        .map((item) => '${item['name']} (ID: ${item['id']})')
        .toList();

    return DropdownSearch<String>(
      items: itemLabels,
      selectedItem: selectedLabel,
      dropdownDecoratorProps: DropDownDecoratorProps(
       dropdownSearchDecoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondary),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondary),
          ),
          label: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.dropDownName,
                  style: widget.labelStyle ?? textStyleGrey18,
                ),
                TextSpan(
                  text: widget.star,
                  style: textStyleMandotary,
                ),
              ],
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
          border: const OutlineInputBorder(),
          errorStyle: const TextStyle(color: AppColors.primaryButtonColor),
        ),
      ),
      onChanged: (label) {
        if (label == null) return;
        setState(() => selectedLabel = label);
        final match = widget.dropdownItems.firstWhere(
          (item) => '${item['name']} (ID: ${item['id']})' == label,
          orElse: () => {},
        );
        if (match.isNotEmpty) {
          widget.onChanged(match['id'].toString());
        }
      },
      validator: (value) {
        if (widget.optionalisEmpty &&
            (value == null || value.trim().isEmpty)) {
          return "Please select an option";
        }
        return null;
      },
      onSaved: (label) {
        if (label == null) {
          widget.onSaved(null);
          return;
        }
        final match = widget.dropdownItems.firstWhere(
          (item) => '${item['name']} (ID: ${item['id']})' == label,
          orElse: () => {},
        );
        if (match.isNotEmpty) {
          widget.onSaved(match['id'].toString());
        } else {
          widget.onSaved(null);
        }
      },
        popupProps: PopupProps.menu(
        fit: FlexFit.loose,
        menuProps: const MenuProps(backgroundColor: AppColors.white),
        showSelectedItems: true,
        showSearchBox: true,
        itemBuilder: (context, item, isSelected) {
          return ListTile(
            title: Text(
              item,
              style: isSelected ? textStyleMandotary : textStyleGrey18,
            ),
            trailing: isSelected
                ? const Icon(Icons.check_circle, color:AppColors.primaryButtonColor )
                : const Icon(Icons.check_circle_outline, color: AppColors.grey),
          );
        },
      ),
     
      clearButtonProps: ClearButtonProps(isVisible: widget.clearButtonProps),
      enabled: widget.isEnabled,
    );
  }
}
