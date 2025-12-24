import 'dart:ffi';

class CryptoModel {
  final String name;
  final String symbol;
  final String imageUrl;
  final Double price;
  final Double priceChangePercentage24h;

  CryptoModel({
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.priceChangePercentage24h,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      name: json['name'],
      symbol: json['symbol'],
      imageUrl: json['image'],
      price: json['current_price'],
      priceChangePercentage24h: json['price_change_percentage_24h_in_currency'],
    );
  }
}
