import 'package:flutter/material.dart';

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  SliverCustomHeaderDelegate(
      {required this.minHeight, required this.maxHeight, required this.child});

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      SizedBox.expand(child: child);

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverCustomHeaderDelegate oldDelegate) =>
      maxHeight != oldDelegate.maxHeight ||
      minHeight != oldDelegate.minHeight ||
      child != oldDelegate.child;
}
