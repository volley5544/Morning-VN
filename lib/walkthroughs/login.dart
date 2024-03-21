import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '/components/action2_sheet_simple_widget.dart';

// Focus widget keys for this walkthrough
final textField0mut7dyi = GlobalKey();
final textFieldCv11xejx = GlobalKey();
final buttonQvk3d3t3 = GlobalKey();

/// Login
///
/// ให้ใส่Username และ Password เพื่อเข้าสู่ระบบ อรุณสวัสดิ์VN
List<TargetFocus> createWalkthroughTargets(BuildContext context) => [
      /// Step 1
      TargetFocus(
        keyTarget: textField0mut7dyi,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.Circle,
        color: Colors.black,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, __) => const Action2SheetSimpleWidget(),
          ),
        ],
      ),

      /// Step 2
      TargetFocus(
        keyTarget: textFieldCv11xejx,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.Circle,
        color: Colors.black,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, __) => const Action2SheetSimpleWidget(),
          ),
        ],
      ),

      /// Step 3
      TargetFocus(
        keyTarget: buttonQvk3d3t3,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.Circle,
        color: Colors.black,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, __) => const Action2SheetSimpleWidget(),
          ),
        ],
      ),
    ];
