import 'package:flutter_test/flutter_test.dart';
import 'package:yaxxxta/logic/core/utils/list.dart';

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

  test("joinObject", () {
    expect(
      [1, 2, 3].joinObject(4).toList(),
      [1, 4, 2, 4, 3],
    );
  });
}
