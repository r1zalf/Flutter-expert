import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

class CustomNetwork {
  Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('assets/themovie.crt');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }

  Future<dynamic> get(Uri url) async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);

    return ioClient.get(url);
  }
  
}
