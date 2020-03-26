class TimeSeries {
  String date;
  int    affected;
  int    deaths;

  TimeSeries({String date, int affected, int deaths}) {
    this.date = date;
    this.affected = affected;
    this.deaths = deaths;
  }
}