import 'package:flutter/material.dart';
import 'package:los_mobile/utils/colors.dart';

Future<DateTime?> datePicker(BuildContext context, DateTime dateTime) =>
    showDatePicker(
      context: context,
      initialDate: dateTime,
      // firstDate: DateTime.now().subtract(const Duration(days: 14)),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: mPrimaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
