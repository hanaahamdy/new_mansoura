import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';

bool isEmailValid(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}


Widget heightSpace(double height){
  return SizedBox(height: height);
}


Widget widthSpace(double width){
  return SizedBox(width: width);
}

showModalBottomSheetWidget(BuildContext  context, Widget content){
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.w))
      ),
      context: context,
      // enableDrag: true,
      // useRootNavigator: false,
      isScrollControlled: true,
      backgroundColor: Colors.black12,
      builder: (BuildContext bc){
        return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: content);
      }
  );
}

 showDatePickerFun(BuildContext  context) async{
  DateTime? pickedDate = await showDatePicker(
      context: context, //context of current state
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),

  );
  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
   return formattedDate;
}

pickFile() async{
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  String file = '';
  if(result != null) {
     file = result.files.single.path!;
  }
  return file;
}

pickMultiFiles() async{
  List<String> files= [];
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if(result != null){
    for (var element in result.files) {
      files.add(element.path!);
    }
  }
  return files;
}

showSnackBar(message, BuildContext context){
 SnackBar  snackBar = SnackBar(
    content: Text(message),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

Future<void> openUrl(String url) async {
  if (url.contains("http://") || url.contains("https://")) {
    await canLaunchUrl(Uri.parse(url))
        ? await launchUrl(Uri.parse(url))
        : throw 'Could not launch Url';
  } else {
    String newUrl = "https://$url";
    await canLaunchUrl(Uri.parse(newUrl))
        ? await launchUrl(Uri.parse(newUrl))
        : throw 'Could not launch Url';
  }
}

launchFacebook(String launcher) async {
  String fbProtocolUrl;
  if (Platform.isIOS) {
    fbProtocolUrl = 'fb://profile/page_id';
  } else {
    fbProtocolUrl = 'fb://page/page_id';
  }

  String fallbackUrl =
      launcher.contains("https://") ? launcher : "https://$launcher";

  try {
    //
    bool launched = await launchUrl(Uri.parse(fbProtocolUrl));

    if (!launched) {
      await launchUrl(Uri.parse(fallbackUrl));
    }
  } catch (e) {
    await launchUrl(Uri.parse(fallbackUrl));
  }
}

void openWhatsapp(BuildContext context, String phoneNumber) async {
  var whatsappUrl = "whatsapp://send?phone=2$phoneNumber";
  try {
    bool canLaunchWhatsApp = await canLaunch(whatsappUrl);
    if (canLaunchWhatsApp) {
      await launch(whatsappUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on your device"),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Could not open WhatsApp"),
      ),
    );
  }
}

openLinkdin(context, linkedinLink) async {
  String link = "https://$linkedinLink";
  if (await canLaunchUrl(Uri.parse(link))) {
    return launchUrl(Uri.parse(link));
  } else {
    showSnackBar("يجب تحميل لينكد ان", context);
  }
  //if (Platform.isIOS) {
  // for iOS phone only
  // if (await canLaunchUrl(Uri.parse(whatappURL_ios))) {
  //   await launchUrl(Uri.parse(whatappURL_ios));
  // } else {
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: new Text("يجب تحميل الواتساب")));
  // }

  //} else {

  //}
}

Future<void> sendEmail(email) async {
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
    query: encodeQueryParameters(<String, String>{
      'subject': 'Hello From Conforum',
    }),
  );

  launchUrl(emailLaunchUri);
}

Future<void> showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
            decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.all(Radius.circular(6.w))),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, top: 30.h, bottom: 30.h),
              child: Row(
                children: [
                  CircularProgressIndicator(),
                  widthSpace(20.w),
                  Text('Loading ...........',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.apply(color: ColorManager.primary))
                ],
              ),
            )),
      );
    },
  );
}



showFailureDialoge(BuildContext context, message) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.rightSlide,
    title: 'Failure',
    desc: 'يرجى التأكد من البيانات',
    btnCancelOnPress: () {},
    btnOkOnPress: () {},
  )..show();
}