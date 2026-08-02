import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:supermarket/core/config/di/injection.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/core/presentation/dialogs/dialogs.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/core/presentation/widgets/loading_widget.dart';
import 'package:supermarket/features/Home/presentation/blocs/barcode/barcode_cubit.dart';

class BarcodeScreen extends StatelessWidget {
  BarcodeScreen({super.key});
  final BarcodeCubit _barcodeCubit = getIt<BarcodeCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<BarcodeCubit, BaseState<int>>(
      bloc: _barcodeCubit,
      listener: (context, state) {
        if (state.isFailure) {
          showErrorSnackBar(
            context,
            state.failure?.message.tr(context: context),
          );
        } else if (state.isSuccess) {
          context.pop();
          //TODO: Go to product screen
          // context.push();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.barcodeScan.tr(context: context)),
        ),
        body: BlocBuilder<BarcodeCubit, BaseState<int>>(
          bloc: _barcodeCubit,
          builder: (context, state) {
            if (state.isLoading) return const LoadingWidget();
            return MobileScanner(
              placeholderBuilder: (context) => LoadingWidget(),
              overlayBuilder: (context, constraints) => Container(
                width: 300,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
              ),
              onDetect: (b) {
                print('Detected ${b.barcodes.firstOrNull}');
              },
            );
          },
        ),
      ),
    );
  }
}
