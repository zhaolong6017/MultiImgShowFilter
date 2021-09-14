import 'dart:math';

///对比度，亮度、饱和度、黑白色值反转，矩阵计算公式
class ColorFilterGenerator {
  static const List<double> DELTA_INDEX = <double>[
    0,
    0.01,
    0.02,
    0.04,
    0.05,
    0.06,
    0.07,
    0.08,
    0.1,
    0.11,
    0.12,
    0.14,
    0.15,
    0.16,
    0.17,
    0.18,
    0.20,
    0.21,
    0.22,
    0.24,
    0.25,
    0.27,
    0.28,
    0.30,
    0.32,
    0.34,
    0.36,
    0.38,
    0.40,
    0.42,
    0.44,
    0.46,
    0.48,
    0.5,
    0.53,
    0.56,
    0.59,
    0.62,
    0.65,
    0.68,
    0.71,
    0.74,
    0.77,
    0.80,
    0.83,
    0.86,
    0.89,
    0.92,
    0.95,
    0.98,
    1.0,
    1.06,
    1.12,
    1.18,
    1.24,
    1.30,
    1.36,
    1.42,
    1.48,
    1.54,
    1.60,
    1.66,
    1.72,
    1.78,
    1.84,
    1.90,
    1.96,
    2.0,
    2.12,
    2.25,
    2.37,
    2.50,
    2.62,
    2.75,
    2.87,
    3.0,
    3.2,
    3.4,
    3.6,
    3.8,
    4.0,
    4.3,
    4.7,
    4.9,
    5.0,
    5.5,
    6.0,
    6.5,
    6.8,
    7.0,
    7.3,
    7.5,
    7.8,
    8.0,
    8.4,
    8.7,
    9.0,
    9.4,
    9.6,
    9.8,
    10.0
  ];

  ///色值调节，黑白反转
  static List<double> hueAdjustMatrix({double? value}) {
    value = value!;

    if (value == 0)
      return [
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
      ];
    return List<double>.from(<double>[
      //R  G   B    A  Const
      -value, 0, 0, 0, 255, //
      0, -value, 0, 0, 255, //
      0, 0, -value, 0, 255, //
      0, 0, 0, 1, 0, //
    ]).map((i) => i.toDouble()).toList();
  }

  ///亮度调节
  static List<double> brightnessAdjustMatrix({double? value}) {
    if (value! <= 0)
      value = value * 255;
    else
      value = value * 100;

    if (value == 0)
      return [
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
      ];

    return List<double>.from(<double>[
      1,
      0,
      0,
      0,
      value,
      0,
      1,
      0,
      0,
      value,
      0,
      0,
      1,
      0,
      value,
      0,
      0,
      0,
      1,
      0
    ]).map((i) => i.toDouble()).toList();
  }

  ///饱和度
  static List<double> saturationAdjustMatrix({double? value}) {
    value = value! * 100;

    if (value == 0)
      return [
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
      ];

    double x =
        ((1 + ((value > 0) ? ((3 * value) / 100) : (value / 100)))).toDouble();

    double lumR = 0.3086;
    double lumG = 0.6094;
    double lumB = 0.082;

    return List<double>.from(<double>[
      (lumR * (1 - x)) + x,
      lumG * (1 - x),
      lumB * (1 - x),
      0,
      0,
      lumR * (1 - x),
      (lumG * (1 - x)) + x,
      lumB * (1 - x),
      0,
      0,
      lumR * (1 - x),
      lumG * (1 - x),
      (lumB * (1 - x)) + x,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]).map((i) => i.toDouble()).toList();
  }

  ///对比度
  static List<double> contrastAdjustMatrix({double? value}) {
    value = value! * 100;

    if (value == 0)
      return [
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
      ];

    double x;

    if (value < 0) {
      x = 127 + value / 100 * 127;
    } else {
      x = value % 1;
      if (x == 0) {
        x = DELTA_INDEX[value.toInt()];
      } else {
        //x = DELTA_INDEX[(p_val<<0)]; // this is how the IDE does it.
        x = DELTA_INDEX[(value.toInt() << 0)] * (1 - x) +
            DELTA_INDEX[(value.toInt() << 0) + 1] *
                x; // use linear interpolation for more granularity.
      }
      x = x * 127 + 127;
    }

    return List<double>.from(<double>[
      x / 127,
      0,
      0,
      0,
      0.5 * (127 - x),
      0,
      x / 127,
      0,
      0,
      0.5 * (127 - x),
      0,
      0,
      x / 127,
      0,
      0.5 * (127 - x),
      0,
      0,
      0,
      1,
      0,
    ]).map((i) => i.toDouble()).toList();
  }
}
