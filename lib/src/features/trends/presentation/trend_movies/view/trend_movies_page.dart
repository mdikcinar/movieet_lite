import 'package:flutter/material.dart';
import 'package:movieetlite/src/core/navigation/navigation_service.dart';

class TrendMoviesPage extends StatelessWidget {
  const TrendMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Movies view'),
        TextButton(onPressed: () => NavigationService.instance.toNamed('sdjkl'), child: Text('Route to unknown'))
      ],
    );
  }
}
