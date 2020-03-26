class StateInfo {
  int active;
  int death;
  int recovered;
  String state;
  String date;

  StateInfo({int active, int death, int recovered, String state, String date}) {
    this.active = active;
    this.death = death;
    this.recovered = recovered;
    this.state = state;
    this.date = date;
  }
}
