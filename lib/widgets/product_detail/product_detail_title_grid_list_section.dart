import 'package:flutter/material.dart';
import 'package:mobile_application_srisawad/models/product_detail/product_detail_content_model.dart';

import '../../models/product_detail/product_detail_title_content_list_model.dart';
import '../text_compent.dart';

class ProductDetailTitleGridListSection extends StatelessWidget {
  const ProductDetailTitleGridListSection({Key? key, required this.data})
      : super(key: key);
  final ProductDetailTitleContentListModel? data;

  @override
  Widget build(BuildContext context) {
    if (data != null &&
        data!.title != null &&
        data!.title!.isNotEmpty &&
        data!.content != null &&
        data!.content!.isNotEmpty) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Subtitle2(data!.title!).styleSecondary(),
            SizedBox(
              height: 12,
            ),
            ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 12,
                );
              },
              padding: EdgeInsets.symmetric(vertical: 0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: (data!.content!.length / 2).round(),
              itemBuilder: (context, index) {
                print(data!.content!.length);
                var data1 = data!.content![index == 0
                    ? index
                    : index == 1
                        ? index + 1
                        : index + 2];
                var widget1 = Expanded(
                  flex: 1,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(data1.imageUrl ?? "",
                              width: 86, height: 86, fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                            return SizedBox(
                              height: 86,
                              width: 86,
                            );
                          }),
                          Subtitle2(data1.description ?? "", TextAlign.center)
                              .styleSecondary(),
                        ],
                      ),
                    ),
                  ),
                );
                var widget2 = Expanded(
                  child: Container(),
                  flex: 1,
                );

                if (index + 1 < data!.content!.length) {
                  ProductDetailContentModel data2 =
                      data!.content![index == 0 ? index + 1 : index + 2];
                  widget2 = Expanded(
                    flex: 1,
                    child: Container(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16),
                          child: data!.content!.length == 5 && index + 3 == 5
                              ? SizedBox(
                                  height: 86,
                                  width: 86,
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      data2.imageUrl ?? "",
                                      width: 86,
                                      height: 86,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return SizedBox(
                                          height: 86,
                                          width: 86,
                                        );
                                      },
                                    ),
                                    Subtitle2(data2.description ?? "",
                                            TextAlign.center)
                                        .styleSecondary(),
                                  ],
                                )),
                    ),
                  );
                }
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [widget1, widget2],
                );
              },
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
