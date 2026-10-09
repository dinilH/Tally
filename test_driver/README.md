# Tally BDD / Cucumber tests

Feature specifications are written in Gherkin under `test_driver/features/`.

Run the Gherkin suite with the Flutter Gherkin runner after installing dependencies:

```bash
flutter pub get
dart test_driver/cucumber_test.dart
```

The current scenarios specify expense balances, item attribution, participation windows, and settlements. The first executable steps use an in-memory scenario world; once domain services and real trip/expense screens are implemented, replace the in-memory operations with app-facing test actions.

Do not mark these acceptance tests as full UI end-to-end coverage until the app has the corresponding flows and persistent data layer.
