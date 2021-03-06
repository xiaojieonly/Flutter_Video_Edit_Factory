import 'dart:io';

import 'package:ffmpeg_kit_flutter/media_information.dart';
import 'package:ffmpeg_kit_flutter/media_information_session.dart';
import 'package:ffmpeg_kit_flutter/session.dart';
import 'package:video_edit_factory/video_edit_factory.dart';
import 'package:video_edit_factory/video_factory/dictionary/video_offset.dart';

void main() {}

void videoEdit() {
  VideoEditFactory videoEditFactory = new VideoEditFactory(
      inputPath: 'The directory of the target video file to be edited');

  // 获取媒体文件信息
  videoEditFactory.getMediaInfo(executeCallback: (Session session) {
    MediaInformationSession mediaInformationSession =
        session as MediaInformationSession;

    MediaInformation? mediaInformation =
        mediaInformationSession.getMediaInformation();
  });
  File previewImage;
  // 获取视频第一帧图片
  // Get the first picture of the video
  videoEditFactory.videoPreviewImage(executeCallback: (Session session) async {
    await videoEditFactory
        .getVideoPreviewImage(session)
        .then((value) => previewImage = value);
  });

  videoEditFactory
    // 设置视频比特率
    // Set video bit rate
    ..setBitRate(5)
    // 设置视频帧数
    // Set the number of video frames
    ..setOutPutFPS(24)
    // 设置输出文件的大小
    // Set the size of the output file
    ..setOutputVideoSize(54)
    // 设置输出格式
    // Set output format
    ..setType('mp4')
    // 剪切视频指定区间（单位：秒）
    // Cut video specified interval (unit: second)
    ..cutByTime(0, 20)
    // 设置输出文件的宽高
    // Set the width and height of the output file
    ..setOutputVideoSale(1080, 1920)
    // 设置超时时间（仅限获取文件信息时生效）
    // Set the timeout period (valid only when the file information is obtained)
    ..setTimeOut(123)
    // 设置输出文件名称
    // Set the output file name
    ..setOutputName('output file name')
    // 设置文件的输出目录
    // Set the output directory of the file
    ..setOutputPath('the output directory of the file')
    // 添加水印（图片文件，水印位置）
    // Add watermark（Picture file, watermark location）
    ..setPictureWatermark(File('image path'), VideoOffset.topLeft());

  File videoFile;
  // 执行视频编辑命令
  // Execute video editing commands
  videoEditFactory.executeAsync(executeCallback: (Session session) async {
    // 获取输出文件
    // Get output file
    await videoEditFactory
        .getOutputFile(session)
        .then((value) => videoFile = value);
  });
}
