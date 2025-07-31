part of 'admin_authentication_cubit.dart';

sealed class AdminAuthenticationState {}

final class AdminAuthenticationInitial extends AdminAuthenticationState {}

final class AddAdminLoading extends AdminAuthenticationState {}

final class AddAdminSuccess extends AdminAuthenticationState {}

final class AddAdminError extends AdminAuthenticationState {
  final String errorMessage;

  AddAdminError(this.errorMessage);
}
final class LoginAdminLoading extends AdminAuthenticationState {}

final class LoginAdminSuccess extends AdminAuthenticationState {}

final class LoginAdminError extends AdminAuthenticationState {
  final String errorMessage;

  LoginAdminError(this.errorMessage);
}
