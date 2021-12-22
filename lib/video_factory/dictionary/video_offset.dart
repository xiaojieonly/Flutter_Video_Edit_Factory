class VideoOffset {

  String _offset = '';


  VideoOffset(int dx,int dy){
    _offset = _setOffset(dx,dy);
  }

  VideoOffset.topLeft(){

    _offset = _setOffset(10,10);
  }

  VideoOffset.topRight(){

    _offset = _setOffset('main_w-overlay_w-10',10);
  }

  VideoOffset.bottomLeft(){

    _offset = _setOffset(10,'main_h-overlay_h-10');
  }

  VideoOffset.bottomRight(){
    _offset = _setOffset('main_w-overlay_w-10','main_h-overlay_h-10');
  }

  String _setOffset(var dx,var dy){
    return "[watermark];[in][watermark] overlay= $dx:$dy [out] ";
  }

  @override
  String toString() {
    return _offset;
  }
}
