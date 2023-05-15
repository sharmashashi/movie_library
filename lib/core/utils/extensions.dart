extension DurationParsing on int{
  String get formattedDuration{
    int hours = toInt()~/60;
    int minutes = toInt()%60;
    return '${hours}h ${minutes}m';
  }
}