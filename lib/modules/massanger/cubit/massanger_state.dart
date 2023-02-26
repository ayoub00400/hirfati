part of 'massanger_cubit.dart';

@immutable
abstract class MassangerState {}

class MassangerInitial extends MassangerState {}
class MassagesLoading extends MassangerState {}
class MassagesLoadingDone extends MassangerState {}
class MassagesLoadingFailed extends MassangerState {}
