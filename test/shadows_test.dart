import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icon_decoration/icon_decoration.dart';

import 'test_utils/base_widget.dart';

void main() {
  group('Golden Shadows', () {
    goldenTest(
      'Shadows rendering',
      fileName: 'shadows_rendering',
      builder: () {
        return GoldenTestGroup(
          children: [
            GoldenTestScenario(
              name: 'base',
              child: const SizedBox(width: 150, child: BaseTestWidget()),
            ),
            GoldenTestScenario(
              name: 'default',
              child: const DecoratedIcon(
                icon: Icon(
                  Icons.home,
                  color: Colors.red,
                  size: 50,
                  shadows: [Shadow(blurRadius: 3)],
                ),
              ),
            ),
            GoldenTestScenario(
              name: 'with Offset(0, 6)',
              child: const DecoratedIcon(
                icon: Icon(
                  Icons.home,
                  color: Colors.red,
                  size: 50,
                  shadows: [Shadow(blurRadius: 3, offset: Offset(0, 6))],
                ),
              ),
            ),
            GoldenTestScenario(
              name: 'with Offset(3, 0)',
              child: const DecoratedIcon(
                icon: Icon(
                  Icons.home,
                  color: Colors.red,
                  size: 50,
                  shadows: [Shadow(blurRadius: 3, offset: Offset(3, 0))],
                ),
              ),
            ),
          ],
        );
      },
    );
  });
}
