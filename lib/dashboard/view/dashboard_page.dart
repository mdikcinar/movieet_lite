import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieetlite/dashboard/constants/dashboard_view_enum.dart';
import 'package:movieetlite/dashboard/cubit/dashboard_cubit.dart';
import 'package:movieetlite/profile/view/profile_page.dart';
import 'package:movieetlite/search/view/search_page.dart';
import 'package:movieetlite/trends/view/trends_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCubit>(
      create: (context) => DashboardCubit(),
      child: Scaffold(
        bottomNavigationBar: const BottomNavBar(),
        body: BlocBuilder<DashboardCubit, DashboardView>(
          builder: (context, state) {
            switch (state) {
              case DashboardView.trends:
                return const TrendsPage();
              case DashboardView.search:
                return const SearchPage();
              case DashboardView.profile:
                return const ProfilePage();
              default:
                return const Center(
                  child: Text('Unknown page'),
                );
            }
          },
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
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
                  icon: const Icon(Icons.movie),
                  label: 'Trends',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.account_circle_sharp),
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
