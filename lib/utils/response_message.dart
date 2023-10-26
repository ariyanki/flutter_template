import 'package:flutter_template/i18n/strings.g.dart';

class ResponseMessage {
  static String getResponseMessageTitleFromResCode(String? rescode) {
    switch (rescode) {
      case '025017':
        return 'Login Gagal';
      default:
        return t.common_.errorSnackbar.title;
    }
  }

  static String getResponseMessageDescFromResCode(String? rescode) {
    switch (rescode) {
      case '000102':
        return 'Sesi Anda telah berakhir, silahkan refresh atau mencoba login kembali.';
      default:
        return 'Sistem kami sedang mengalami gangguan, silahkan mencoba kembali.';
    }
  }
}
