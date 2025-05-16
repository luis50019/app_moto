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

}