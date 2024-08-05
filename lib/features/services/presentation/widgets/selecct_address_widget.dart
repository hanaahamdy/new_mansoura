import 'package:new_mansoura/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/utils/texts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SelectAddressWidget extends StatelessWidget {
  final Function function;
  final int? id;
  final int? catId;


   const SelectAddressWidget({Key? key, required this.function, required this.id, required this.catId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6.w)),
          color: ColorManager.lightGrey
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 17.h, top: 17.h),
        child: Row(
          children: [

            font14Text('اختر العنوان', fontWeight: FontWeight.w900),
            Spacer(),
            SvgPicture.asset(ImageAssets.arrow_right),
          ],
        ),
      ),
    ).onTap(() async{
    // var address =  await   Get.to(AddressPage(id: id , catId: catId, add: true));
    // function(address);
    // print('address: $address');
    });
  }
}
