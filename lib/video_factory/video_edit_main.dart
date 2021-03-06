import 'dart:io';
import 'dart:ui';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_session_complete_callback.dart';
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter/log_callback.dart';
import 'package:ffmpeg_kit_flutter/media_information_session.dart';
import 'package:ffmpeg_kit_flutter/media_information_session_complete_callback.dart';
import 'package:ffmpeg_kit_flutter/session.dart';
import 'package:ffmpeg_kit_flutter/session_state.dart';
import 'package:ffmpeg_kit_flutter/statistics_callback.dart';

import 'dictionary/video_attribute.dart';
import 'dictionary/video_offset.dart';

class VideoEditFactory {
  final String inputPath;

  late VideoAttribute _videoAttribute;

  VideoEditFactory({required this.inputPath}) {
    _videoAttribute = new VideoAttribute();
    _videoAttribute.inputPath = inputPath;
  }

  executeAsync({
    FFmpegSessionCompleteCallback? executeCallback,
    LogCallback? logCallback,
    StatisticsCallback? statisticsCallback,
  }) async {
    await FFmpegKit.executeAsync(_videoAttribute.toString(), executeCallback,
        logCallback, statisticsCallback);
  }

  videoPreviewImage({
    FFmpegSessionCompleteCallback? executeCallback,
    LogCallback? logCallback,
    StatisticsCallback? statisticsCallback,
    int timeFrame = 1,
    Size? size,
  }) async {
    await FFmpegKit.executeAsync(
        _videoAttribute.getVideoPreviewImage(
          timeFrame: timeFrame,
          size: size,
        ),
        executeCallback,
        logCallback,
        statisticsCallback);
  }

  cancel() {
    FFmpegKit.cancel();
  }

  Future<File> getVideoFirstFrame() async {
    File file = new File("path");

    return file;
  }

  Future<MediaInformationSession> getMediaInfo({
    MediaInformationSessionCompleteCallback? executeCallback,
    LogCallback? logCallback,
  }) async {
    return FFprobeKit.getMediaInformationAsync(
        inputPath, executeCallback, logCallback, _videoAttribute.waitTimeOut);
  }

  static Future<MediaInformationSession> getMediaInfoStatic(
    String inputPath, {
    MediaInformationSessionCompleteCallback? executeCallback,
    LogCallback? logCallback,
    int timeOut = 9999,
  }) async {
    return await FFprobeKit.getMediaInformationAsync(
        inputPath, executeCallback, logCallback, timeOut);
  }

  Future<File> getOutputFile(Session session) async {
    SessionState sessionState = await session.getState();
    if (SessionState.completed == sessionState) {
      return new File("${_videoAttribute.outputFilePath}");
    } else {
      throw new VEException('${sessionState.toString()}', session: session);
    }
  }

  Future<File> getVideoPreviewImage(Session session) async {
    SessionState sessionState = await session.getState();
    if (SessionState.completed == sessionState) {
      return new File("${_videoAttribute.outputImagePath}");
    } else {
      throw new VEException('${sessionState.toString()}', session: session);
    }
  }

  /// ???????????????????????????
  /// Set the output directory of the file
  setOutputPath(String outputPath) {
    _videoAttribute.outputPath = outputPath;
  }

  /// ??????????????????????????????????????????
  /// Cut video specified interval (unit: second)
  cutByTime(int start, int end) {
    _videoAttribute.cutByTime = "-ss $start -to $end ";
  }

  /// ?????????????????????????????????????????????????????????
  /// Set the timeout period (valid only when the file information is obtained)
  setTimeOut(int second) {
    _videoAttribute.waitTimeOut = second;
  }

  /// ????????????????????????
  /// Set the output file name
  setOutputName(String name) {
    _videoAttribute.name = name;
  }

  /// ??????????????????
  /// Set the number of video frames
  setOutPutFPS(int fps) {
    _videoAttribute.fps = "-r $fps ";
  }

  /// ???????????????????????????
  /// Set the size of the output file
  setOutputVideoSize(int mb) {
    _videoAttribute.size = "-fs ${mb}MB ";
  }

  /// ?????????????????????
  /// Set video bit rate
  setBitRate(double mb) {
    _videoAttribute.bitRate = "-b:v ${mb}M ";
  }

  /// ??????????????????
  /// Set output format
  setType(String type) {
    _videoAttribute.videoType = type;
  }

  /// ???????????????????????????
  /// Set the width and height of the output file
  setOutputVideoSale(int width, int height) {
    if (height == -1) {
      _videoAttribute.outputSize = "sale=$width:-1 ";
    } else if (width == -1) {
      _videoAttribute.outputSize = "sale=-1:$height ";
    } else {
      _videoAttribute.outputSize = "-s ${width}x$height ";
    }
  }

  /// ??????????????????
  /// Set image watermark
  setPictureWatermark(File pictureFile, VideoOffset offset) {
    _videoAttribute.addWaterMark =
        "-vf \"movie= ${pictureFile.path} ${offset.toString()}\" ";
  }
}

class VEException implements Exception {
  final Session session;
  final String message;

  VEException(
    this.message, {
    required this.session,
  });

  @override
  String toString() {
    return "${session.toString()}:$message";
  }
}
