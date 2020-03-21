



import 'package:flutter/material.dart';

class FlowLayoutDemo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FlowLayoutDemoState();
  }

}

class FlowLayoutDemoState extends State<FlowLayoutDemo> {

  final sides = [60.0,50.0,40.0,30.0];
  final colors = [Colors.red,Colors.yellow,Colors.blue,Colors.green];


  @override
  Widget build(BuildContext context) {

    return Material(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "example 1"
            ),
            Flow(
              delegate: _Delegate(),
              children: sides.map((e) => _buildItem(e)).toList(),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildItem(double e){
    return Container(
      width: e,
      alignment: Alignment.center,
      height: e,
      color: colors[sides.indexOf(e)],
      child: Text("$e"),
    );
  }
}


class _Delegate extends FlowDelegate{
  @override
  void paintChildren(FlowPaintingContext context) {
    //绘制孩子
    var size = context.size;
    for(int i=0;i<context.childCount;i++){
      if(i==1){
        var tr = context.getChildSize(i);
        //第i个 child 移动到右侧
        context.paintChild(i,transform: Matrix4.translationValues(size.width-tr.width, 0, 0));
      }else{
        context.paintChild(i);
      }
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {

    return true;
  }

}

class _AngleDelegate extends FlowDelegate{

  Matrix4 m4;

  @override
  void paintChildren(FlowPaintingContext context) {
    var size = context.size;
    for(int i=0 ; i<context.childCount;i++){
      var cSize = context.getChildSize(i);
      switch(i){
        case 1:
          m4 = Matrix4.translationValues(size.width - cSize.width, 0, 0);
          break;
        case 2:
          m4 = Matrix4.translationValues(0, size.height-cSize.height, 0);
          break;
        case 3:
          m4 = Matrix4.translationValues(size.width - cSize.width, size.height - cSize.height, 0);
          break;
      }
      context.paintChild(i,transform: m4);
    }

  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {

    return true;
  }

}






















