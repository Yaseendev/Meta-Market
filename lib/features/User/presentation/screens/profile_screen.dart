import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/config/di/injection.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/dialogs/dialogs.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/core/presentation/widgets/error_view.dart';
import 'package:supermarket/core/presentation/widgets/loading_widget.dart';
import 'package:supermarket/features/User/domain/entities/app_user.dart';
import 'package:supermarket/features/User/presentation/blocs/profile/profile_cubit.dart';
import 'package:supermarket/features/User/presentation/widgets/edit_profile_view.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileCubit _profileCubit = getIt<ProfileCubit>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(LocaleKeys.myProfile.tr(context: context))),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: UIMetrics.md,
            vertical: UIMetrics.sm,
          ),
          child: BlocBuilder<ProfileCubit, BaseState<AppUser>>(
            bloc: _profileCubit,
            builder: (context, state) {
              if (state.isLoading) {
                return LoadingWidget();
              } else if (state.isFailure) {
                return ErrorView(onRetry: _profileCubit.loadUser);
              } else if (state.isSuccess && state.item != null) {
                return EditProfileView(
                  state.item!,
                  onEdited: (value) {
                    showSuccessSnackBar(
                      context,
                      LocaleKeys.changesSaved.tr(context: context),
                    );
                    _profileCubit.setUser(value);
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
