enum SalesMetric { count, volume }

extension SalesMetricExtension on SalesMetric {
  String get displayName {
    switch (this) {
      case SalesMetric.count:
        return 'Count';
      case SalesMetric.volume:
        return 'Volume';
    }
  }
}
