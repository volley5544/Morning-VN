import 'package:flutter/material.dart';

import '../../models/product_detail/product_detail_title_bullet_list_model.dart';
import '../text_compent.dart';

class ProductDetailTitleBulletListSection extends StatelessWidget {
  ProductDetailTitleBulletListSection({Key? key, this.data}) : super(key: key);
  ProductDetailTitleBulletListModel? data;

  @override
  Widget build(BuildContext context) {
    if (data != null &&
        data!.title != null &&
        data!.title!.isNotEmpty &&
        data!.bulletList != null &&
        data!.bulletList!.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Subtitle2(data!.title!).styleSecondary(),
          ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 2,
                );
              },
              padding: EdgeInsets.only(top: 4, left: 8),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data!.bulletList!.length,
              itemBuilder: (context, index) {
                var item = data!.bulletList![index];
                String bullet = "\u2022";
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Subtitle2(bullet).styleGrey(),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(child: Body(item).styleGrey()),
                  ],
                );
              })
        ],
      );
    } else {
      return Container();
    }
  }
}
