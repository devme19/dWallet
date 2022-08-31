import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';

class SecretPhraseItemWidget extends StatefulWidget {
  SecretItem? secretItem;
  ValueChanged<SecretItem>? remove;
  ValueChanged<SecretItem>? add;
  SecretPhraseItemWidget({Key? key,this.secretItem,this.remove,this.add}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SecretPhraseItemWidgetState createState() => _SecretPhraseItemWidgetState();
}

class _SecretPhraseItemWidgetState extends State<SecretPhraseItemWidget> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap:widget.remove!=null || widget.add!=null? (){
          setState(() {
            selected = !selected;
          });
          widget.secretItem!.widget = widget;
          if(selected){
            widget.add!(widget.secretItem!);
          }else{
            widget.remove!(widget.secretItem!);
          }
        }:null,
        child: Container(
          margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: selected?IColor().DARK_TEXT_COLOR.withOpacity(0.6):Colors.transparent,
            border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(16.0)
        ),
        child: Row(
          children: [
            widget.remove==null?widget.secretItem!.index!= null?Text('${widget.secretItem!.index!}- ',style: TextStyle(color: Colors.grey),):Container():Container(),
            Text(widget.secretItem!.title!,style: const TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
    ),
      );
  }
}
class SecretItem{
String? title;
int? index;
Widget? widget;
SecretItem({this.title, this.index,this.widget});

}
