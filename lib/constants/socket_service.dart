import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;

  late IO.Socket _socket;
  final _storage = FlutterSecureStorage();
  SocketService._internal() {
    _initializeSocket();
  }

  Future<void> _initializeSocket() async {
    String token = await _storage.read(key: 'token') ?? '';
    _socket = IO.io(
      "http://localhost:5000",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .build(),
    );
    _socket.connect();
    _socket.onConnect((_) {
      print('Connected to socket server');
    });
    _socket.onDisconnect((_) {
      print('Disconnected from socket server');
    });
  }

  IO.Socket get socket => _socket;
}
