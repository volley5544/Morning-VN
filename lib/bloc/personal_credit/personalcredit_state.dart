part of 'personalcredit_bloc.dart';

abstract class PersonalcreditState extends Equatable {
  final PersonalCredit personalCredit;

  const PersonalcreditState({required this.personalCredit});

  @override
  List<Object> get props => [personalCredit];
}

class PersonalcreditInitial extends PersonalcreditState {
  const PersonalcreditInitial({required super.personalCredit});
  // const PersonalcreditInitial(super.personalCredit) : super(null);
}
