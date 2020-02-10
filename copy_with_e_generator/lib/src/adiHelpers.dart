//extension methods for string
import 'package:basic_utils/basic_utils.dart';

extension String_AdiHelpers on String {
bool isNullOrEmpty() {
  return StringUtils.isNullOrEmpty(this);
}

bool isNotNullOrEmpty() {
  return StringUtils.isNotNullOrEmpty(this);
}
}
