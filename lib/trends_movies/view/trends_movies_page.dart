import 'package:flutter/material.dart';

import '../../0-core/init/navigation/navigation_service.dart';

class TrendsMoviesPage extends StatelessWidget {
  const TrendsMoviesPage({Key? key}) : super(key: key);

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
