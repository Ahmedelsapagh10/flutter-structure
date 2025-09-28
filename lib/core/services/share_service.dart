import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  static shareContent({required String data, required BuildContext context}) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      data,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
