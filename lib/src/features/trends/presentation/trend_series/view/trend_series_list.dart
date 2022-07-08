import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieetlite/src/core/extensions/context_extension.dart';
import 'package:movieetlite/src/core/widgets/other/centered_progress_indicator.dart';
import 'package:movieetlite/src/features/trends/presentation/trend_series/bloc/trend_series_bloc.dart';
import 'package:movieetlite/src/features/trends/presentation/trends/view/trend_list.dart';

class TrendSeriesList extends StatelessWidget {
  const TrendSeriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendSeriesBloc, TrendSeriesState>(
      builder: (context, state) {
        if (state.status == TrendSeriesStatus.initial) {
          return const CenteredProgressIndicator();
        }
        return Column(
          children: [
            Expanded(
              child: TrendList(
                key: const Key('trend-series-list'),
                trendList: state.trendSeries,
                onBottom: () => context.read<TrendSeriesBloc>().add(TrendSeriesFetched()),
              ),
            ),
            if (state.status == TrendSeriesStatus.loading)
              Padding(
                padding: EdgeInsets.symmetric(vertical: context.highPadding),
                child: const CircularProgressIndicator(key: Key('bottomLoader')),
              ),
          ],
        );
      },
    );
  }
}
