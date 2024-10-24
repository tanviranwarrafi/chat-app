import 'package:faker/faker.dart';

class FakeData {
  static Faker _faker = Faker();

  static Person get person => _faker.person;
  static Company get company => _faker.company;

  static String get name => _faker.person.name();
  static String get userName => _faker.internet.userName();
  static String get email => _faker.internet.email();
  static String get phone => _faker.phoneNumber.us();
  static String get image => _faker.image.loremPicsum(random: 10);
  static String get address => _faker.address.streetAddress();
  static DateTime get date => _faker.date.dateTime(minYear: 2000, maxYear: 2024);

  static String get ipv6Address => _faker.internet.ipv6Address();
  static String get word => _faker.lorem.word();
  static String get sentence_1 => _faker.lorem.sentence();
  static String get sentence_3 => _faker.lorem.sentences(3).join(' ');

  static String get country => _faker.address.country();
  static Currency get currency => _faker.currency;
  static Job get job => _faker.job;
  static Sport get sport => _faker.sport;
  static double get latitude => _faker.geo.latitude();
  static double get longitude => _faker.geo.longitude();
}
