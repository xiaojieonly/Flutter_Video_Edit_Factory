import 'dart:ui';

class VideoAttribute {
  VideoAttribute();

  String inputPath = "";

  String outputPath = "";

  String size = "";

  String videoType = "";

  String imageType = "jpg";

  String fps = "";

  String cutByTime = "";

  int waitTimeOut = 999;

  String name = "";

  String bitRate = "";

  String outputSize = "";

  String addWaterMark = "";

  String get outputFilePath {
    return "$outputPath/$name.$videoType";
  }

  String get outputImagePath {
    return "$outputPath/$name.$imageType";
  }

  /// [size] : 在Android和iOS中可能会存在宽高相反的情况，
  /// 如果出现这种情况建议通过[Platform.isAndroid]/[Platform.isIOS]进行单独适配
  /// [size]: In Android and iOS, the width and height may be opposite,
  /// If this happens, it is recommended to use
  /// [Platform.is Android]/[Platform.is IOS] for individual adaptation
  String getVideoPreviewImage({int timeFrame = 1, Size? size}) {
    if (null != size) {
      return "-i $inputPath -ss $timeFrame -f image2 -s ${size.width}x${size.height} $outputImagePath";
    }
    return "-i $inputPath -ss $timeFrame -f image2 $outputImagePath";
  }

  @override
  String toString() {
    return "-i $inputPath $addWaterMark$fps$size$bitRate$cutByTime$outputSize$outputFilePath";
  }
}
