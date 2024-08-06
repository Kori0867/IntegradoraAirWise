// lib/pantallas/g_hume.dart
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GHume extends StatelessWidget {
  final double humedad;

  const GHume({super.key, required this.humedad});

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(
        labelsPosition: ElementsPosition.outside,
        axisLineStyle: const AxisLineStyle(
          thicknessUnit: GaugeSizeUnit.factor,
          thickness: 0.1,
        ),
        majorTickStyle: const MajorTickStyle(
          length: 0.1,
          thickness: 2,
          lengthUnit: GaugeSizeUnit.factor,
        ),
        minorTickStyle: const MinorTickStyle(
          length: 0.05,
          thickness: 1.5,
          lengthUnit: GaugeSizeUnit.factor,
        ),
        minimum: -10,
        maximum: 100,
        interval: 10,
        useRangeColorForAxis: true,
        axisLabelStyle: const GaugeTextStyle(fontWeight: FontWeight.bold),
        ranges: <GaugeRange>[
          GaugeRange(
            startValue: -10,
            endValue: 0,
            sizeUnit: GaugeSizeUnit.factor,
            color: Colors.brown,
            endWidth: 0.03,
            startWidth: 0.03,
          ),
          GaugeRange(
            startValue: 0,
            endValue: 70,
            sizeUnit: GaugeSizeUnit.factor,
            color: Colors.yellow,
            endWidth: 0.03,
            startWidth: 0.03,
          ),
          GaugeRange(
            startValue: 70,
            endValue: 100,
            sizeUnit: GaugeSizeUnit.factor,
            color: Colors.purple,
            endWidth: 0.03,
            startWidth: 0.03,
          ),
        ],
        pointers: <GaugePointer>[
          NeedlePointer(
            value: humedad,
            needleColor: Colors.black,
            tailStyle: TailStyle(
              length: 0.18,
              width: 8,
              color: Colors.black,
              lengthUnit: GaugeSizeUnit.factor,
            ),
            needleLength: 0.68,
            needleStartWidth: 1,
            needleEndWidth: 8,
            knobStyle: KnobStyle(
              knobRadius: 0.07,
              color: Colors.white,
              borderWidth: 0.05,
              borderColor: Colors.black,
            ),
            lengthUnit: GaugeSizeUnit.factor,
          ),
        ],
        annotations: <GaugeAnnotation>[
          GaugeAnnotation(
            widget: Text(
              '$humedad%',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            positionFactor: 0.8,
            angle: 90,
          ),
        ],
      ),
    ]);
  }
}
