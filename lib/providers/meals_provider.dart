import 'package:meals_app/dumy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
