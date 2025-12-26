import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptox_app/features/crypto/providers/crypto_provider.dart';
import 'package:cryptox_app/features/crypto/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cryptos = ref.watch(cryptoProvider);

    return Scaffold(
      backgroundColor: Color(0xff0B0B11),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(),
            cryptos.when(
              data: (cryptos) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: RefreshIndicator(
                    color: Colors.black,
                    onRefresh: () async {
                      ref.refresh(cryptoProvider);
                      await ref.read(cryptoProvider.future);
                    },
                    child: ListView.builder(
                      itemCount: cryptos.length,
                      itemBuilder: (context, index) {
                        final crypto = cryptos[index];
                        final change = crypto.priceChangePercentage24h;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: crypto.imageUrl,
                                      width: 45,
                                      height: 45,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>Container(
                                        width: 45,
                                        height: 45,
                                        color: Colors.grey[800],
                                        child: Center(child: CircularProgressIndicator(strokeWidth: 2,),)
                                      ),
                                          
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),

                                  SizedBox(width: 12),

                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: .spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: .start,
                                          children: [
                                            Text(
                                              crypto.name,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),

                                            Text(
                                              crypto.symbol.toUpperCase(),
                                              style: TextStyle(
                                                color: Color(0xff808999),
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),

                                        Column(
                                          crossAxisAlignment: .end,
                                          children: [
                                            Text(
                                              crypto.price.toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),

                                            Text(
                                              ((change < 0)
                                                  ? "${change.toStringAsFixed(2)}%"
                                                  : "+${change.toStringAsFixed(2)}%"),
                                              style: TextStyle(
                                                color: (change < 0)
                                                    ? Color(0xffD42727)
                                                    : Color(0xff24C25F),
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),

                              Container(color: Color(0xff313540), height: 1),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              error: (e, _) => Expanded(
                child: Center(
                  child: SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        ref.refresh(cryptoProvider);
                      },
                      child: Row(
                        mainAxisAlignment: .center,
                        children: [
                          Icon(Icons.refresh, color: Colors.black),
                          Text("Retry", style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              loading: () => Expanded(
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
