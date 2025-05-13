import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:ui';

void main() {
  runApp(const SubjectClassesPage());
}

class SubjectClassesPage extends StatelessWidget {
  const SubjectClassesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CourseListPage(subject: '', subjectImage: ''),
    );
  }
}

class CourseListPage extends StatefulWidget {
  final String subject;
  final String subjectImage;

  const CourseListPage({
    Key? key,
    required this.subject,
    required this.subjectImage,
  }) : super(key: key);

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  final ScrollController _scrollController = ScrollController();
  String? selectedTopicTitle;
  YoutubePlayerController? _controller;
  VideoPlayerController? _assetVideoController;
  ChewieController? _chewieController;
  bool isPlaying = false;
  bool isFullScreen = false;
  bool isLoading = false;
  String? errorMessage;

  List<Map<String, dynamic>> getTopics() {
    final List<Map<String, dynamic>> topics = [];
    
    // Basic Programming Concepts (Days 1-20)
    final basicTopics = [
      'Introduction to Programming',
      'Variables and Data Types',
      'Control Structures',
      'Functions and Methods',
      'Arrays and Lists',
      'Object-Oriented Programming Basics',
      'Classes and Objects',
      'Inheritance and Polymorphism',
      'Exception Handling',
      'File I/O Operations',
      'Basic Algorithms',
      'Searching and Sorting',
      'Data Structures Basics',
      'Linked Lists',
      'Stacks and Queues',
      'Trees and Graphs',
      'Recursion',
      'Memory Management',
      'Debugging Techniques',
      'Code Documentation'
    ];

    // Intermediate Topics (Days 21-40)
    final intermediateTopics = [
      'Design Patterns',
      'SOLID Principles',
      'Clean Code Practices',
      'Unit Testing',
      'Integration Testing',
      'API Development',
      'RESTful Services',
      'Database Design',
      'SQL and NoSQL',
      'Authentication & Authorization',
      'Security Best Practices',
      'Performance Optimization',
      'Concurrency',
      'Multithreading',
      'Asynchronous Programming',
      'Web Development Basics',
      'Frontend Frameworks',
      'Backend Development',
      'DevOps Introduction',
      'Version Control Systems'
    ];

    // Advanced Topics (Days 41-60)
    final advancedTopics = [
      'Microservices Architecture',
      'Cloud Computing',
      'Containerization',
      'Kubernetes',
      'CI/CD Pipelines',
      'System Design',
      'Scalability Patterns',
      'High Availability',
      'Load Balancing',
      'Caching Strategies',
      'Message Queues',
      'Event-Driven Architecture',
      'Big Data Processing',
      'Machine Learning Basics',
      'AI Integration',
      'Blockchain Technology',
      'IoT Development',
      'Mobile App Development',
      'Progressive Web Apps',
      'Advanced Security'
    ];

    // Combine all topics
    for (int i = 0; i < 60; i++) {
      String title;
      if (i < 20) {
        title = 'Day ${i + 1} - ${basicTopics[i]}';
      } else if (i < 40) {
        title = 'Day ${i + 1} - ${intermediateTopics[i - 20]}';
      } else {
        title = 'Day ${i + 1} - ${advancedTopics[i - 40]}';
      }

      topics.add({
        'title': title,
        'image': widget.subjectImage,
        'youtubeId': '5Q0FlxcEEIw',
        'assetVideo': 'assets/videos/bagheera.mp4',
      });
    }
    return topics;
  }

  @override
  void dispose() {
    _controller?.dispose();
    _assetVideoController?.dispose();
    _chewieController?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _playYoutubeVideo(String videoId) {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      if (_controller != null) {
        _controller!.load(videoId);
      } else {
        _controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
          ),
        )..addListener(() {
            if (_controller?.value.hasError ?? false) {
              setState(() {
                isLoading = false;
                errorMessage = 'Error loading YouTube video';
              });
            }
          });
      }
      setState(() {
        isPlaying = true;
        selectedTopicTitle = getTopics().firstWhere(
          (topic) => topic['youtubeId'] == videoId,
          orElse: () => {'title': ''},
        )['title'];
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error loading YouTube video: $error';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _playAssetVideo(String assetPath) {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      _assetVideoController?.dispose();
      _assetVideoController = VideoPlayerController.asset(assetPath);
      _assetVideoController!.initialize().then((_) {
        _chewieController = ChewieController(
          videoPlayerController: _assetVideoController!,
          autoPlay: true,
          looping: false,
          aspectRatio: _assetVideoController!.value.aspectRatio,
          materialProgressColors: ChewieProgressColors(
            playedColor: const Color.fromARGB(255, 54, 231, 244),
            handleColor: const Color.fromARGB(255, 237, 44, 44),
            backgroundColor: const Color.fromARGB(255, 15, 10, 10),
            bufferedColor: Colors.white,
          ),
          placeholder: Container(
            color: const Color.fromARGB(255, 8, 5, 5),
          ),
          autoInitialize: true,
        )..addListener(() {
            if (_chewieController?.videoPlayerController.value.hasError ?? false) {
              setState(() {
                isLoading = false;
                errorMessage = 'Error loading asset video';
              });
            }
          });
        setState(() {
          isPlaying = true;
          selectedTopicTitle = getTopics().firstWhere(
            (topic) => topic['assetVideo'] == assetPath,
            orElse: () => {'title': ''},
          )['title'];
        });
      }).catchError((error) {
        setState(() {
          isLoading = false;
          errorMessage = 'Error initializing video player: $error';
        });
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error playing asset video: $error';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _stopCurrentVideo() {
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    _assetVideoController?.pause();
    _chewieController?.dispose();
    _chewieController = null;
    setState(() {
      isPlaying = false;
      selectedTopicTitle = null;
      isLoading = false;
      errorMessage = null;
    });
  }

  void _toggleFullScreen() {
    setState(() {
      isFullScreen = !isFullScreen;
      if (isFullScreen) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isFullScreen
          ? null
          : AppBar(
              title: Text(widget.subject),
              backgroundColor: const Color.fromARGB(255, 51, 171, 171).withOpacity(0.5),
              actions: [
                if (isPlaying)
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      _stopCurrentVideo();
                    },
                  ),
              ],
            ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.withOpacity(0.3),
              Colors.purple.withOpacity(0.3),
            ],
          ),
        ),
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return selectedTopicTitle == null
                    ? SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Image.asset(widget.subjectImage, fit: BoxFit.cover),
                      )
                    : AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: double.infinity,
                        height: isFullScreen ? constraints.maxHeight : 220,
                        child: isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : errorMessage != null
                                ? Center(child: Text(errorMessage!))
                                : _controller != null
                                    ? YoutubePlayer(
                                        controller: _controller!,
                                        showVideoProgressIndicator: true,
                                        progressIndicatorColor: Colors.amber,
                                        progressColors: const ProgressBarColors(
                                          playedColor: Colors.amber,
                                          handleColor: Colors.amberAccent,
                                        ),
                                      )
                                    : _chewieController != null
                                        ? Chewie(controller: _chewieController!)
                                        : const Center(child: CircularProgressIndicator()),
                      );
              },
            ),
            if (!isFullScreen)
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: getTopics().length,
                  itemBuilder: (context, index) {
                    final topic = getTopics()[index];
                    return _buildTopicCard(
                      topic['title'],
                      topic['image'],
                      topic['youtubeId'],
                      topic['assetVideo'],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicCard(String title, String image, String youtubeId, String? assetVideo) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(image, width: 80, height: 80, fit: BoxFit.cover),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.play_circle_outline, color: Color.fromARGB(255, 249, 58, 20)),
                  onPressed: () {
                    _stopCurrentVideo();
                    _playYoutubeVideo(youtubeId);
                  },
                ),
                if (assetVideo != null)
                  IconButton(
                    icon: const Icon(Icons.save_outlined, color: Color.fromARGB(255, 10, 16, 14)),
                    onPressed: () {
                      _stopCurrentVideo();
                      _playAssetVideo(assetVideo);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}