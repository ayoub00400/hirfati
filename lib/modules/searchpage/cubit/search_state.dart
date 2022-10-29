part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}
class SearchResultLoading extends SearchInitial {}
class SearchResultDone extends SearchInitial {}
class SearchResultFailed extends SearchInitial {}

