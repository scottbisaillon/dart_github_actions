import 'dart:math';

import 'package:dart_github_actions/src/models/models.dart';
import 'package:dart_github_actions/src/utils/utils.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

extension RandX on Random {
  int nextIntInclusive(int max) {
    return nextInt(max + 1);
  }

  int nextIntBetween(int start, int end, {bool inclusive = false}) {
    final value = start + nextInt(end - start);
    return inclusive ? value + 1 : value;
  }
}

@isTestGroup
void cronTestGroup(
  String description, {
  required int minValue,
  required int maxValue,
  required CronValue Function(List<int>) listConstructor,
  required CronValue Function(int start, int end) rangeConstructor,
}) {
  group(description, () {
    listConstructorTest(
      'List Constructor should only accept valid values',
      minValue: minValue,
      maxValue: maxValue,
      constructor: listConstructor,
    );

    rangeConstructorTests(
      'Range Constructor',
      minValue: minValue,
      maxValue: maxValue,
      constructor: rangeConstructor,
    );
  });
}

@isTest
void listConstructorTest(
  String description, {
  required int minValue,
  required int maxValue,
  required CronValue Function(List<int>) constructor,
}) {
  final rand = Random();
  final validValues =
      List<int>.generate(3, (index) => rand.nextInt(maxValue + 1) + minValue);

  final invalidValues = <List<int>>[
    // add values strictly out of the range
    [
      ...List<int>.generate(
        3,
        (index) => minValue - rand.nextInt(100) + 1,
      ),
      ...List<int>.generate(
        3,
        (index) => maxValue + rand.nextInt(100) + 1,
      )
    ],
    // add values both in and out of range
    [
      ...List<int>.generate(
        3,
        (index) => minValue - rand.nextInt(100) + 1,
      ),
      ...List<int>.generate(
        3,
        (index) => maxValue + rand.nextInt(100) + 1,
      ),
      ...List<int>.generate(
        3,
        (index) => rand.nextInt(maxValue + 1) + minValue,
      )
    ]
  ];

  test(description, () {
    for (final element in invalidValues) {
      expect(() => constructor(element), throwsA(isA<AssertionError>()));
    }

    expect(() => constructor(validValues), returnsNormally);
  });
}

@isTestGroup
void rangeConstructorTests(
  String description, {
  required int minValue,
  required int maxValue,
  required CronValue Function(int start, int end) constructor,
}) {
  group(description, () {
    test('should not accept end value less than start value', () {
      expect(
        () => constructor(
          maxValue,
          minValue,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('should not accept start value less than minValue', () {
      expect(
        () => constructor(
          minValue - 1,
          Random().nextInt(maxValue + 1) + minValue,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('should not accept end value more than maxValue', () {
      expect(
        () => constructor(
          Random().nextInt(maxValue + 1) + minValue,
          maxValue + 1,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('should accept valid values', () {
      final rand = Random();
      final startValue =
          rand.nextIntBetween(minValue, maxValue - 1, inclusive: true);
      final endValue =
          rand.nextIntBetween(startValue, maxValue, inclusive: true);

      expect(
        () => constructor(
          startValue,
          endValue,
        ),
        returnsNormally,
      );
    });
  });
}

@isTestGroup
void stepConstructorTests(
  String description, {
  required int minValue,
  required int maxValue,
  required CronValue Function(int value, int by) constructor,
}) {
  group(description, () {
    test('should not accept value great than maxValue', () {});
    test('should not accept value less than minValue', () {});

    test("should not accept 'by' value less than or equal to 0", () {});

    test('should only accept values between minValue and maxValue', () {});
    //     test('should only accept values between 0 and 59', () {
    //       expect(() => Minute.step(-1, 20), throwsA(isA<AssertionError>()));
    //       expect(() => Minute.step(60, 20), throwsA(isA<AssertionError>()));
    //       expect(() => Minute.step(10, 15), returnsNormally);
    //     });

    //     test('by must be greater than 0', () {
    //       expect(() => Minute.step(20, 0), throwsA(isA<AssertionError>()));
    //       expect(() => Minute.step(4, 40), returnsNormally);
    //     });
    //   });
  });
}

void main() {
  cronTestGroup(
    'Cron Minute',
    minValue: 0,
    maxValue: 59,
    listConstructor: Minute.list,
    rangeConstructor: Minute.range,
  );

  group('Cron', () {
    // group('Minute', () {
    //   test('should only accept values between 0 and 59', () {
    //     expect(() => Minute(-1), throwsA(isA<AssertionError>()));
    //     expect(() => Minute(60), throwsA(isA<AssertionError>()));
    //     expect(() => Minute(30), returnsNormally);
    //   });

    //   // group('list constructor', () {
    //   //   listConstructorTest(
    //   //     minValue: 0,
    //   //     maxValue: 59,
    //   //     invalidValues: [
    //   //       [0, 2, -1],
    //   //       [0, 2, 60]
    //   //     ],
    //   //     validValues: [
    //   //       [2, 3]
    //   //     ],
    //   //     constructor: Minute.list,
    //   //   );
    //   // });

    //   group('step constructor', () {
    //     test('should only accept values between 0 and 59', () {
    //       expect(() => Minute.step(-1, 20), throwsA(isA<AssertionError>()));
    //       expect(() => Minute.step(60, 20), throwsA(isA<AssertionError>()));
    //       expect(() => Minute.step(10, 15), returnsNormally);
    //     });

    //     test('by must be greater than 0', () {
    //       expect(() => Minute.step(20, 0), throwsA(isA<AssertionError>()));
    //       expect(() => Minute.step(4, 40), returnsNormally);
    //     });
    //   });
    // });

    group('Hour', () {
      test('should only accept values between 0 and 23', () {
        expect(() => Hour(-1), throwsA(isA<AssertionError>()));
        expect(() => Hour(24), throwsA(isA<AssertionError>()));
        expect(() => Hour(15), returnsNormally);
      });

      group('list constructor', () {
        test('should only accept values between 0 and 23', () {
          expect(() => Hour.list([0, 2, -1]), throwsA(isA<AssertionError>()));
          expect(() => Hour.list([0, 1, 24]), throwsA(isA<AssertionError>()));
          expect(() => Hour.list([2, 3]), returnsNormally);
        });
      });

      group('range constructor', () {
        test('should only accept values between 0 and 23', () {
          expect(() => Hour.range(-1, 23), throwsA(isA<AssertionError>()));
          expect(() => Hour.range(4, 24), throwsA(isA<AssertionError>()));
          expect(() => Hour.range(4, 5), returnsNormally);
        });

        test('start value must be less than end value', () {
          expect(() => Hour.range(24, 10), throwsA(isA<AssertionError>()));
          expect(() => Hour.range(4, 23), returnsNormally);
        });
      });

      group('step constructor', () {
        test('should only accept values between 0 and 23', () {
          expect(() => Hour.step(-1, 20), throwsA(isA<AssertionError>()));
          expect(() => Hour.step(24, 20), throwsA(isA<AssertionError>()));
          expect(() => Hour.step(10, 15), returnsNormally);
        });

        test('by must be greater than 0', () {
          expect(() => Hour.step(20, 0), throwsA(isA<AssertionError>()));
          expect(() => Hour.step(4, 40), returnsNormally);
        });
      });
    });

    group('Schedule', () {
      test("should default to '* * * * *'", () {
        expect(CronSchedule().toString(), equals('* * * * *'));
      });
    });
  });

  group('Schedule', () {
    group('toYaml', () {
      const writer = YAMLWriter();

      test('should have correct yaml representation', () {
        final yaml = writer.write(
          Schedule(
            cron: [
              CronSchedule(minute: Minute(15), hour: Hour(2)),
              CronSchedule(minute: Minute(15), hour: Hour(15)),
            ],
          ),
        );
        expect(
          yaml,
          equals(
            '''
schedule:
  -
    cron: '15 2 * * *'
  -
    cron: '15 15 * * *'
''',
          ),
        );
      });
    });
  });
}
