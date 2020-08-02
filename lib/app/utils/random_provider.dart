import 'dart:math';
//封装随机方法

class RandomProvider{
  RandomProvider._();//私有化构造
  static final _random= Random();
  static get random =>_random;
}