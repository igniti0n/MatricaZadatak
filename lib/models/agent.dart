class Agent {
  final DateTime date;
  final String name;
  final int agreedAppointments;
  final int sales;
  final int leads;

  const Agent({
    this.agreedAppointments,
    this.date,
    this.leads,
    this.name,
    this.sales,
  });

  factory Agent.fromMap(Map<String, dynamic> agentMap) {
    return new Agent(
      agreedAppointments: agentMap['Agreed'],
      date: DateTime.parse(agentMap['Date']),
      leads: agentMap['Leads'],
      name: agentMap['AgentName'],
      sales: agentMap['Sales'],
    );
  }

  static Map<String, dynamic> toMap(Agent agent) {
    return {
      'Agreed': agent.agreedAppointments,
      'Date': agent.date.toIso8601String(),
      'Leads': agent.leads,
      'AgentName': agent.name,
      'Sales': agent.sales,
    };
  }

  @override
  String toString() {
    return ' Agreed :${this.agreedAppointments} \n Leads: ${this.leads} \n  Sales: ${this.sales} \n Date: ${this.date.toIso8601String()} \n AgentName: ${this.name}';
  }
}
