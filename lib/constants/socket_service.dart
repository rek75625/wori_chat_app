// import 'package:flutter/foundation.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class SocketService {
//   static final SocketService _instance = SocketService._internal();

//   factory SocketService() => _instance;

//   SocketService._internal();

//   final FlutterSecureStorage _storage =
//       const FlutterSecureStorage();

//   IO.Socket? _socket;

//   Future<void> initialize() async {
//     if (_socket != null) {
//       return;
//     }

//     final token = await _storage.read(key: 'token') ?? '';

//     _socket = IO.io(
//       'http://localhost:5000',
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .disableAutoConnect()
//           .setExtraHeaders({
//             'Authorization': 'Bearer $token',
//           })
//           .enableReconnection()
//           .build(),
//     );

//     _socket!.onConnect((_) {
//       debugPrint('✅ Connected to socket server');
//       debugPrint('Socket ID: ${_socket!.id}');
//     });

//     _socket!.onConnectError((error) {
//       debugPrint('❌ Socket connection error: $error');
//     });

//     _socket!.onError((error) {
//       debugPrint('❌ Socket error: $error');
//     });

//     _socket!.onDisconnect((reason) {
//       debugPrint('❌ Socket disconnected: $reason');
//     });

//     _socket!.connect();
//   }

//   IO.Socket get socket {
//     if (_socket == null) {
//       throw Exception(
//         'SocketService has not been initialized.',
//       );
//     }

//     return _socket!;
//   }

//   bool get isConnected => _socket?.connected ?? false;
// }

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();

  factory SocketService() => _instance;

  SocketService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  IO.Socket? _socket;

  Future<void> initialize() async {
    if (_socket != null) {
      return;
    }

    final token = await _storage.read(key: 'token') ?? '';

    _socket = IO.io(
      'http://localhost:5000',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .enableReconnection()
          .build(),
    );

    _socket!.onConnect((_) {
      debugPrint('✅ Connected to socket server');
      debugPrint('Socket ID: ${_socket!.id}');
    });

    _socket!.onConnectError((error) {
      debugPrint('❌ Socket connection error: $error');
    });

    _socket!.onError((error) {
      debugPrint('❌ Socket error: $error');
    });

    _socket!.onDisconnect((reason) {
      debugPrint('❌ Socket disconnected: $reason');
    });

    _socket!.connect();
  }

  IO.Socket get socket {
    if (_socket == null) {
      throw Exception('SocketService has not been initialized.');
    }

    return _socket!;
  }

  bool get isConnected => _socket?.connected ?? false;
}
