import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../injection.dart';
import '../../core/services/theme_service.dart';
import 'cubit/advicer_cubit.dart';
import 'widgets/advice_field.dart';
import 'widgets/custom_button.dart';
import 'widgets/error_message.dart';

class AdvicerPageWrapperProvider extends StatelessWidget {
  const AdvicerPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdvicerCubit>(),
      child: const AdvicerPage(),
    );
  }
}

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    log("build =====>");

    return Scaffold(
      appBar: AppBar(
        title: Text("Advicer", style: themeData.textTheme.displayLarge),
        centerTitle: true,
        actions: [
          Switch(
              value: Provider.of<ThemeService>(context).isDarkModeOn,
              onChanged: (v) {
                Provider.of<ThemeService>(context, listen: false).toggleTheme();
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Expanded(child: Center(
              child: BlocBuilder<AdvicerCubit, AdvicerCubitState>(
                builder: (context, state) {
                  if (state is AdvicerInitial) {
                    return Text(
                      "Your advice is waiting for you!",
                      style: themeData.textTheme.displayLarge,
                    );
                  } else if (state is AdvicerStateLoading) {
                    return CircularProgressIndicator(
                        color: themeData.colorScheme.secondary);
                  } else if (state is AdvicerStateLoaded) {
                    return AdviceField(advice: state.advice);
                  } else if (state is AdvicerStateError) {
                    return ErrorMessage(message: state.message);
                  }

                  return const SizedBox();
                },
              ),
            )

                // Text(
                //   "Your advice is waiting for you!",
                //   style: themeData.textTheme.displayLarge,
                // ),
                ),
            const SizedBox(height: 200, child: Center(child: CustomButton()))
          ],
        ),
      ),
    );
  }
}
