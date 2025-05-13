class USDTModel {
  final String symbol;
  final String name;
  final int cmcRank;
  final double? circulatingSupply;
  final double? totalSupply;
  final double price;
  final double volume24h;
  final double volumeChange24h;
  final double percentChange1h;
  final double percentChange24h;
  final double percentChange7d;
  final double percentChange30d;
  final double percentChange60d;
  final double percentChange90d;
  final double marketCap;
  final double marketCapDominance;
  final double fullyDilutedMarketCap;
  final DateTime lastUpdated;

  USDTModel({
    required this.symbol,
    required this.name,
    required this.cmcRank,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.price,
    required this.volume24h,
    required this.volumeChange24h,
    required this.percentChange1h,
    required this.percentChange24h,
    required this.percentChange7d,
    required this.percentChange30d,
    required this.percentChange60d,
    required this.percentChange90d,
    required this.marketCap,
    required this.marketCapDominance,
    required this.fullyDilutedMarketCap,
    required this.lastUpdated,
  });

  factory USDTModel.fromJson(Map<String, dynamic> json) {
    final quoteUSD = json['quote']['USD'];
    return USDTModel(
      symbol: json['symbol'],
      name: json['name'],
      cmcRank: json['cmc_rank'],
      circulatingSupply: (json['circulating_supply'] as num?)?.toDouble(),
      totalSupply: (json['total_supply'] as num?)?.toDouble(),
      price: quoteUSD['price'],
      volume24h: quoteUSD['volume_24h'],
      volumeChange24h: quoteUSD['volume_change_24h'],
      percentChange1h: quoteUSD['percent_change_1h'],
      percentChange24h: quoteUSD['percent_change_24h'],
      percentChange7d: quoteUSD['percent_change_7d'],
      percentChange30d: quoteUSD['percent_change_30d'],
      percentChange60d: quoteUSD['percent_change_60d'],
      percentChange90d: quoteUSD['percent_change_90d'],
      marketCap: quoteUSD['market_cap'],
      marketCapDominance: quoteUSD['market_cap_dominance'],
      fullyDilutedMarketCap: quoteUSD['fully_diluted_market_cap'],
      lastUpdated: DateTime.parse(quoteUSD['last_updated']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'symbol': symbol,
      'name': name,
      'cmc_rank': cmcRank,
      'circulating_supply': circulatingSupply,
      'total_supply': totalSupply,
      'price': price,
      'volume_24h': volume24h,
      'volume_change_24h': volumeChange24h,
      'percent_change_1h': percentChange1h,
      'percent_change_24h': percentChange24h,
      'percent_change_7d': percentChange7d,
      'percent_change_30d': percentChange30d,
      'percent_change_60d': percentChange60d,
      'percent_change_90d': percentChange90d,
      'market_cap': marketCap,
      'market_cap_dominance': marketCapDominance,
      'fully_diluted_market_cap': fullyDilutedMarketCap,
      'last_updated': lastUpdated.toIso8601String(),
    };
  }
}
