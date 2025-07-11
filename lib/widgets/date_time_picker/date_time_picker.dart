
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class DateTimeTextFormFieldMVC extends StatefulWidget {
  const DateTimeTextFormFieldMVC({
    super.key,
    required this.text,
    this.validator,
    required this.star,
    required this.enabled,
    this.onSaved,
    this.onChanged,
    this.initialDate,
    this.width = 300.0,
  });

  final double width;
  final String text;
  final String? Function(String?)? validator;
  final String star;
  final bool enabled;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final String? initialDate;

  @override
  State<DateTimeTextFormFieldMVC> createState() =>
      _DateTimeTextFormFieldMVCState();
}

class _DateTimeTextFormFieldMVCState extends State<DateTimeTextFormFieldMVC> {
  DateTime? selectedDate;
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      selectedDate =
          DateFormat('dd-MMM-yyyy hh:mm a').parse(widget.initialDate!);
      _dateController.text = widget.initialDate!;
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1950, 8),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          final formatted =
              DateFormat('dd-MMM-yyyy hh:mm a').format(selectedDate!);
          _dateController.text = formatted;

          if (widget.onChanged != null) {
            widget.onChanged!(formatted);
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      readOnly: true,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.date_range),
        border: const OutlineInputBorder(),
        label: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.text,
               style: textStyleGrey18,
              ),
              TextSpan(
                text: widget.star,
                style:textStyleMandotary,
              ),
            ],
          ),
        ),
        errorStyle: const TextStyle(color: Colors.red),
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

        contentPadding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
      ),
      validator: widget.validator,
      enabled: widget.enabled,
      onTap: () => _selectDateTime(context),
      onSaved: (value) {
        if (widget.onSaved != null && selectedDate != null) {
          widget.onSaved!(
            DateFormat('dd-MMM-yyyy hh:mm a').format(selectedDate!),
          );
        }
      },
      style: const TextStyle(color: Colors.black, fontSize: 16),
    );
  }
}
