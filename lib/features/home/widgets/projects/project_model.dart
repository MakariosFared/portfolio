class ProjectItem {
  final String title;
  final String description;
  final String category;
  final String? badge;
  final List<String> tags;
  final String image;
  final String? githubUrl;
  final String? liveUrl;
  final String? demoUrl;
  final String? architectureId;

  const ProjectItem({
    required this.title,
    required this.description,
    required this.category,
    this.badge,
    required this.tags,
    required this.image,
    this.githubUrl,
    this.liveUrl,
    this.demoUrl,
    this.architectureId,
  });
}

const List<String> projectCategories = [
  'All',
  'IoT & Robotics',
  'Full-Stack & AI SaaS',
  'Offline-First & LMS',
  'E-Commerce',
  'Clean Architecture',
];

final List<ProjectItem> otherProjectsList = [
  // 🤖 1. Autonomous Medical Robot & IoT Hardware Controller (Graduation Project)
  const ProjectItem(
    title: 'Autonomous Medical Robot & IoT Hardware Controller',
    badge: 'GRADUATION PROJECT 🎓',
    category: 'IoT & Robotics',
    description:
        'A specialized healthcare robotics & IoT platform engineered as a university graduation project. Establishes low-latency bi-directional Bluetooth Serial communication to physically navigate and control a medical delivery robot with a virtual joystick. Features real-time First-Person-View (FPV) camera video streaming via MJPEG, automated prescription dispensing & dosage scheduling, an offline SQLite database for medical logs, and local background notifications for medication alarms.',
    image: 'assets/images/medical_robot.jpg',
    tags: [
      'Flutter SDK',
      'Bluetooth Serial (RFCOMM)',
      'Live Video Streaming (MJPEG)',
      'Hardware & Robotics IoT',
      'SQLite (Local-First)',
      'Background Notifications',
      'HTTP REST Service',
    ],
    githubUrl: 'https://github.com/MakariosFared',
    liveUrl: null,
    demoUrl: null,
    architectureId: 'medical_robot',
  ),

  // 🚀 2. Prolio – AI-Powered Full-Stack Portfolio & Resume Builder
  const ProjectItem(
    title: 'Prolio – AI-Powered Portfolio & Resume SaaS Builder',
    badge: 'FULL-STACK & AI ⚡',
    category: 'Full-Stack & AI SaaS',
    description:
        'A modern full-stack web application that empowers developers to build, customize, and publish high-converting portfolios. Features automated CV parsing (extracting data from PDF/DOCX via unpdf & mammoth), an AI Copilot powered by Gemini & Groq LLMs for intelligent bio & project suggestions, multiple responsive templates with inline live editing, Supabase PostgreSQL database & Auth with Row Level Security (RLS), and dynamic public sharing with automated OpenGraph image generation.',
    image: 'assets/images/portfolio_builder.jpg',
    tags: [
      'Next.js 16 (App Router)',
      'React 19',
      'TypeScript',
      'Tailwind CSS v4',
      'Supabase & RLS',
      'Gemini & Groq AI',
      'CV Parser (PDF/DOCX)',
      'Zod Validation',
    ],
    githubUrl: 'https://github.com/MakariosFared/portfolio_builder',
    liveUrl: null,
    demoUrl: null,
    architectureId: 'prolio',
  ),

  // 📚 3. Mini Offline LMS – Educational Platform
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
    architectureId: 'thaheen_lms',
  ),

  // 🛍️ 4. Dikkan – Multi-Vendor Retail Platform
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

  // 📖 5. Bookly – Catalog & Reader Client
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
