import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:piaoxingqiu/models/show.dart';

class ShowCardWidget extends StatelessWidget {
  ShowCardWidget({super.key, required this.showData});

  final ShowData showData;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Poster(posterUrl: showData.posterUrl),
            ),
            SizedBox(
              width: 800,
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ShowTitle(showData: showData),
                    Price(showData: showData)
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

class Poster extends StatelessWidget {
  const Poster({
    super.key,
    required this.posterUrl,
  });

  final String posterUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: CachedNetworkImage(
          imageUrl: posterUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) => ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image(
                  image: ResizeImage(
                    imageProvider,
                    height: 200,
                  ),
                ),
              )),
    );
  }
}

class ShowTitle extends StatelessWidget {
  const ShowTitle({
    super.key,
    required this.showData,
  });

  final ShowData showData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          showData.showName,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              showData.showDate,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${showData.cityName}|${showData.venueName}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class Price extends StatelessWidget {
  const Price({
    super.key,
    required this.showData,
  });

  String _price(showData) {
    final priceInfo = showData.minOriginalPriceInfo;
    return '${priceInfo.prefix}${priceInfo.yuanNum}';
  }

  final ShowData showData;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _price(showData),
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
          Text(
            '起',
            style: TextStyle(fontSize: 12),
          )
        ]);
  }
}
