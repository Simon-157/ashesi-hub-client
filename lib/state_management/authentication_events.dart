abstract class AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {}

class LogoutEvent extends AuthenticationEvent {}

class CheckAuthenticationEvent extends AuthenticationEvent {}
