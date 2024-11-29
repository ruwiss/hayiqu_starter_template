import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

import 'home_viewmodel.dart';

class HomeView extends BaseView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Hello"),
            Text("${viewModel.count}"),
            Gap(15),
            Text("Service Value: ${viewModel.serviceValue}"),
            Gap(15),
            Text("Fetched Value: ${viewModel.fetchedValue}"),
          ],
        ),
      ),
    );
  }

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.startCounter();
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
