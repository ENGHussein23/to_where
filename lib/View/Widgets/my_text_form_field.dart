import 'package:flutter/material.dart';
import 'package:info_popup/info_popup.dart';
import 'package:to_where/Controller/Constants/my_colors.dart';
import 'package:to_where/Controller/Constants/strings.dart';

final outlineInputBorderRad40=OutlineInputBorder(
  borderSide:  BorderSide(color: almost_white),
  borderRadius: BorderRadius.circular(40),
);
final outlineInputBorderRad15=OutlineInputBorder(
  borderSide:  BorderSide(color: almost_white),
  borderRadius: BorderRadius.circular(15),
);

// class MyTextFormField extends StatelessWidget{
//
//   late TextEditingController myController;
//   late String myLabel;
//   MyTextFormField(this.myController,this.myLabel);
//
//   @override
//   Widget build(BuildContext context) {
//     return   Directionality(
//         textDirection: TextDirection.rtl,
//         child:Column(
//           children: [
//             Align(alignment: Alignment.topRight,child: Text(myLabel,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w800),),),
//             SizedBox(height: 40,
//               child:  TextFormField(
//                 controller: myController,
//                 style: const TextStyle(color: Colors.black),
//                 textAlignVertical: TextAlignVertical.bottom,
//                 textAlign: TextAlign.right,
//                 textDirection: TextDirection.ltr,
//                 decoration: InputDecoration(
//                   // hintText: myLabel,
//                   contentPadding: EdgeInsets.only(left: 20,right: 20,bottom: 20),
//                     enabledBorder:outlineInputBorderRad15,
//                     focusedBorder:outlineInputBorderRad15,
//                     border: outlineInputBorderRad15,
//                     fillColor: almost_white,
//                     filled: true,
//
//                 ),
//
//               ),)
//           ],
//         )
//           );
//   }
//
//
// }

class MyTextFormField extends StatelessWidget {
  late final TextEditingController myController;
  late final String myLabel;
  final String? errorText;
MyTextFormField(this.myController, this.myLabel, {this.errorText});

@override
Widget build(BuildContext context) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Text(
            myLabel,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SizedBox(
          height: (errorText!=''&&errorText!=null)?68:40,
          child: TextFormField(
            controller: myController,
            style: const TextStyle(color: Colors.black),
            textAlignVertical: TextAlignVertical.bottom,
            textAlign: TextAlign.right,
            textDirection: TextDirection.ltr,
            decoration: InputDecoration(
              // hintText: errorText,
              contentPadding:
              EdgeInsets.only(left: 20, right: 20, bottom: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: errorText != null ? Colors.red : almost_white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: errorText != null ? Colors.red : almost_white,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: errorText != null ? Colors.red : almost_white,
                ),
              ),
              errorText: errorText,
              fillColor: almost_white,
              filled: true,
            ),
          ),
        )
      ],
    ),
  );
}
}

class MyPassFormField extends StatefulWidget {
  final TextEditingController myController;
  final String myLabel;
  final String? errorText;
  MyPassFormField(this.myController, this.myLabel, {this.errorText});

  @override
  _MyPassFormFieldState createState() => _MyPassFormFieldState();
}
class _MyPassFormFieldState extends State<MyPassFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child:
            InfoPopupWidget(
              arrowTheme: InfoPopupArrowTheme(color: Colors.white),
              contentTitle: PasswordRules,
              contentTheme: const InfoPopupContentTheme(
                infoContainerBackgroundColor: Colors.white,
                infoTextStyle: TextStyle(color: Colors.black),
                contentPadding: EdgeInsets.all(8),
                contentBorderRadius: BorderRadius.all(Radius.circular(10)),
                infoTextAlign: TextAlign.right,

              ),
              areaBackgroundColor: Colors.black12,
              child: Text(
                widget.myLabel,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.w800),
              ),
              // enableLog: true,

            ),
          ),
          SizedBox(
            height:  (widget.errorText!=''&&widget.errorText!=null)?68:40,
            child: TextField(
              controller: widget.myController,
              style: const TextStyle(color: Colors.black),
              obscureText: _obscureText,
              textAlignVertical: TextAlignVertical.bottom,
              textAlign: TextAlign.right,
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                // hintText: widget.myLabel,
                contentPadding: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: widget.errorText != null ? Colors.red : almost_white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: widget.errorText != null ? Colors.red : almost_white,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: widget.errorText != null ? Colors.red : almost_white,
                  ),
                ),
                errorText: widget.errorText,
                fillColor: almost_white,
                filled: true,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class MySearchField extends StatelessWidget{

  late TextEditingController myController;
  late String myLabel;
  MySearchField(this.myController,this.myLabel);

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      height: 45,
      child: Directionality(
          textDirection: TextDirection.rtl,
          child:
          TextFormField(
            controller: myController,
            style: const TextStyle(color: Colors.black),
            textAlignVertical: TextAlignVertical.bottom,
            textAlign: TextAlign.right,
            textDirection: TextDirection.ltr,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20,right: 20,bottom: 10),
              hintText: myLabel,
              prefixIcon: Icon(Icons.search),
              enabledBorder:outlineInputBorderRad40,
              focusedBorder:outlineInputBorderRad40,
              border: outlineInputBorderRad40,
              fillColor: Colors.white,
              filled: true,
            ),
          )),
    );
  }


}


