part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();

  @override
  List<Object> get props => [];
}

class ChangePageEvent extends PageEvent {
  final int index;

  ChangePageEvent({required this.index});

  @override
  List<Object> get props => [index];
}
