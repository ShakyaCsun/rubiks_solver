/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsMovesGen {
  const $AssetsMovesGen();

  /// File path: assets/moves/B.png
  AssetGenImage get b => const AssetGenImage('assets/moves/B.png');

  /// File path: assets/moves/B2.png
  AssetGenImage get b2 => const AssetGenImage('assets/moves/B2.png');

  /// File path: assets/moves/BDash.png
  AssetGenImage get bDash => const AssetGenImage('assets/moves/BDash.png');

  /// File path: assets/moves/D.png
  AssetGenImage get d => const AssetGenImage('assets/moves/D.png');

  /// File path: assets/moves/D2.png
  AssetGenImage get d2 => const AssetGenImage('assets/moves/D2.png');

  /// File path: assets/moves/DDash.png
  AssetGenImage get dDash => const AssetGenImage('assets/moves/DDash.png');

  /// File path: assets/moves/F.png
  AssetGenImage get f => const AssetGenImage('assets/moves/F.png');

  /// File path: assets/moves/F2.png
  AssetGenImage get f2 => const AssetGenImage('assets/moves/F2.png');

  /// File path: assets/moves/FDash.png
  AssetGenImage get fDash => const AssetGenImage('assets/moves/FDash.png');

  /// File path: assets/moves/L.png
  AssetGenImage get l => const AssetGenImage('assets/moves/L.png');

  /// File path: assets/moves/L2.png
  AssetGenImage get l2 => const AssetGenImage('assets/moves/L2.png');

  /// File path: assets/moves/LDash.png
  AssetGenImage get lDash => const AssetGenImage('assets/moves/LDash.png');

  /// File path: assets/moves/R.png
  AssetGenImage get r => const AssetGenImage('assets/moves/R.png');

  /// File path: assets/moves/R2.png
  AssetGenImage get r2 => const AssetGenImage('assets/moves/R2.png');

  /// File path: assets/moves/RDash.png
  AssetGenImage get rDash => const AssetGenImage('assets/moves/RDash.png');

  /// File path: assets/moves/U.png
  AssetGenImage get u => const AssetGenImage('assets/moves/U.png');

  /// File path: assets/moves/U2.png
  AssetGenImage get u2 => const AssetGenImage('assets/moves/U2.png');

  /// File path: assets/moves/UDash.png
  AssetGenImage get uDash => const AssetGenImage('assets/moves/UDash.png');
}

class Assets {
  Assets._();

  static const $AssetsMovesGen moves = $AssetsMovesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
