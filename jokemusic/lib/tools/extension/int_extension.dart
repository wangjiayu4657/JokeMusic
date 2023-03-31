import '../share/const_config.dart';

extension IntFit on int {
  double get rpx => ratio * this;
  double get px => rpx * 2;
}