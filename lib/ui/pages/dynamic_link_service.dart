import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DynamicLinkService {
  static Future handleDynamicLinks(BuildContext context) async {
    //Get initial dynamic link from startup
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();

    _handleDeepLink(context, data);

    //Get initial link from background to foreground
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
        _handleDeepLink(context, dynamicLinkData);
      },

      onError: (OnLinkErrorException e) async {
        print('Dynamic Link Failed: ${e.message}');
      },
    );
  }

  static void _handleDeepLink(BuildContext context, PendingDynamicLinkData data) {
    final Uri deepLink = data?.link;
    if(deepLink != null) {
      print('_handleDeepLink | deepLink: $deepLink');
      Navigator.pushNamed(context, deepLink.path);
    }
  }
}

