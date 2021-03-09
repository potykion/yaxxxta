import 'package:flutter_test/flutter_test.dart';
import 'package:yaxxxta/core/utils/list.dart';

void main() {
  test("chunked", () {
    expect(
      [1, 2, 3].chunked(size: 2).toList(),
      [
        [1, 2],
        [3]
      ],
    );
  });
}
