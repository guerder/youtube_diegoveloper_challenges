import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

import 'travel_photo.dart';

class TravelPhotosPage extends StatefulWidget {
  const TravelPhotosPage({super.key});

  @override
  State<TravelPhotosPage> createState() => _TravelPhotosPageState();
}

class _TravelPhotosPageState extends State<TravelPhotosPage> {
  TravelPhoto _selected = travelPhotos.last;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final topCardHeight = size.height / 2;
    const horizontalListHeight = 160.0;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: topCardHeight,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 700),
              child: TravelPhotoDetails(
                key: Key(_selected.name),
                travelPhoto: _selected,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: topCardHeight - horizontalListHeight / 3,
            height: horizontalListHeight,
            child: TravelPhotosList(
              onPhotoChanged: (item) {
                setState(() {
                  _selected = item;
                });
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top:
                topCardHeight - horizontalListHeight / 3 + horizontalListHeight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recomendation',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    FakeReview(),
                    FakeReview(),
                    FakeReview(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TravelPhotoDetails extends StatefulWidget {
  const TravelPhotoDetails({
    super.key,
    required this.travelPhoto,
  });

  final TravelPhoto travelPhoto;

  @override
  State<TravelPhotoDetails> createState() => _TravelPhotoDetailsState();
}

class _TravelPhotoDetailsState extends State<TravelPhotoDetails>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final _movement = -100.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              left: _movement * _controller.value,
              right: _movement * (1 - _controller.value),
              child: Image.asset(
                widget.travelPhoto.backImage,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 40,
              left: 10,
              right: 10,
              height: 100,
              child: FittedBox(
                child: Text(
                  widget.travelPhoto.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              left: _movement * _controller.value,
              right: _movement * (1 - _controller.value),
              child: Image.asset(
                widget.travelPhoto.frontImage,
                fit: BoxFit.cover,
              ),
            ),
          ],
        );
      },
    );
  }
}

class TravelPhotosList extends StatefulWidget {
  final ValueChanged<TravelPhoto> onPhotoChanged;

  const TravelPhotosList({
    Key? key,
    required this.onPhotoChanged,
  }) : super(key: key);

  @override
  State<TravelPhotosList> createState() => _TravelPhotosListState();
}

class _TravelPhotosListState extends State<TravelPhotosList> {
  final _animatedListKey = GlobalKey<AnimatedListState>();
  final _pageController = PageController();

  double page = 0;

  void _listenScroll() {
    setState(() {
      page = _pageController.page ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_listenScroll);
  }

  @override
  void dispose() {
    _pageController.removeListener(_listenScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _animatedListKey,
      physics: const PageScrollPhysics(),
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      initialItemCount: travelPhotos.length,
      itemBuilder: (context, index, animation) {
        final travelPhoto = travelPhotos[index];
        final percent = page - page.floor();
        final factor = percent > .5 ? (1 - percent) : percent;

        return InkWell(
          onTap: () {
            travelPhotos.insert(travelPhotos.length, travelPhoto);
            _animatedListKey.currentState!.insertItem(travelPhotos.length - 1);
            final itemDelete = travelPhoto;
            widget.onPhotoChanged(travelPhoto);
            travelPhotos.removeAt(index);
            _animatedListKey.currentState!.removeItem(
              index,
              (context, animation) => FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: animation,
                  axis: Axis.horizontal,
                  child: TravelPhotoListItem(travelPhoto: itemDelete),
                ),
              ),
            );
          },
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(vector.radians(90 * factor)),
            child: TravelPhotoListItem(travelPhoto: travelPhoto),
          ),
        );
      },
    );
  }
}

class TravelPhotoListItem extends StatelessWidget {
  const TravelPhotoListItem({
    super.key,
    required this.travelPhoto,
  });

  final TravelPhoto travelPhoto;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(4),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              travelPhoto.backImage,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 8,
            bottom: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  travelPhoto.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${travelPhoto.photos} photos',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FakeReview extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  FakeReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 90,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                travelPhotos.first.backImage,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Expanded(
                    child: Text(
                      'MON 11 DIC 13 20',
                      style: TextStyle(color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      'Nice days in a good place',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      'Fly ticket',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
