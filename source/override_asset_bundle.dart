import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAssetBundle(
      bundle: FallbackAssetBundle(fallbackKey: 'assets/error.png'),
      child: TestWidget(),
    );
  }
}

/// Used to load a fallback asset when the main asset is not found.
class FallbackAssetBundle extends CachingAssetBundle {
  final String? fallbackKey;

  FallbackAssetBundle({required this.fallbackKey});

  Future<ByteData?> _loadAsset(String key) async {
    final Uint8List encoded =
        utf8.encoder.convert(Uri(path: Uri.encodeFull(key)).path);
    final ByteData? asset = await ServicesBinding
        .instance.defaultBinaryMessenger
        .send('flutter/assets', encoded.buffer.asByteData());
    return asset;
  }

  @override
  Future<ByteData> load(String key) async {
    final asset = await _loadAsset(key);
    if (asset != null && asset.lengthInBytes > 0) return asset;

    if (fallbackKey != null) {
      final fallbackAsset = await _loadAsset(fallbackKey!);
      if (fallbackAsset != null) return fallbackAsset;
    }

    throw FlutterError('FallbackAssetBundle - Unable to load asset: $key');
  }
}
