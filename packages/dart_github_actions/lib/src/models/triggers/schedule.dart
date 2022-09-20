// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_github_actions/src/dart_github_actions.dart';
import 'package:dart_github_actions/src/utils/utils.dart';

/// {@template cron_value}
/// A base for all parts of a cron schedule.
/// {@endtemplate}
abstract class CronValue {
  /// {@macro cron_value}
  CronValue(int value) : _value = value.toString();

  /// {@template any}
  /// Any value. Equivalent to '*'.
  /// ex: 15 * * * * runs at every minute 15 of every hour of every day.
  /// {@endtemplate}
  CronValue.any() : _value = '*';

  /// {@template list}
  /// A list of values.
  /// ex: 2,10 4,5 * * * runs at minute 2 and 10 of the 4th and 5th hour of every day.
  /// {@endtemplate}
  CronValue.list(List<int> values) : _value = values.join(',');

  /// {@template range}
  /// A range of values, inclusive.
  /// ex: 30 4-6 * * * runs at minute 30 of the 4th, 5th, and 6th hour.
  /// {@endtemplate}
  CronValue.range(int start, int end) : _value = '$start-$end';

  /// {@template step}
  /// A step value.
  /// ex: 20/15 * * * * runs every 15 minutes starting from minute 20 through 59 (minutes 20, 35, and 50).
  /// {@endtemplate}
  CronValue.step(int value, int by) : _value = '$value/$by';

  final String _value;

  @override
  String toString() => _value;
}

/// {@template minute}
/// The minute field of a [CronSchedule].
/// {@endtemplate}
class Minute extends CronValue {
  /// {@macro minute}
  /// The value must be between 0 and 59
  Minute(super.value)
      : assert(value >= 0 && value <= 59, 'Value must be between 0 and 59');

  /// {@macro any}
  Minute.any() : super.any();

  /// {@macro list}
  Minute.list(super.values)
      : assert(
          values.every((element) => element >= 0 && element <= 59),
          'Values must be between 0 and 59; $values',
        ),
        super.list();

  /// {@macro range}
  Minute.range(super.start, super.end)
      : assert(
          start >= 0 && start <= 59,
          'start must be between 0 and 59: $start',
        ),
        assert(end >= 0 && end <= 59, 'end must be between 0 and 59: $end'),
        assert(start < end, 'start must be less than end'),
        super.range();

  /// {@macro step}
  Minute.step(super.value, super.by)
      : assert(value >= 0 && value <= 59, 'start must be between 0 and 59'),
        assert(by > 0, 'by must be a positive number'),
        super.step();
}

/// {@template hour}
/// The hour field of a [CronSchedule].
/// {@endtemplate}
class Hour extends CronValue {
  /// {@macro hour}
  /// The value must be between 0 and 23
  Hour(super.value)
      : assert(value >= 0 && value <= 23, 'Value must be between 0 and 23');

  /// {@macro any}
  Hour.any() : super.any();

  /// {@macro list}
  Hour.list(super.values)
      : assert(
          values.every((element) => element >= 0 && element <= 23),
          'Values must be between 0 and 23',
        ),
        super.list();

  /// {@macro range}
  Hour.range(super.start, super.end)
      : assert(start >= 0 && start <= 23, 'start must be between 0 and 23'),
        assert(end >= 0 && end <= 23, 'end must be between 0 and 23'),
        assert(start < end, 'start must be less than end'),
        super.range();

  /// {@macro step}
  Hour.step(super.value, super.by)
      : assert(value >= 0 && value <= 23, 'start must be between 0 and 23'),
        assert(by > 0, 'by must be a positive number'),
        super.step();
}

class Day extends CronValue {
  Day(super.value);

  Day.any() : super.any();

  Day.list(super.values) : super.list();

  Day.range(super.start, super.end) : super.range();

  Day.step(super.value, super.by) : super.step();
}

class Month extends CronValue {
  Month(super.value);

  Month.any() : super.any();

  Month.list(super.values) : super.list();

  Month.range(super.start, super.end) : super.range();

  Month.step(super.value, super.by) : super.step();
}

class Weekday extends CronValue {
  Weekday(super.value);

  Weekday.any() : super.any();

  Weekday.list(super.values) : super.list();

  Weekday.range(super.start, super.end) : super.range();

  Weekday.step(super.value, super.by) : super.step();
}

class CronSchedule {
  CronSchedule({
    Minute? minute,
    Hour? hour,
    Day? day,
    Month? month,
    Weekday? weekday,
  })  : minute = minute ?? Minute.any(),
        hour = hour ?? Hour.any(),
        day = day ?? Day.any(),
        month = month ?? Month.any(),
        weekday = weekday ?? Weekday.any();

  final Minute minute;

  final Hour hour;

  final Day day;

  final Month month;

  final Weekday weekday;

  @override
  String toString() => '$minute $hour $day $month $weekday';
}

/// {@template schedule}
/// The schedule event allows you to trigger a workflow at a scheduled time.
///
/// You can schedule a workflow to run at specific UTC times using POSIX cron syntax.
/// Scheduled workflows run on the latest commit on the default or base branch.
/// The shortest interval you can run scheduled workflows is once every 5 minutes.
/// {@endtemplate}
class Schedule extends Trigger implements YAMLObject {
  /// {@macro schedule}
  Schedule({
    required this.cron,
  }) : super(label: 'schedule');

  /// List of schedules following [POSIX cron syntax](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/crontab.html#tag_20_25_07).
  final List<CronSchedule> cron;

  @override
  Map<String, dynamic> toYaml() => {
        'schedule': cron.map((e) => {'cron': e.toString()}).toList(),
      };
}
