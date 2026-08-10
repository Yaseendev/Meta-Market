part of 'addresses_bloc.dart';

sealed class AddressesEvent extends Equatable {
  const AddressesEvent();

  @override
  List<Object> get props => [];
}

class GetAddresses extends AddressesEvent {
  const GetAddresses();
}

class MarkAsCurrent extends AddressesEvent {
  final Address address;

  const MarkAsCurrent(this.address);

  @override
  List<Object> get props => [address];
}

class DeleteAddress extends AddressesEvent {
  final Address address;

  const DeleteAddress(this.address);

  @override
  List<Object> get props => [address];
}

class AddAddress extends AddressesEvent {
  final Address address;

  const AddAddress(this.address);

  @override
  List<Object> get props => [address];
}

class UpdateAddress extends AddressesEvent {
  final Address address;

  const UpdateAddress(this.address);

  @override
  List<Object> get props => [address];
}
