import 'package:flutter/material.dart';

class ArchitecturePipelineStep {
  final int stepNumber;
  final String title;
  final String description;
  final IconData icon;
  final String? badge;

  const ArchitecturePipelineStep({
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.icon,
    this.badge,
  });
}

class ArchitectureChallenge {
  final String title;
  final String challenge;
  final String solution;
  final IconData icon;

  const ArchitectureChallenge({
    required this.title,
    required this.challenge,
    required this.solution,
    required this.icon,
  });
}

class ProjectArchitecture {
  final String id;
  final String title;
  final String subtitle;
  final String pattern;
  final String overview;
  final List<ArchitecturePipelineStep> pipeline;
  final List<ArchitectureChallenge> challenges;
  final List<String> techStack;

  const ProjectArchitecture({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.pattern,
    required this.overview,
    required this.pipeline,
    required this.challenges,
    required this.techStack,
  });
}

final Map<String, ProjectArchitecture> projectArchitectures = {
  // 🚕 1. FeGo Ride-Hailing Platform
  'fego': const ProjectArchitecture(
    id: 'fego',
    title: 'FeGo Ride-Hailing Platform',
    subtitle: 'Passenger & Driver Two-Sided Platform with Real-Time WebSockets',
    pattern: 'Clean Architecture (Feature-First) + BLoC Deterministic State Machines',
    overview:
        'Engineered from scratch to support high-concurrency ride negotiations, continuous GPS vehicle telemetry, and zero-latency state synchronization across independent Passenger and Driver client applications.',
    pipeline: [
      ArchitecturePipelineStep(
        stepNumber: 1,
        title: 'Ride Request & Spatial Matching',
        description:
            'Passenger specifies pickup/drop-off. Request payload is sent via REST to the dispatch engine, which spatial-queries active drivers within radius.',
        icon: Icons.location_on_rounded,
        badge: 'REST + Spatial Index',
      ),
      ArchitecturePipelineStep(
        stepNumber: 2,
        title: 'Full-Duplex WebSocket Dispatch',
        description:
            'Server dispatches ride offer over a duplex WebSocket pipeline. Driver app displays incoming ride with custom countdown sound & reactive accept/reject timer.',
        icon: Icons.sync_alt_rounded,
        badge: '< 50ms Latency',
      ),
      ArchitecturePipelineStep(
        stepNumber: 3,
        title: 'Spherical Lerp 60fps Vehicle Tracking',
        description:
            'Driver emits coordinates every 1-2s. Passenger client interpolates lat/lng using spherical linear interpolation (lerp) + bearing calculation for silky smooth 60fps vehicle animation without map jerking.',
        icon: Icons.navigation_rounded,
        badge: '60fps lerp',
      ),
      ArchitecturePipelineStep(
        stepNumber: 4,
        title: 'Deterministic Lifecycle Transitions',
        description:
            'BLoC state machine guarantees unidirectional data flow through strict states: (Requested → Accepted → Arrived → Trip Started → Completed → Fare Settlement).',
        icon: Icons.account_tree_rounded,
        badge: 'Strict State Machine',
      ),
    ],
    challenges: [
      ArchitectureChallenge(
        title: 'Map Re-render Lag & Vehicle Stuttering',
        challenge:
            'Standard Google Maps marker updates on incoming GPS points cause visual marker teleportation and 20fps frame drops.',
        solution:
            'Implemented a custom AnimationController with spherical spherical-interpolation (lerp) math that continuously glides the marker between coordinate pairs while rotating smoothly toward the target bearing.',
        icon: Icons.speed_rounded,
      ),
      ArchitectureChallenge(
        title: 'Unstable Network & WebSocket Disconnects',
        challenge:
            'Drivers frequently drive through tunnels or areas with spotty 3G/4G coverage, risking desynchronized trip statuses.',
        solution:
            'Designed an automated reconnection engine with exponential backoff, persistent local trip state cache in Hive, and FCM high-priority data messages as an instant fallback.',
        icon: Icons.wifi_off_rounded,
      ),
      ArchitectureChallenge(
        title: 'Background Ride Notifications & Wake Lock',
        challenge:
            'Driver apps need to receive instant offers even when phone is locked or app is in the background without getting killed by Android battery optimization.',
        solution:
            'Configured Firebase Cloud Messaging (FCM) high-priority foreground service channels with custom wake-locks and interactive notifications allowing instant one-tap acceptance.',
        icon: Icons.notifications_active_rounded,
      ),
    ],
    techStack: [
      'Flutter SDK',
      'BLoC / Cubit',
      'WebSockets (STOMP)',
      'Google Maps API',
      'Spherical Math',
      'Clean Architecture',
      'Dio Interceptors',
      'FCM High Priority',
      'Hive Cache',
    ],
  ),

  // 🤖 2. Autonomous Medical Robot
  'medical_robot': const ProjectArchitecture(
    id: 'medical_robot',
    title: 'Autonomous Medical Robot & IoT Controller',
    subtitle: 'Hardware Abstraction Layer (HAL) + Low-Latency RFCOMM Serial',
    pattern: 'Layered Hardware Abstraction Architecture (HAL) + Local-First SQLite',
    overview:
        'Engineered for critical healthcare environments to remotely pilot a medicine-dispensing robot, stream live first-person video, and manage automated prescription deliveries with fail-safe hardware watchdogs.',
    pipeline: [
      ArchitecturePipelineStep(
        stepNumber: 1,
        title: 'Bluetooth RFCOMM Serial Handshake',
        description:
            'Flutter client scans, pairs, and establishes a raw RFCOMM serial stream with the onboard microcontroller (ESP32 / Arduino) over SPP (Serial Port Profile).',
        icon: Icons.bluetooth_connected_rounded,
        badge: 'Raw RFCOMM Stream',
      ),
      ArchitecturePipelineStep(
        stepNumber: 2,
        title: '10Hz Telemetry & Virtual Joystick Vector',
        description:
            'User manipulates the virtual on-screen joystick. Motion vectors (angle, magnitude, throttle) are serialized into binary control frames and throttled at 100ms intervals.',
        icon: Icons.sports_esports_rounded,
        badge: '100ms Binary Frames',
      ),
      ArchitecturePipelineStep(
        stepNumber: 3,
        title: 'Low-Latency MJPEG Live FPV Video Feed',
        description:
            'Onboard ESP32-CAM streams MJPEG frames over local HTTP socket. App decodes and renders continuous multipart chunks directly onto a custom canvas.',
        icon: Icons.videocam_rounded,
        badge: 'Local Socket Stream',
      ),
      ArchitecturePipelineStep(
        stepNumber: 4,
        title: 'Automated Dispensing & SQLite Audit Log',
        description:
            'Prescription schedules trigger medication compartment servo motors. All dispensing events, dosages, and timestamps are audited locally in SQLite with background alarm triggers.',
        icon: Icons.medication_liquid_rounded,
        badge: 'Offline SQLite & Alarms',
      ),
    ],
    challenges: [
      ArchitectureChallenge(
        title: 'Safety Fail-Safe: Signal Drop Runaway Prevention',
        challenge:
            'If Bluetooth connection drops while robot is moving forward, hardware could keep motors spinning and collide with hospital equipment.',
        solution:
            'Architected a bi-directional 200ms heartbeat watchdog. If the microcontroller misses 3 consecutive heartbeats (600ms), it initiates an immediate emergency motor kill switch and mechanical brake.',
        icon: Icons.health_and_safety_rounded,
      ),
      ArchitectureChallenge(
        title: 'Memory Leaks in Continuous MJPEG Video Streaming',
        challenge:
            'Decoding raw multipart JPEG frames at 25fps quickly choked the Flutter image cache, causing garbage collection spikes and UI stutters.',
        solution:
            'Built a dedicated stream chunk consumer that directly decodes byte arrays into an in-memory Image Provider while proactively disposing preceding frames before memory allocation.',
        icon: Icons.memory_rounded,
      ),
      ArchitectureChallenge(
        title: 'Offline Mission Critical Timers',
        challenge:
            'Hospital wards frequently lack reliable Wi-Fi, but medication dosages cannot be delayed or missed.',
        solution:
            'Implemented an offline-first architecture with SQLite persistent schedules and exact Android alarm manager triggers that fire independently of internet availability.',
        icon: Icons.alarm_on_rounded,
      ),
    ],
    techStack: [
      'Flutter SDK',
      'Bluetooth Serial (RFCOMM)',
      'MJPEG Stream Decoder',
      'SQLite Local-First',
      'Heartbeat Watchdog',
      'ESP32 / Microcontroller',
      'Local Notifications',
      'Custom Painter Joystick',
    ],
  ),

  // ⚡ 3. Prolio SaaS Builder
  'prolio': const ProjectArchitecture(
    id: 'prolio',
    title: 'Prolio – AI-Powered Portfolio & Resume SaaS Builder',
    subtitle: 'Serverless Full-Stack Next.js 16 + Multi-LLM Orchestration',
    pattern: 'Next.js App Router Server Actions + Supabase PostgreSQL RLS',
    overview:
        'Architected to ingest developer resumes (PDF/DOCX), parse unstructured text via zero-dependency serverless extractors, and dynamically enrich content with Gemini & Groq AI models.',
    pipeline: [
      ArchitecturePipelineStep(
        stepNumber: 1,
        title: 'Zero-Worker Document Parsing',
        description:
            'User drops PDF or Word resume. Server Action streams file bytes through unpdf & mammoth without needing heavy external Python extractors.',
        icon: Icons.upload_file_rounded,
        badge: 'unpdf & mammoth',
      ),
      ArchitecturePipelineStep(
        stepNumber: 2,
        title: 'Dual-LLM AI Structuring & Copilot',
        description:
            'Extracted raw text is passed to Gemini 1.5 Flash for JSON schema extraction, while Groq (Llama-3) provides sub-second bio and project description enhancements.',
        icon: Icons.auto_awesome_rounded,
        badge: 'Gemini + Groq Orchestration',
      ),
      ArchitecturePipelineStep(
        stepNumber: 3,
        title: 'Multi-Tenant Database & Strict RLS',
        description:
            'Portfolio models are stored in Supabase PostgreSQL protected by Row Level Security (RLS) policies guaranteeing strict multi-tenant isolation.',
        icon: Icons.security_rounded,
        badge: 'Supabase RLS Isolation',
      ),
      ArchitecturePipelineStep(
        stepNumber: 4,
        title: 'Dynamic SSR Public Profiles & OG Generation',
        description:
            'Public URLs render via Next.js ISR/SSR with dynamic OpenGraph social cards generated on the fly via @vercel/og for rich previews on LinkedIn & Twitter.',
        icon: Icons.share_rounded,
        badge: 'Next.js ISR + Dynamic OG',
      ),
    ],
    challenges: [
      ArchitectureChallenge(
        title: 'Unstructured CV Formats & Schema Hallucinations',
        challenge:
            'Developer resumes come in hundreds of unpredictable two-column formats, tables, and unconventional fonts.',
        solution:
            'Engineered strict Zod runtime schemas paired with constrained JSON mode prompting. Any validation failure triggers an automatic corrective repair loop before database commit.',
        icon: Icons.rule_folder_rounded,
      ),
      ArchitectureChallenge(
        title: 'Latency in AI Content Generation',
        challenge:
            'Waiting 6-10 seconds for LLMs to generate project summaries causes user drop-off during onboarding.',
        solution:
            'Integrated Groq ultra-fast LPU inference (500+ tokens/sec) for real-time interactive typing, paired with optimistic UI updates in React 19.',
        icon: Icons.bolt_rounded,
      ),
      ArchitectureChallenge(
        title: 'Multi-Tenant Security for Public Portfolios',
        challenge:
            'Users need editable private dashboards, but their portfolio data must be publicly readable under customized slugs.',
        solution:
            'Designed dual-policy RLS: write operations require authenticated JWT user_id match, while select queries are open on published slugs with sensitive user fields filtered.',
        icon: Icons.admin_panel_settings_rounded,
      ),
    ],
    techStack: [
      'Next.js 16 (App Router)',
      'React 19 & TypeScript',
      'Supabase PostgreSQL & RLS',
      'Gemini 1.5 & Groq Llama-3',
      'Zod Schema Validation',
      'Tailwind CSS v4',
      'Dynamic OG Image Gen',
    ],
  ),

  // 📚 4. Mini Offline LMS
  'thaheen_lms': const ProjectArchitecture(
    id: 'thaheen_lms',
    title: 'Mini Offline LMS – Educational Platform',
    subtitle: 'Local-First Offline Curriculum & Domain-Driven Rules',
    pattern: 'Domain-Driven Clean Architecture + Hive Key-Value Storage',
    overview:
        'Engineered for students with restricted or intermittent internet access. Guarantees complete offline study flow with sequential lesson progression and persistent video watch positions.',
    pipeline: [
      ArchitecturePipelineStep(
        stepNumber: 1,
        title: 'Local Curriculum Parsing & Domain Validation',
        description:
            'Course structure parsed from local asset models into strongly typed domain entities with immutable validation rules.',
        icon: Icons.menu_book_rounded,
        badge: 'Domain Entities',
      ),
      ArchitecturePipelineStep(
        stepNumber: 2,
        title: 'Sequential Unlocking Engine',
        description:
            'Strict business logic enforces that Lesson (N+1) remains locked until Lesson (N) achieves >= 90% video playback completion.',
        icon: Icons.lock_open_rounded,
        badge: '90% Rule Check',
      ),
      ArchitecturePipelineStep(
        stepNumber: 3,
        title: 'Hive Persistence for Playback Resume',
        description:
            'Every playback tick records elapsed timestamps into lightweight Hive boxes. Resuming a course immediately seeks to the saved offset.',
        icon: Icons.play_lesson_rounded,
        badge: 'Hive Key-Value Box',
      ),
    ],
    challenges: [
      ArchitectureChallenge(
        title: 'Progress Cheating Prevention in Offline Mode',
        challenge:
            'Users scrubbing the video progress bar to the end could cheat the lesson completion trigger.',
        solution:
            'Developed an internal watch accumulator in Cubit that monitors actual wall-clock playback duration, rejecting scrub leaps to mark lessons completed.',
        icon: Icons.verified_user_rounded,
      ),
      ArchitectureChallenge(
        title: 'Arabic RTL Typography & Smooth Navigation',
        challenge:
            'Complex nested lesson lists with RTL mirroring often cause layout overflow bugs and jerky page transitions.',
        solution:
            'Adopted pure Flex layouts with Directionality-aware widgets and localized typography constants, ensuring zero horizontal overflow on all screen sizes.',
        icon: Icons.format_textdirection_r_to_l_rounded,
      ),
    ],
    techStack: [
      'Flutter SDK',
      'Clean Architecture',
      'Cubit / BLoC',
      'Hive (Local-First)',
      'video_player',
      'Unit Tests (Mocktail)',
      'Arabic RTL Layout',
    ],
  ),
};
