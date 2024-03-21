import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../main.dart';
import '../../widgets/text_compent.dart';

class OtherProduct extends StatefulWidget {
  final List<Widget>? imageSliders;
  final List<String> imgList;
  final bool? isExist;

  const OtherProduct(
      {Key? key,
      required this.imageSliders,
      required this.imgList,
      this.isExist})
      : super(key: key);

  @override
  State<OtherProduct> createState() => _OtherProductState();
}

class _OtherProductState extends State<OtherProduct> {
  var currentIndex = 0;
  var carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isExist == true)
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SectionTextTitle("ผลิตภัณฑ์อื่นๆ"),
              ],
            ),
          ),
        if (widget.isExist!)
          SizedBox(
            height: 6,
          ),
        Container(
          color: widget.isExist! ? HexColor('#FAE4D1') : Colors.transparent,
          child: Column(
              // mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: widget.isExist! ? 10 : 0),
                  width: double.infinity,
                  height: widget.isExist!
                      ? getActualWidth(context) * 0.35
                      : getActualWidth(context) * 0.32,
                  child: CarouselSlider(
                    items: widget.imageSliders,
                    carouselController: carouselController,
                    options: CarouselOptions(
                        clipBehavior: Clip.none,
                        enableInfiniteScroll: false,
                        autoPlay: true,
                        viewportFraction: 0.9,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.imgList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => carouselController.animateToPage(entry.key),
                      child: Row(
                        children: [
                          Container(
                            width: currentIndex == entry.key ? 28.0 : 8,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 4.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: currentIndex == entry.key
                                  ? HexColor('#DB771A').withOpacity(1)
                                  : HexColor('#DB771A').withOpacity(
                                      currentIndex == entry.key ? 1 : 0.4),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ]),
        ),
      ],
    );
  }
}
