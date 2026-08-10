import 'package:easy_localization/easy_localization.dart' as w;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:supermarket/core/config/di/injection.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/dialogs/dialogs.dart';
import 'package:supermarket/core/presentation/theme/colors.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/core/presentation/widgets/app_button.dart';
import 'package:supermarket/core/presentation/widgets/app_text_field.dart';
import 'package:supermarket/core/services/validators.dart';
import 'package:supermarket/features/Address/domain/entities/address.dart';
import 'package:supermarket/features/Address/presentation/blocs/address/address_cubit.dart';
import 'package:supermarket/features/Address/presentation/blocs/addresses/addresses_bloc.dart';
import 'package:supermarket/features/Address/presentation/widgets/location_widget.dart';

class AddressScreen extends StatefulWidget {
  final Address? address;
  const AddressScreen({super.key, this.address});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AddressCubit _addressCubit = getIt<AddressCubit>();

  @override
  void initState() {
    _addressCubit.setAddress(widget.address);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressCubit, BaseState<Address>>(
      bloc: _addressCubit,
      listener: (context, state) {
        if (state.isFailure) {
          showErrorSnackBar(context, state.failure?.message);
        } else if (state.isSuccess) {
          if (state.item != null) {
            context.read<AddressesBloc>().add(
              widget.address == null
                  ? AddAddress(state.item!)
                  : UpdateAddress(state.item!),
            );
          }
          showSuccessSnackBar(
            context,
            widget.address == null
                ? LocaleKeys.addressAdded.tr(context: context)
                : LocaleKeys.addressUpdated.tr(context: context),
          );
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.address == null
                ? LocaleKeys.addAddress.tr(context: context)
                : LocaleKeys.editAddress.tr(context: context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: UIMetrics.xs,
            horizontal: UIMetrics.sm,
          ),
          children: [
            const SizedBox(height: UIMetrics.lg),
            LocationWidget(
              latitude: widget.address?.details.position.latitude,
              longitude: widget.address?.details.position.longitude,
            ),
            const SizedBox(height: UIMetrics.sm),
            const Divider(color: AppColors.BORDER_COLOR),
            const SizedBox(height: UIMetrics.sm),
            Form(
              key: _formKey,
              child: Column(
                spacing: UIMetrics.sm,
                children: [
                  AppTextField(
                    hint: LocaleKeys.label.tr(context: context),
                    label: LocaleKeys.label.tr(context: context),
                    initialValue: widget.address?.details.label,
                    keyboardType: TextInputType.name,
                    onChanged: (value) => _addressCubit.setValues(label: value),
                    validator: Validators.requiredValidator,
                  ),
                  Row(
                    spacing: UIMetrics.sm,
                    children: [
                      Expanded(
                        child: AppTextField(
                          initialValue: widget.address?.details.state,
                          hint: LocaleKeys.state.tr(context: context),
                          label: LocaleKeys.state.tr(context: context),
                          keyboardType: TextInputType.name,
                          onChanged: (value) =>
                              _addressCubit.setValues(state: value),
                          validator: Validators.requiredValidator,
                        ),
                      ),
                      Expanded(
                        child: AppTextField(
                          initialValue: widget.address?.details.city,
                          hint: LocaleKeys.city.tr(context: context),
                          label: LocaleKeys.city.tr(context: context),
                          keyboardType: TextInputType.name,
                          onChanged: (value) =>
                              _addressCubit.setValues(city: value),
                          validator: Validators.requiredValidator,
                        ),
                      ),
                    ],
                  ),
                  AppTextField(
                    initialValue: widget.address?.details.street,
                    hint: LocaleKeys.street.tr(context: context),
                    label: LocaleKeys.street.tr(context: context),
                    keyboardType: TextInputType.name,
                    onChanged: (value) =>
                        _addressCubit.setValues(street: value),
                  ),
                  Row(
                    spacing: UIMetrics.sm,
                    children: [
                      Expanded(
                        child: AppTextField(
                          initialValue: widget.address?.details.blockNumber,
                          hint: LocaleKeys.blockNumber.tr(context: context),
                          label: LocaleKeys.blockNumber.tr(context: context),
                          onChanged: (value) =>
                              _addressCubit.setValues(blockNumber: value),
                        ),
                      ),
                      Expanded(
                        child: AppTextField(
                          initialValue: widget.address?.details.buildingName,
                          hint: LocaleKeys.buildingName.tr(context: context),
                          label: LocaleKeys.buildingName.tr(context: context),
                          keyboardType: TextInputType.name,
                          onChanged: (value) =>
                              _addressCubit.setValues(buildingName: value),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: UIMetrics.sm,
                    children: [
                      Expanded(
                        child: AppTextField(
                          initialValue: widget.address?.details.floorNumber,
                          hint: LocaleKeys.floorNumber.tr(context: context),
                          label: LocaleKeys.floorNumber.tr(context: context),
                          onChanged: (value) =>
                              _addressCubit.setValues(floorNumber: value),
                        ),
                      ),
                      Expanded(
                        child: AppTextField(
                          initialValue: widget.address?.details.apartmentNumber,
                          hint: LocaleKeys.apartmentNumber.tr(context: context),
                          label: LocaleKeys.apartmentNumber.tr(
                            context: context,
                          ),
                          onChanged: (value) =>
                              _addressCubit.setValues(apartmentNumber: value),
                        ),
                      ),
                    ],
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: IntlPhoneField(
                      initialValue: widget.address?.details.phoneNumber,
                      dropdownTextStyle: TextStyle(color: Colors.black),
                      invalidNumberMessage: LocaleKeys.invalidNumber.tr(
                        context: context,
                      ),
                      autovalidateMode: AutovalidateMode.disabled,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        hintText: LocaleKeys.phoneNumber.tr(context: context),
                        prefixIcon: const Icon(Icons.phone),
                        errorText: LocaleKeys.invalidPhoneNumber.tr(
                          context: context,
                        ),
                      ),
                      pickerDialogStyle: PickerDialogStyle(
                        countryCodeStyle: TextStyle(color: Colors.black),
                        countryNameStyle: TextStyle(color: Colors.black),
                      ),
                      style: TextStyle(color: Colors.black),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      showDropdownIcon: true,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) => _addressCubit.setValues(
                        phoneNumber: value.completeNumber.trim(),
                      ),
                      validator: (value) =>
                          Validators.phoneNumberValidator(value),
                    ),
                  ),
                  AppTextField(
                    initialValue: widget.address?.details.additionalInfo,
                    hint: LocaleKeys.additionalInfo.tr(context: context),
                    label: LocaleKeys.additionalInfo.tr(context: context),
                    onChanged: (value) =>
                        _addressCubit.setValues(additionalInfo: value),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: UIMetrics.md),
            BlocBuilder<AddressCubit, BaseState<Address>>(
              bloc: _addressCubit,
              builder: (context, state) {
                return AppButton(
                  title: LocaleKeys.addAddress.tr(context: context),
                  expanded: true,
                  isLoading: state.isLoading,
                  onPress: () {
                    if ((_formKey.currentState?.validate() ?? false) &&
                        _addressCubit.isLocationSet) {
                      widget.address == null
                          ? _addressCubit.addAddress()
                          : _addressCubit.updateAddress(widget.address!.id);
                    } else {
                      showErrorSnackBar(
                        context,
                        LocaleKeys.fillRequired.tr(context: context),
                      );
                    }
                  },
                );
              },
            ),
            const SizedBox(height: UIMetrics.md),
          ],
        ),
      ),
    );
  }
}
