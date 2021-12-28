class VideoOffset {
  String _offset = '';

  VideoOffset(int dx, int dy) {
    _offset = _setOffset(dx, dy);
  }

  VideoOffset.topLeft() {
    _offset = _setOffset(10, 10);
  }

  /// main_w	视频单帧图像宽度 / Video single frame image width
  /// main_h	视频单帧图像高度 / Video single frame image height
  /// overlay_w	水印图片的宽度 / The width of the watermark image
  /// overlay_h	水印图片的高度 / The height of the watermark image
  VideoOffset.setWithStringOrder(String dx, String dy) {
    _offset = _setOffset(dx, dy);
  }

  VideoOffset.topRight() {
    _offset = _setOffset('main_w-overlay_w-10', 10);
  }

  VideoOffset.bottomLeft() {
    _offset = _setOffset(10, 'main_h-overlay_h-10');
  }

  VideoOffset.bottomRight() {
    _offset = _setOffset('main_w-overlay_w-10', 'main_h-overlay_h-10');
  }

  String _setOffset(var dx, var dy) {
    return "[watermark];[in][watermark] overlay= $dx:$dy [out] ";
  }

  @override
  String toString() {
    return _offset;
  }
}
