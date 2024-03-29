import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieetlite/src/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:movieetlite/src/features/profile/presentation/profile/view/profile_page.dart';
import 'package:movieetlite/src/features/search/presentation/search/view/search_page.dart';
import 'package:movieetlite/src/features/trends/data/repository/trends_repository.dart';
import 'package:movieetlite/src/features/trends/data/service/trends_service.dart';
import 'package:movieetlite/src/features/trends/presentation/trends/bloc/trends_bloc.dart';
import 'package:movieetlite/src/features/trends/presentation/trends/trends.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final trendsRepository = TrendsRepository(context.read<ChopperClient>().getService<TrendsService>());
    return BlocProvider<DashboardCubit>(
      create: (context) => DashboardCubit(),
      child: Scaffold(
        bottomNavigationBar: const BottomNavBar(),
        body: BlocBuilder<DashboardCubit, DashboardView>(
          builder: (context, state) {
            switch (state) {
              case DashboardView.trends:
                return TrendsPage(TrendsBloc(trendsRepository));
              case DashboardView.search:
                return const SearchPage();
              case DashboardView.profile:
                return const ProfilePage();
            }
          },
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: BottomAppBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: BlocBuilder<DashboardCubit, DashboardView>(
          builder: (context, state) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: state.index,
              onTap: (value) => context.read<DashboardCubit>().changeDashboardView(DashboardView.values[value]),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.movie),
                  label: 'Trends',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_sharp),
                  label: 'Profile',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
