import 'dart:io';
import 'dart:convert';

Future<void> main() async {
  final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 4040);
  print('Servidor iniciado em ${server.address.address}:${server.port}');
  print('Aguardando conexões...\n');

  await for (final socket in server) {
    print('Novo dispositivo conectado: ${socket.remoteAddress.address}:${socket.remotePort}');

    socket.listen(
      (data) {
        final mensagem = utf8.decode(data);
        print('📡 Temperatura recebida: $mensagem °C');
      },
      onError: (err) {
        print('Erro: $err');
      },
      onDone: () {
        print('Dispositivo desconectado: ${socket.remoteAddress.address}');
      },
    );
  }
}
