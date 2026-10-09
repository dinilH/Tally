import 'package:gherkin/gherkin.dart';

/// Initial executable BDD steps for the expense balance examples.
/// These use an in-memory scenario world until domain services are available.
class TallyWorld {
  int total = 0;
  final Map<String, int> paid = {};
  final Map<String, int> consumed = {};
  Map<String, int> balances = {};

  void calculate() {
    final people = {...paid.keys, ...consumed.keys};
    balances = {
      for (final person in people)
        person: (paid[person] ?? 0) - (consumed[person] ?? 0),
    };
  }
}

class ExpenseTotalStep extends Given1<int, FlutterWorld> {
  @override
  RegExp get pattern => RegExp(r'a trip expense totals Rs (\d+)');

  @override
  Future<void> executeStep(int amount) async {
    context.world.state['tally'] = TallyWorld()..total = amount;
  }
}

class AlicePaidStep extends Given1<int, FlutterWorld> {
  @override
  RegExp get pattern => RegExp(r'Alice paid Rs (\d+)');

  @override
  Future<void> executeStep(int amount) async {
    (context.world.state['tally'] as TallyWorld).paid['Alice'] = amount;
  }
}

class BobPaidStep extends Given1<int, FlutterWorld> {
  @override
  RegExp get pattern => RegExp(r'Bob paid Rs (\d+)');

  @override
  Future<void> executeStep(int amount) async {
    (context.world.state['tally'] as TallyWorld).paid['Bob'] = amount;
  }
}

class AliceConsumedStep extends Given1<int, FlutterWorld> {
  @override
  RegExp get pattern => RegExp(r'Alice consumed Rs (\d+)');

  @override
  Future<void> executeStep(int amount) async {
    (context.world.state['tally'] as TallyWorld).consumed['Alice'] = amount;
  }
}

class BobConsumedStep extends Given1<int, FlutterWorld> {
  @override
  RegExp get pattern => RegExp(r'Bob consumed Rs (\d+)');

  @override
  Future<void> executeStep(int amount) async {
    (context.world.state['tally'] as TallyWorld).consumed['Bob'] = amount;
  }
}

class CharlieConsumedStep extends Given1<int, FlutterWorld> {
  @override
  RegExp get pattern => RegExp(r'Charlie consumed Rs (\d+)');

  @override
  Future<void> executeStep(int amount) async {
    (context.world.state['tally'] as TallyWorld).consumed['Charlie'] = amount;
  }
}

class CalculateBalancesStep extends When0<FlutterWorld> {
  @override
  RegExp get pattern => RegExp(r'Tally calculates the member balances');

  @override
  Future<void> executeStep() async {
    (context.world.state['tally'] as TallyWorld).calculate();
  }
}

class AliceOwedStep extends Then1<int, FlutterWorld> {
  @override
  RegExp get pattern => RegExp(r'Alice should be owed Rs (\d+)');

  @override
  Future<void> executeStep(int amount) async {
    expect((context.world.state['tally'] as TallyWorld).balances['Alice'], amount);
  }
}

class BobOwedStep extends Then1<int, FlutterWorld> {
  @override
  RegExp get pattern => RegExp(r'Bob should be owed Rs (\d+)');

  @override
  Future<void> executeStep(int amount) async {
    expect((context.world.state['tally'] as TallyWorld).balances['Bob'], amount);
  }
}

class CharlieOwesStep extends Then1<int, FlutterWorld> {
  @override
  RegExp get pattern => RegExp(r'Charlie should owe Rs (\d+)');

  @override
  Future<void> executeStep(int amount) async {
    expect((context.world.state['tally'] as TallyWorld).balances['Charlie'], -amount);
  }
}
