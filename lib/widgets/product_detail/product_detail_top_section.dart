import 'package:flutter/material.dart';

import '../../models/product_detail/product_detail_model.dart';
import '../text_compent.dart';

class ProductDetailTopSection extends StatelessWidget {
  const ProductDetailTopSection({Key? key, this.data}) : super(key: key);
  final ProductDetailTopModel? data;

  @override
  Widget build(BuildContext context) {
    if (data != null &&
        data!.title != null &&
        data!.title!.isNotEmpty &&
        data!.description != null &&
        data!.description!.isNotEmpty) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextTitle(data!.title!).styleSecondary(),
            SizedBox(
              height: 4,
            ),
            Subtitle(data!.description!).styleGrey(),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
