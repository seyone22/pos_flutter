import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Calendar { day, week, month, year }

class DateSelector extends StatefulWidget {
  final DateTimeRange? selectedDateRange;
  final ValueChanged<DateTimeRange> onDateSelected;

  const DateSelector({
    super.key,
    required this.selectedDateRange,
    required this.onDateSelected,
  });

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  Calendar calendarView = Calendar.day;

  Future<void> _pickDate(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != widget.selectedDateRange) {
      widget.onDateSelected(picked);
    }
  }

  void _adjustDate(int days) {
    final newDate = widget.selectedDateRange?.start.add(Duration(days: days));
    widget.onDateSelected(DateTimeRange(
        start: newDate ?? DateTime.now(), end: newDate ?? DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (calendarView == Calendar.day) ...[
          OverflowBar(
            children: [
              ElevatedButton(
                onPressed: () => _adjustDate(-1),
                style: _buttonStyle(context),
                child: const Icon(Icons.chevron_left),
              ),
              ElevatedButton(
                onPressed: () => _pickDate(context),
                style: _buttonStyle(context),
                child: Text(
                  widget.selectedDateRange?.start.isAtSameMomentAs(widget.selectedDateRange?.end ?? DateTime.now()) ?? false
                      ? DateFormat.yMMMd().format(widget.selectedDateRange?.start ?? DateTime.now())
                      : '${DateFormat.yMMMd().format(widget.selectedDateRange?.start ?? DateTime.now())} - ${DateFormat.yMMMd().format(widget.selectedDateRange?.end ?? DateTime.now())}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed: () => _adjustDate(1),
                style: _buttonStyle(context),
                child: const Icon(Icons.chevron_right),
              ),
            ],
          )
        ]
      ],
    );
  }

  ButtonStyle _buttonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}
