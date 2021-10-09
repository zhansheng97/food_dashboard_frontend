import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_dashboard/screens/home/home_screen.dart';
import 'package:food_dashboard/screens/restaurant_management/restaurant_management.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageInitial()) {
    on<ChangePageEvent>((event, emit) {
      switch (event.index) {
        case 0:
          emit(PageLoaded(HomeScreen()));
          break;
        case 1:
          emit(PageLoaded(RestaurantManagement()));
          break;
        default:
          emit(PageLoaded(HomeScreen()));
      }
    });
  }
}
