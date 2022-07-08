import 'package:flutter/material.dart';
import 'package:movieetlite/src/features/trends/domain/trend.dart';
import 'package:movieetlite/src/utils/widgets/trend_card.dart';

class TrendList extends StatefulWidget {
  const TrendList({super.key, required this.trendList, required this.onBottom});
  final List<Trend> trendList;
  final VoidCallback onBottom;
  @override
  State<TrendList> createState() => _TrendListState();
}

class _TrendListState extends State<TrendList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
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

  void _onScroll() {
    if (_isBottom) widget.onBottom();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
