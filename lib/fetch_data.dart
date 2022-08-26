import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:http_service1/http_service1.dart';

import 'feed_model.dart';

Future<Either<Exception, Feed>> fetchData() async {
  final service = HttpService(Client(), 'https://encointer.github.io/feed/community_messages/en/cm.json');
  return service.get<Feed>('', fromJson: feedFromJson);
}
