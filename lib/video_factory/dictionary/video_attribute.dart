class VideoAttribute{

  VideoAttribute();

  String inputPath = "";

  String outputPath = "";

  String size = "";

  String videoType = "";

  String imageType = "jpg";

  String fps = "";

  String cutByTime = "";

  int waitTimeOut = 99999;

  String name = "";

  String bitRate = "";

  String outputSize = "";

  String get outputFilePath{
    return "$outputPath/$name.$videoType";
  }

  String get outputImagePath{
    return "$outputPath/$name.$imageType";
  }

  String getVideoPreviewImage(){
    return "-i $inputPath -ss 1 -f image2 $outputImagePath";
  }

  @override
  String toString() {
    return "-i $inputPath $fps$size$bitRate$cutByTime$outputSize$outputFilePath";
  }
}