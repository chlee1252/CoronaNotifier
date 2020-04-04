class StateInfo {
  int active;
  int death;
  int recovered;
  int newActive;
  int newDeath;
  String state;
  String date;

  StateInfo({int active, int death, int recovered, int newActive, int newDeath, String state, String date}) {
    this.active = active;
    this.death = death;
    this.newActive = newActive;
    this.newDeath = newDeath;
    this.recovered = recovered;
    this.state = state;
    this.date = date;
  }
}
