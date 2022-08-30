import 'package:flutter/material.dart';


import '../utils/globals.dart';



class Themes {
  static final light = ThemeData.light().copyWith(
      iconTheme: IconThemeData(color: IColor().LIGHT_PRIMARY_COLOR),
      backgroundColor: Colors.transparent,
      brightness: Brightness.light,
      primaryColor: IColor().LIGHT_PRIMARY_COLOR,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: IColor().LIGHT_ACCENT_COLOR,
      ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          padding:
          const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BUTTON_RADIUS),
          ),
          //
          elevation: 10,
          shadowColor: IColor().LIGHT_PRIMARY_COLOR.withOpacity(0.5),
          primary: IColor().LIGHT_PRIMARY_COLOR,
          onPrimary: Colors.white,
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontFamily: "OpenSans",color: Colors.white)
        // backgroundColor: MaterialStateProperty.all<Color>(IColor().LIGHT_ACCENT_COLOR)
      ),
    ),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ElevatedButton.styleFrom(
      //         padding:
      //         const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(BUTTON_RADIUS),
      //         ),
      //         //
      //         primary: Colors.red,
      //         onPrimary: Colors.black54,
      //         textStyle: const TextStyle(fontWeight: FontWeight.bold)
      //       // backgroundColor: MaterialStateProperty.all<Color>(IColor().LIGHT_ACCENT_COLOR)
      //     )),
      textTheme: TextTheme(

        subtitle2:
        TextStyle(
            color: IColor().LIGHT_PRIMARY_COLOR,
            fontWeight: FontWeight.bold,
            fontSize: 10),
        headline1: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600),
      ).apply(fontFamily:"OpenSans",),

      // inputDecorationTheme: InputDecorationTheme(
      //   border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(INPUT_RADIUS),
      //       borderSide: BorderSide.none),
      //   filled: true,
      //   fillColor: Colors.red,
      // )
  );
  static final dark = ThemeData.dark().copyWith(
      iconTheme: IconThemeData(color: IColor().DARK_PRIMARY_COLOR),
      unselectedWidgetColor: Colors.red,
      primaryColorDark: IColor().DARK_BUTTOM_COLOR,
      checkboxTheme: CheckboxThemeData(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        fillColor: MaterialStateProperty.all(IColor().Dark_CHECK_COLOR),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      brightness: Brightness.dark,
      backgroundColor: IColor().DARK_BG_COLOR,
      primaryColor: IColor().DARK_PRIMARY_COLOR,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: IColor().DARK_PRIMARY_COLOR,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              padding:
              const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BUTTON_RADIUS),
              ),
              //
              elevation: 10,
              shadowColor: IColor().DARK_PRIMARY_COLOR.withOpacity(0.5),
              primary: IColor().DARK_PRIMARY_COLOR,
              onPrimary: Colors.black87,
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: "OpenSans")
            // backgroundColor: MaterialStateProperty.all<Color>(IColor().LIGHT_ACCENT_COLOR)
          ),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
            color: IColor().DARK_TEXT_COLOR,
            fontSize: 22,
            fontWeight: FontWeight.w600),
        subtitle1: TextStyle(
            color: IColor().DARK_TEXT_COLOR.withOpacity(0.6),
            fontWeight: FontWeight.normal,
            fontSize: 16),
        subtitle2: TextStyle(
            color: IColor().DARK_PRIMARY_COLOR,
            fontWeight: FontWeight.normal,
            fontSize: 10),
        headline2: TextStyle(
            color: IColor().Dark_CHECK_COLOR,
            fontWeight: FontWeight.normal,
            fontSize: 14),
      ).apply(fontFamily:"OpenSans",),
      // inputDecorationTheme: InputDecorationTheme(
      //   border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(INPUT_RADIUS),
      //       borderSide: BorderSide.none),
      //   filled: true,
      //   fillColor: IColor().DARK_INPUT_COLOR,
      // )
  );
}

class IColor {
  Color LIGHT_PRIMARY_COLOR = Color(0xff007AFF);
  Color LIGHT_HOME_LIST_BG_COLOR = Color(0xffF2F2F7);
  Color LIGHT_ACCENT_COLOR = Colors.orange;
  Color LIGHT_TEXT_COLOR = Colors.black;
  Color LIGHT_INPUT_COLOR = Color(0xffE0E0E6);
  Color LIGHT_ICON_COLOR = Colors.black26.withOpacity(0.1);
  Color LIGHT_BUTTON_COLOR = Color(0xffE0E0E6);
  Color LIGHT_BG_COLOR = Colors.white;
  Color LIGHT_TOKEN_WIDGET_COLOR = Color(0xffE0E0E6);

  Color DARK_TOKEN_WIDGET_COLOR = Color(0xff2C2C2E);
  Color DARK_BG_COLOR = Color(0xff131212);
  Color DARK_PRIMARY_COLOR = Color(0xffFFD60A);
  Color Dark_CHECK_COLOR = Color(0xff30D158);
  Color DARK_ACCENT_COLOR = Colors.lightBlueAccent;
  Color DARK_TEXT_COLOR = Color(0xFFFFFFFF);
  Color DARK_INPUT_COLOR = Colors.black26;
  Color DARK_HOME_LIST_BG_COLOR = Color(0xff1C1C1E);
  Color DARK_HOME_LIST_COLOR = Color(0xff2C2C2E);
  Color DARK_RULE_WIDGET_COLOR = Color(0xff636366);
  Color DARK_BUTTOM_COLOR = Color(0xffF2F2F7);
  Color DARK_WARNING_COLOR = Color(0xffFF453A);
  Color DARK_HOME_LIST_ITEM_COLOR = Color(0xff2C2C2E);
}
