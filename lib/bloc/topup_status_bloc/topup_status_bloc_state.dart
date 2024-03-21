part of 'topup_status_bloc_bloc.dart';

abstract class TopupStatusBlocState extends Equatable {
  const TopupStatusBlocState();
  
  @override
  List<Object> get props => [];
}

class TopupStatusBlocInitial extends TopupStatusBlocState {}
