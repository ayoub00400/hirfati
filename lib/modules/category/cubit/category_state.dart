part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}
class CatSearchResultLoading extends CategoryState {}
class CatSearchResultDone extends CategoryState {}
class CatSearchResultFailed extends CategoryState {}
