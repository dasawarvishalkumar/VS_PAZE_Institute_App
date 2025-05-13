import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../bottomnav_bar/bottomnav_bar_widget.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _currentIndex = 0;
  final List<String> carouselImages = [
    'assets/images/flutter_carousel1.png',
    'assets/images/flutter_carousel2.png',
    'assets/images/flutter_carousel3.png',
    'assets/images/flutter_carousel4.png',
    'assets/images/flutter_carousel5.png',
  ];

  int activeIndex = 0;

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Handle navigation based on index
    switch (index) {
      case 0: // Home
        // Already on home screen
        break;
      case 1: // Books
        // Navigate to books screen
        break;
      case 2: // Profile
        // Navigate to profile screen
        break;
      case 3: // Settings
        // Navigate to settings screen
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final List<Map<String, String>> tileData = [
      {
        "image": "assets/images/flutter.webp",
        "text": "Flutter",
        "subtitle": "Lorem ipsum lorem ipsum lorem ipsum"
      },
      {
        "image": "assets/images/reactjs.png",
        "text": "React-Native",
        "subtitle": "Lorem ipsum lorem ipsum lorem ipsum"
      },
      {
        "image": "assets/images/html.png",
        "text": "HTML",
        "subtitle": "Lorem ipsum lorem ipsum lorem ipsum"
      },
      {
        "image": "assets/images/css.png",
        "text": "CSS",
        "subtitle": "Lorem ipsum lorem ipsum lorem ipsum"
      },
      {
        "image": "assets/images/react-native.png",
        "text": "React-JS",
        "subtitle": "Lorem ipsum lorem ipsum lorem ipsum"
      },
      {
        "image": "assets/images/reactjs.png",
        "text": "React-js",
        "subtitle": "Lorem ipsum lorem ipsum lorem ipsum"
      },
      {
        "image": "assets/images/java.png",
        "text": "Java",
        "subtitle": "Lorem ipsum lorem ipsum lorem ipsum"
      },
      {
        "image": "assets/images/python.png",
        "text": "Python",
        "subtitle": "Lorem ipsum lorem ipsum lorem ipsum"
      },
      {
        "image": "assets/images/mysql.png",
        "text": "MySQL",
        "subtitle": "Lorem ipsum lorem ipsum lorem ipsum"
      },
      {
        "image": "assets/images/java.png",
        "text": "MySQL",
        "subtitle": "Lorem ipsum lorem ipsum lorem ipsum"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.withOpacity(0.2),
                  Colors.purple.withOpacity(0.2),
                ],
              ),
            ),
          ),
          // Frosted glass effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          // Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.08),
                // Carousel Banner
                FlutterCarousel(
                  items: carouselImages.map((image) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 150,
                    viewportFraction: 0.9,
                    showIndicator: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Carousel Indicator
                Center(
                  child: AnimatedSmoothIndicator(
                    activeIndex: activeIndex,
                    count: carouselImages.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: Colors.blue,
                      dotColor: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ),
            
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Library is not a luxury but one of the necessities of life.",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 240, 232, 232).withOpacity(0.8),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 21.0),
                  child: Text(
                    "Ready to Read something Special?",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 20,
                    children: tileData.map((data) {
                      return SizedBox(
                        width: (screenWidth - 40) / 2,
                        child: _buildStudytile(
                          context,
                          data['text']!,
                          data['subtitle']!,
                          data['image']!,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                _buildStudytileLong(
                    "Product",
                    "lorem ispum loren isoum loren ispum",
                    'assets/images/react-native.png'),
                _buildStudytileLong(
                    "Product",
                    "lorem ispum loren isoum loren ispum",
                    'assets/images/react-native.png'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTap,
        notificationCount: 1,
      ),
    );
  }
}

Widget _buildStudytile(BuildContext context, String title, String subtitle, String imageUrl) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamed(
        '/digital-classes',
        arguments: {
          'subject': title,
          'image': imageUrl,
        },
      );
    },
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          height: 90,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageUrl,
                  width: 40,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildStudytileLong(String title, String subtitle, String imageUrl) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          height: 90,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageUrl,
                  width: 40,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
