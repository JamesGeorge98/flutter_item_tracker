// ignore_for_file: library_private_types_in_public_api, avoid_setters_without_getters

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Gap extends LeafRenderObjectWidget {
  const Gap(this.space, {super.key});

  final double space;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderGap(space);
  }

  @override
  void updateRenderObject(BuildContext context, _RenderGap renderObject) {
    renderObject.space = space;
  }
}

class _RenderGap extends RenderBox {
  _RenderGap(
    this._space,
  );

  double _space;
  set space(double value) {
    if (_space != value) {
      _space = value;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    final flex = parent;
    if (flex is RenderFlex) {
      if (flex.direction == Axis.horizontal) {
        size = constraints.constrain(Size(_space, 0));
      } else {
        size = constraints.constrain(Size(0, _space));
      }
    } else {
      throw FlutterError(
        'A Gap widget must be placed directly inside a Flex widget',
      );
    }
  }
}
