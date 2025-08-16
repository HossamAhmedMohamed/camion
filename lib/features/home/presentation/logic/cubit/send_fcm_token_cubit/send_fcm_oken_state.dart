part of 'send_fcm_oken_cubit.dart';

 
sealed class SendFcmOkenState {}

final class SendFcmOkenInitial extends SendFcmOkenState {}

final class SendFcmOkenLoading extends SendFcmOkenState {}

final class SendFcmOkenSuccess extends SendFcmOkenState {}

final class SendFcmOkenError extends SendFcmOkenState {
  final ApiErrorModel error;
  SendFcmOkenError(this.error);
}
