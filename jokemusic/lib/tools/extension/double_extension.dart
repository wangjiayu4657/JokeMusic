import '../share/const_config.dart';

extension DoubleFit on double {
  double get rpx => ratio * this;
  double get px => rpx * 2;
}