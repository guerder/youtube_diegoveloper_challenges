import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import 'album.dart';

const _colorHeader = Color(0xFFECECEA);

class VinylDiscPage extends StatelessWidget {
  const VinylDiscPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _MyVinylDiscHeader(),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Text(currentAlbum.description),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _maxHeaderExtent = 350.0;
const _minHeaderExtent = 100.0;

const _maxImageSize = 160.0;
const _minImageSize = 60.0;

const _leftMarginDisc = 160.0;

const _maxTitleSize = 25.0;
const _minTitleSize = 18.0;

const _maxSubTitleSize = 16.0;
const _minSubTitleSize = 12.0;

class _MyVinylDiscHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final percent = shrinkOffset / _maxHeaderExtent;
    final size = MediaQuery.sizeOf(context);
    final currentImageSize = (_maxImageSize * (1 - percent)).clamp(
      _minImageSize,
      _maxImageSize,
    );
    final titleSize = (_maxTitleSize * (1 - percent)).clamp(
      _minTitleSize,
      _maxTitleSize,
    );
    final subTitleSize = (_maxSubTitleSize * (1 - percent)).clamp(
      _minSubTitleSize,
      _maxSubTitleSize,
    );

    final minMargin = size.width / 4;
    const textMovement = 50.0;
    final leftTextMargin = minMargin + (textMovement * percent);

    return Container(
      color: _colorHeader,
      child: Stack(
        children: [
          Positioned(
            top: 50.0,
            // left: (size.width / 4) + (50 * percent),
            left: leftTextMargin,
            height: _maxImageSize,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentAlbum.artist,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: titleSize,
                    letterSpacing: -.5,
                  ),
                ),
                Text(
                  currentAlbum.album,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: subTitleSize,
                    letterSpacing: -.5,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: (_leftMarginDisc * (1 - percent)).clamp(35, _leftMarginDisc),
            height: currentImageSize,
            child: Transform.rotate(
              angle: vector.radians(360 * (1 - percent)),
              child: Image.asset(currentAlbum.imagemDisc),
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 35.0,
            height: currentImageSize,
            child: Image.asset(currentAlbum.imageAlgum),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => _maxHeaderExtent;

  @override
  double get minExtent => _minHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
