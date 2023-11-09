import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test/constant/app_colors.dart';
import 'package:technical_test/constant/app_text.dart';
import 'package:technical_test/features/home/cubit/data_user_cubit.dart';
import 'package:technical_test/features/home/widget/data_widget.dart';
import 'package:technical_test/features/login_register/cubit/auth_cubit.dart';

import '../../login_register/model/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<DataUserCubit>().fetchDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.blueColor,
          title: Text(
            'Data User',
            style: AppText.text20.copyWith(color: AppColors.whiteColor),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthCubit>().signOut();
              },
              icon: const Icon(
                Icons.logout_outlined,
              ),
            ),
          ],
        ),
        body: BlocConsumer<DataUserCubit, DataUserState>(
          listener: (context, state) {
            if (state is DataUserFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: AppText.text16,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is DataUserSuccess) {
              return Column(
                children: [
                  tabbar(),
                  content(state.dataUser),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget data(List<UserModel> userModel) => Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: userModel
                .map(
                  (e) => DataWidget(
                    name: e.name,
                    id: e.id,
                    email: e.email,
                    isVerified: e.isVerified.toString(),
                  ),
                )
                .toList(),
          ),
        ),
      );

  Widget dataFilter(List<UserModel> userModel, bool isVerified) => Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: userModel
                .where((element) => element.isVerified == isVerified)
                .map(
                  (e) => DataWidget(
                    name: e.name,
                    id: e.id,
                    email: e.email,
                    isVerified: e.isVerified.toString(),
                  ),
                )
                .toList(),
          ),
        ),
      );

  Widget tabbar() {
    return Container(
      color: AppColors.blueColor,
      width: double.infinity,
      child: TabBar(
        labelColor: AppColors.whiteColor,
        labelStyle: AppText.text16,
        unselectedLabelColor: AppColors.whiteSoftColor,
        unselectedLabelStyle: AppText.text16,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 4,
            color: AppColors.whiteColor,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(13),
            topRight: Radius.circular(13),
          ),
        ),
        tabs: const [
          Tab(
            child: Text(
              'All Data',
            ),
          ),
          Tab(
            child: Text(
              'Filter By True',
            ),
          ),
          Tab(
            child: Text(
              'Filter By False',
            ),
          )
        ],
      ),
    );
  }

  Widget content(List<UserModel> user) {
    return Expanded(
      child: TabBarView(
        children: [
          data(user),
          dataFilter(user, true),
          dataFilter(user, false),
        ],
      ),
    );
  }
}
