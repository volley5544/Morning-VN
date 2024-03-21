double widthAdjuster({required double screenWidth, double? widthMod}) {
  if (widthMod == null) {
    return screenWidth;
  }

  if (screenWidth > 500) {
    return 500 * widthMod;
  }
  return screenWidth * widthMod;
}
