import 'dart:io';
import 'dart:math';
import 'dart:convert';

Future<void> main() async {
  final random = Random();

  final socket = await Socket.connect(InternetAddress.loopbackIPv4, 4040);
  print('Conectado ao servidor em ${socket.remoteAddress.address}:${socket.remotePort}');
  void enviarTemperatura() {
    final temperatura = 20 + random.nextInt(10);
    socket.write('$temperatura\n'); 
    print('📤 Temperatura enviada: $temperatura °C');
  }

  Timer.periodic(Duration(seconds: 10), (_) => enviarTemperatura());

  await socket.done;
}
