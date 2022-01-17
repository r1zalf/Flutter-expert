import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('should be a subclass of TvSeries', () async {

    TvSeries tvSeries = tvSeriesModel;
    expect(tvSeries, tvSeriesModel);
  });
}
