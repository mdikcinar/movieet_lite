import 'package:flutter/material.dart';
import 'package:movieetlite/src/features/trends/domain/trend.dart';
import 'package:movieetlite/src/utils/widgets/trend_card.dart';

class TrendList extends StatefulWidget {
  const TrendList({
    super.key,
    required this.trendList,
    required this.onBottom,
    required this.initialScroll,
    required this.onScroll,
  });
  final List<Trend> trendList;
  final VoidCallback onBottom;
  final double initialScroll;
  final void Function(double position) onScroll;
  @override
  State<TrendList> createState() => _TrendListState();
}

class _TrendListState extends State<TrendList> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: widget.initialScroll);
    _scrollController.addListener(() => _onScroll(context));
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(() => _onScroll(context))
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.6),
      itemCount: widget.trendList.length,
      itemBuilder: (context, index) {
        final trend = widget.trendList[index];
        return TrendCard(
          trend: trend,
        );
      },
    );
  }

  void _onScroll(BuildContext context) {
    if (_isBottom(context)) widget.onBottom();
  }

  bool _isBottom(BuildContext context) {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    widget.onScroll(currentScroll);
    return currentScroll >= (maxScroll * 0.9);
  }
}
