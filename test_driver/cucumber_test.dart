import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

import 'steps/tally_steps.dart';

Future<void> main() async {
  final configuration = FlutterTestConfiguration()
    ..features = [DirFeatureReader('test_driver/features')]
    ..reporters = [ProgressReporter()]
    ..stepDefinitions = [
      ExpenseTotalStep(),
      AlicePaidStep(),
      BobPaidStep(),
      AliceConsumedStep(),
      BobConsumedStep(),
      CharlieConsumedStep(),
      CalculateBalancesStep(),
      AliceOwedStep(),
      BobOwedStep(),
      CharlieOwesStep(),
    ];

  await GherkinRunner().execute(configuration);
}
