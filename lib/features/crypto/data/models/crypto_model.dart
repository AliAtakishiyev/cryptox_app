class CryptoModel {
  final String name;
  final String symbol;
  final String imageUrl;
  final double price;
  final double priceChangePercentage24h;

  CryptoModel({
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.priceChangePercentage24h,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      imageUrl: json['image'] as String,
      price: (json['current_price'] as num).toDouble(),
      priceChangePercentage24h: (json['price_change_percentage_24h_in_currency'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
