class Urls {
  //user authentication Api
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';

  static const String registration = '$_baseUrl/Registration';

  static const String login = '$_baseUrl/Login';

  static const String profileUpdate = '$_baseUrl/ProfileUpdate';

  static const String profileDetails = '$_baseUrl/ProfileDetails';

  static String recoverVerifyEmail(String email) =>
      '$_baseUrl/RecoverVerifyEmail/$email';

  static String recoverVerifyOtp(String email, String otp) =>
      '$_baseUrl/RecoverVerifyOtp/$email/$otp';

  static const String recoverResetPassword = '$_baseUrl/RecoverResetPassword';

  //user task Api
  static const String createTask = '$_baseUrl/createTask';

  static String deleteTask(String userId) => '$_baseUrl/deleteTask/$userId';

  static String updateTaskStatus(String userId, String status) =>
      '$_baseUrl/updateTaskStatus/$userId/$status';

  static String listTaskByStatus(String status) =>
      '$_baseUrl/listTaskByStatus/$status';

  static const String taskStatusCount = '$_baseUrl/taskStatusCount';
}