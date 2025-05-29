abstract class AppUrl{
  static final String url = "https://api-motoocotlan.onrender.com";
  static final Uri urlBase = Uri.parse('$url');
  static final Uri urlLogin = Uri.parse('$url/auth/login');
  static final Uri urlRegister = Uri.parse('$url/auth/register');
  
  //routes for driver
  static final Uri urlBetterDriver = Uri.parse('$url/driver/better');
  static final Uri urlAllDriver = Uri.parse('$url/driver');
  static final Uri urlCommentDriver = Uri.parse('$url/driver');
  static final String urlDriverById = '$url/driver/';
  //routes of driver for reservation
  static final String urlgetAllReservations = '$url/driver/reservations/';
  static final String urlDriverCancelReservations = '$url/driver/reservations/cancel/';
  static final String urlDriverAcceptReservations = '$url/driver/reservations/accept/';
  static final String urlgetFinishReservations = '$url/driver/reservations/finish/';

  //routes for fee
  static final String urlFeeByDistance = '$url/rates/search/';

  //routes for reservations
  static final Uri urlRegisterReservation = Uri.parse("$url/reservations");
  static final Uri urlCancelReservation = Uri.parse("$url/client/service/cancel");
  static final Uri urlFindReservation = Uri.parse("$url/reservations/find/");

}