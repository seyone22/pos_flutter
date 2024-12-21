DateTime weekOfStart(DateTime date) {
  // Calculate the start of the week (Monday)
  return date.subtract(Duration(days: date.weekday - 1));
}

DateTime weekOfEnd(DateTime date) {
  // Calculate the end of the week (Sunday)
  return weekOfStart(date).add(const Duration(days: 6));
}
