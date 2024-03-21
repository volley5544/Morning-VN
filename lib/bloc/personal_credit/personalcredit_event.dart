part of 'personalcredit_bloc.dart';

abstract class PersonalcreditEvent extends Equatable {
  const PersonalcreditEvent();

  @override
  List<Object> get props => [];

  // add(setNewName setNewName) {}
}

class setNewName extends PersonalcreditEvent {
  final String newName;
  const setNewName(this.newName);
}

class setLeftToPay extends PersonalcreditEvent {}
