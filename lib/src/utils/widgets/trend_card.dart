import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieetlite/src/core/extensions/context_extension.dart';
import 'package:movieetlite/src/core/widgets/other/custom_shimmer.dart';
import 'package:movieetlite/src/core/widgets/other/skelton.dart';
import 'package:movieetlite/src/core/widgets/text/custom_text.dart';
import 'package:movieetlite/src/features/trends/domain/trend.dart';
import 'package:movieetlite/src/utils/constants/app_constants.dart';

class TrendCard extends StatelessWidget {
  const TrendCard({super.key, this.trend});

  final Trend? trend;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.normalRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(context.normalRadius),
              child: trend?.posterPath != null
                  ? CachedNetworkImage(
                      imageUrl:
                          AppConstants.tmdbBaseImageUrl.value + AppConstants.posterSize.value + trend!.posterPath!,
                      placeholder: (context, url) => CustomShimmer(
                        child: Skelton(
                          width: context.width,
                          height: context.height,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                    )
                  : const Center(
                      child: Icon(Icons.error),
                    ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(context.lowPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _VoteAverage(voteAverage: trend?.voteAverage),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _VoteAverage extends StatelessWidget {
  const _VoteAverage({required this.voteAverage});

  final double? voteAverage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star_rate_rounded,
          size: context.lowIconSize,
          color: Colors.yellow.shade800,
        ),
        CustomText.low(voteAverage?.toStringAsFixed(1)),
      ],
    );
  }
}
