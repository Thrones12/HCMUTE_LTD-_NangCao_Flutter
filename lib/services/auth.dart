import 'package:dio/dio.dart';
import 'storage.dart';

class AuthService {
  late Dio _dio;

  AuthService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:8080/api',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Auto attach token to each request
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await Storage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (e, handler) {
          print('❌ API Error: ${e.response?.statusCode} - ${e.response?.data}');
          return handler.next(e);
        },
      ),
    );
  }

  /// Gọi API login
  Future<Response> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/user/login',
        data: {'email': email, 'password': password},
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  /// Gọi API register
  Future<Response> register({
    required String fullname,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/user/register',
        data: {'fullname': fullname, 'email': email, 'password': password},
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  /// Logout: xóa token đã lưu
  Future<void> logout() async {
    await Storage.clearToken();
  }

  // Hàm xác thực OTP
  Future<bool> verifyOtp(String email, String otp) async {
    try {
      final response = await _dio.get(
        '/user/get-otp',
        queryParameters: {'email': email}, // dùng queryParameters thay vì data
      );
      var resOtp = response.data;
      if (resOtp == otp) {
        await _dio.put('/user/unlock', data: {'email': email});
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  /// Gọi API forgot password
  Future<Response> lock({required String email}) async {
    try {
      final response = await _dio.put('/user/lock', data: {'email': email});

      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  /// Gọi API regenerate password
  Future<Response> regeneratePassword({required String email}) async {
    try {
      final response = await _dio.put(
        '/user/regenerate-password',
        data: {'email': email},
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }
}
