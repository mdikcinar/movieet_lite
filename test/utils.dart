import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpMaterialWidget<T extends Bloc<dynamic, dynamic>>(Widget widget, {Bloc<dynamic, dynamic>? bloc}) {
    if (bloc != null) {
      return pumpWidget(
        MaterialApp(
          home: BlocProvider<T>(
            create: (context) => bloc as T,
            child: Scaffold(
              body: widget,
            ),
          ),
        ),
      );
    }
    return pumpWidget(
      MaterialApp(
        home: widget,
      ),
    );
  }
}
