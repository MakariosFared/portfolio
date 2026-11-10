class ProjectItem {
  final String title;
  final String description;
  final String category;
  final List<String> tags;
  final String image;
  final String? githubUrl;
  final String? liveUrl;
  final String? demoUrl;

  const ProjectItem({
    required this.title,
    required this.description,
    required this.category,
    required this.tags,
    required this.image,
    this.githubUrl,
    this.liveUrl,
    this.demoUrl,
  });
}

const List<String> projectCategories = [
  'All',
  'Ride-Hailing & Realtime',
  'Offline-First & LMS',
  'E-Commerce',
  'Clean Architecture',
];

final List<ProjectItem> otherProjectsList = [
  const ProjectItem(
    title: 'Mini Offline LMS – Educational Platform',
    category: 'Offline-First & LMS',
    description:
        'A production-minded offline Learning Management System engineered with Clean Architecture & Cubit. Features local JSON curriculum parsing, sequential lesson unlocking (90% video completion threshold), background-resuming video playback controls, Hive local persistence, full Arabic RTL layout, and comprehensive unit tests for core domain rules.',
    image: 'assets/images/thaheen_lms.jpg',
    tags: [
      'Flutter SDK',
      'Clean Architecture',
      'Cubit / BLoC',
      'Hive (Local-First)',
      'video_player',
      'Unit Testing',
      'Arabic RTL',
    ],
    githubUrl: 'https://github.com/MakariosFared/Thaheen-lms',
    liveUrl:
        'https://drive.google.com/file/d/17twhMcbKQgraERMW404tjhtY7gd05f_w/view?usp=drive_link',
    demoUrl: 'demos/thaheen_lms/',
  ),
  const ProjectItem(
    title: 'Dikkan – Multi-Vendor Retail Platform',
    category: 'E-Commerce',
    description:
        'A comprehensive multi-vendor mobile marketplace connecting customers with nearby merchants. Engineered with Clean Architecture & Cubit, featuring offline cart caching via Hive, phone OTP authentication, real-time order status tracking, and RESTful API integration.',
    image: 'assets/images/dikkan_app.jpg',
    tags: [
      'Flutter SDK',
      'Clean Architecture',
      'Cubit',
      'Hive (Offline-First)',
      'REST APIs',
      'Google Maps',
    ],
    githubUrl: 'https://github.com/MakariosFared/new_dikkan',
    liveUrl: null,
    demoUrl: 'demos/dikkan/',
  ),
  const ProjectItem(
    title: 'Bookly – Catalog & Reader Client',
    category: 'Clean Architecture',
    description:
        'A clean reference implementation of Feature-First Clean Architecture utilizing the Google Books REST API. Emphasizes clean repository patterns, robust error/loading UI states, and custom widget composition with zero third-party UI framework dependencies.',
    image: 'assets/images/bookly_app.jpg',
    tags: [
      'Flutter SDK',
      'Google Books REST API',
      'Clean Architecture',
      'Cubit',
      'MVVM Pattern',
    ],
    githubUrl: 'https://github.com/MakariosFared/bookly_app',
    liveUrl: null,
    demoUrl: 'demos/bookly/',
  ),
];
