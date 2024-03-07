import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../domain/services/i_calendar_service.dart';
import 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  final ICalendarService calendarService;

  CalendarCubit({
    required this.calendarService,
  }) : super(const InitialState());

  Future<void> fetch({
    DateTime? startDate,
    DateTime? endDate,
    bool refreshing = false,
  }) async {
    try {
      if (!refreshing) {
        emit(const LoadingState());
      }

      final result = await calendarService.fetch(
        startDate: startDate,
        endDate: endDate,
      );

      if (result.isError()) {
        return emit(ErrorState(result.exceptionOrNull()!));
      }

      final data = result.getOrThrow();

      emit(SuccessState(data: data));
    } on GenericException catch (e) {
      emit(ErrorState(e));
    } catch (e) {
      emit(ErrorState(UnknowException(error: e)));
    }
  }
}
