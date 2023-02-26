part of 'emailcheck_cubit.dart';

@immutable
abstract class EmailcheckState {}

class EmailcheckInitial extends EmailcheckState {}
class VerificationDone extends EmailcheckInitial{}
class VerificationLoading extends EmailcheckInitial{}