import 'dart:io';

import 'package:ffmpeg_kit_flutter/execute_callback.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter/log_callback.dart';
import 'package:ffmpeg_kit_flutter/media_information_session.dart';
import 'package:ffmpeg_kit_flutter/session.dart';
import 'package:ffmpeg_kit_flutter/session_state.dart';
import 'package:ffmpeg_kit_flutter/statistics_callback.dart';

import 'dictionary/video_attribute.dart';

class VideoEditFactory {
  final String inputPath;

  late VideoAttribute _videoAttribute;

  VideoEditFactory({required this.inputPath}) {
    _videoAttribute = new VideoAttribute();
    _videoAttribute.inputPath = inputPath;
  }

  executeAsync({
    ExecuteCallback? executeCallback,
    LogCallback? logCallback,
    StatisticsCallback? statisticsCallback,
  }) async {
    await FFmpegKit.executeAsync(_videoAttribute.toString(), executeCallback,
        logCallback, statisticsCallback);
  }

  videoPreviewImage({
    ExecuteCallback? executeCallback,
    LogCallback? logCallback,
    StatisticsCallback? statisticsCallback,
  }) async {
    await FFmpegKit.executeAsync(_videoAttribute.getVideoPreviewImage(),
        executeCallback, logCallback, statisticsCallback);
  }

  cancel() {
    FFmpegKit.cancel();
  }

  Future<File> getVideoFirstFrame() async {
    File file = new File("path");

    return file;
  }

  Future<MediaInformationSession> getVideoInfo(
    String inputPath, {
    ExecuteCallback? executeCallback,
    LogCallback? logCallback,
    int timeOut = 9999,
  }) async {
    return FFprobeKit.getMediaInformationAsync(
        inputPath, executeCallback, logCallback, timeOut);
  }

  static Future<MediaInformationSession> getMediaInfo(
    String inputPath, {
    ExecuteCallback? executeCallback,
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

  outputPathBuild(String outputPath) {
    _videoAttribute.outputPath = outputPath;
  }

  cutByTime(int start, int end) {
    _videoAttribute.cutByTime = "-ss $start -to $end ";
  }

  setTimeOut(int waitTimeOut) {
    _videoAttribute.waitTimeOut = waitTimeOut;
  }

  setOutputName(String name) {
    _videoAttribute.name = name;
  }

  setOutPutFPS(int fps) {
    _videoAttribute.fps = "-r $fps ";
  }

  setOutputVideoSize(int mb) {
    _videoAttribute.size = "-fs ${mb}MB ";
  }

  setBitRate(double mb) {
    _videoAttribute.bitRate = "-b:v ${mb}M ";
  }

  setType(String type) {
    _videoAttribute.videoType = type;
  }

  setOutputVideoSale(int width, int height) {
    if (height == -1) {
      _videoAttribute.outputSize = "sale=$width:-1 ";
    } else if (width == -1) {
      _videoAttribute.outputSize = "sale=-1:$height ";
    } else {
      _videoAttribute.outputSize = "-s ${width}x$height ";
    }
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
