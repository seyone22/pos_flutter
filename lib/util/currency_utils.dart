String formatAxisValue(double value) {
  if (value >= 1000 && value < 1000000) {
    return '${(value / 1000).toStringAsFixed(1)}k'; // Converts to '1.0k', '10.5k', etc.
  } else if (value >= 1000000) {
    return '${(value / 1000000).toStringAsFixed(1)}M'; // Converts to '1.0M', '10.5M', etc.
  } else {
    return value.toStringAsFixed(0); // For values less than 1000
  }
}