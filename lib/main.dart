import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'email_service.dart';
import 'dart:js_util';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'dart:html' as html;

// Add this Course class to your existing code
class Course {
  final String imagePath;
  final String heading;
  final String description;

  Course({
    required this.imagePath,
    required this.heading,
    required this.description,
  });
}

class Project {
  final String title;
  final String description;
  final String technologies;
  final String? emoji;
  final String? imagePath;
  final String? demoUrl;
  final String? codeUrl;

  Project({
    required this.title,
    required this.description,
    required this.technologies,
    this.emoji,
    this.imagePath,
    this.demoUrl,
    this.codeUrl,
  });
}


// Add this AnimatedGradientBorder widget to your existing code
class AnimatedGradientBorder extends StatefulWidget {
  final Widget child;
  final double borderWidth;
  final BorderRadius borderRadius;

  const AnimatedGradientBorder({
    Key? key,
    required this.child,
    this.borderWidth = 2.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) : super(key: key);

  @override
  _AnimatedGradientBorderState createState() => _AnimatedGradientBorderState();
}

class _AnimatedGradientBorderState extends State<AnimatedGradientBorder>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: SweepGradient(
              colors: const [
                Color(0xFF000080), // Dark blue
                Color(0xFF0000FF), // Blue
                Color(0xFF008000), // Green
                Color(0xFF006400), // Dark green
                Color(0xFFFF0000), // Red
                Color(0xFF8B0000), // Dark red
                Color(0xFF000080), // Back to dark blue
              ],
              stops: const [0.0, 0.16, 0.33, 0.5, 0.66, 0.83, 1.0],
              transform: GradientRotation(_animation.value * 2 * 3.14159),
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(widget.borderWidth),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                widget.borderRadius.topLeft.x - widget.borderWidth,
              ),
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}

// Add this CourseSection widget to your existing code
class CourseSection extends StatefulWidget {
  @override
  _CourseSectionState createState() => _CourseSectionState();
}

class _CourseSectionState extends State<CourseSection> {
  late PageController _pageController;
  late Timer _autoScrollTimer;
  int _currentPage = 0;

  final List<Course> courses = [
    Course(
    imagePath: 'assets/mayonix_internship.jpg',
  heading: 'Junior Software Engineer Internship',
  description: 'Completed a software development internship at Mayonix Innovations, contributing to the corporate website and CompanyOS by developing features, integrating APIs, enhancing UI, and working with modern full-stack web technologies.',
   ),
    Course(
  imagePath: 'assets/accolade_internship.jpg',
  heading: 'Full Stack Web Development Internship',
  description: 'Completed a Full Stack Web Development internship, gaining hands-on experience in frontend, backend, databases, and real-world software development.',
    ),
    Course(
      imagePath: 'assets/asyncjavascript.jpg',
      heading: 'Async JavaScript',
      description: 'Learned asynchronous programming in JavaScript using callbacks, promises, and async/await',
    ),
    Course(
      imagePath: 'assets/mongodb_course.jpg',
      heading: 'Introduction to MongoDB',
      description: 'This  has been an incredible experience, helping me deepen my understanding of NoSQL databases, CRUD operations, aggregation frameworks, and more.',
    ),
    Course(
      imagePath: 'assets/Research.jpg',
      heading: 'Research Methodology and Publication',
      description: 'Participated in a two-day SDP on Research Methodology and Publication, focusing on research design, academic writing, and publication processes',
    ),
    Course(
      imagePath: 'assets/Microsoft.jpg',
      heading: 'Microsoft AI Learning Challenge 2025',
      description: 'Successfully completed the AINNOVATION 2025 Microsoft AI Learning Challenge, gaining foundational knowledge in Artificial Intelligence and modern AI technologies',
    ),
    Course(
      imagePath: 'assets/Flutter.jpg',
      heading: 'Flutter Workshop',
      description: 'Completed a 4-day hands-on workshop on Flutter, covering UI development, widgets, and mobile app development fundamentals',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.8,
    );
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (!mounted) return;
      final nextPage = (_currentPage + 1) % courses.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _showCertificateDialog(BuildContext context, Course course) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.75),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          constraints: const BoxConstraints(maxWidth: 900, maxHeight: 680),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 8, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        course.heading,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: const Color(0xFF1F2937),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Color(0xFF6B7280)),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, thickness: 1),
              const SizedBox(height: 12),
              // Zoomable certificate image
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: InteractiveViewer(
                    panEnabled: true,
                    boundaryMargin: const EdgeInsets.all(20),
                    minScale: 0.5,
                    maxScale: 5.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        course.imagePath,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                        isAntiAlias: true,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 350,
                          color: Colors.grey[100],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_not_supported_outlined,
                                  size: 64, color: Colors.grey[400]),
                              const SizedBox(height: 16),
                              Text(
                                'Certificate image not available',
                                style: GoogleFonts.outfit(color: Colors.grey[500]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArrowButton({required IconData icon, required VoidCallback? onPressed}) {
    return MouseRegion(
      cursor: onPressed != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(icon, color: onPressed != null ? Color(0xFFFF7F50) : Colors.grey.shade400, size: 24),
          onPressed: onPressed,
        ),
      ),
    );
  }

  Widget _buildCourseCard(Course course, bool isDesktop) {
    return AnimatedGradientBorder(
      borderWidth: 2.0,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        padding: EdgeInsets.all(isDesktop ? 32 : 16),
        child: isDesktop 
          ? Row(
              children: [
                // Image section
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      course.imagePath,
                      height: 200,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                      isAntiAlias: true,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image_not_supported,
                            size: 50,
                            color: Colors.grey[600],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 32),
                // Content section
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: const [
                            Color(0xFF000080), // Dark blue
                            Color(0xFF0000FF), // Blue
                            Color(0xFF008000), // Green
                            Color(0xFF006400), // Dark green
                            Color(0xFFFF0000), // Red
                            Color(0xFF8B0000), // Dark red
                          ],
                        ).createShader(bounds),
                        child: Text(
                          course.heading,
                          style: GoogleFonts.outfit(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'what I learned :',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        course.description,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: Color(0xFF333333),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => _showCertificateDialog(context, course),
                        icon: const Icon(Icons.workspace_premium_rounded, size: 22, color: Colors.white),
                        label: Text(
                          'View Certificate',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF7F50),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      course.imagePath,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 150,
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image_not_supported,
                            size: 40,
                            color: Colors.grey[600],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: const [
                            Color(0xFF000080), // Dark blue
                            Color(0xFF0000FF), // Blue
                            Color(0xFF008000), // Green
                            Color(0xFF006400), // Dark green
                            Color(0xFFFF0000), // Red
                            Color(0xFF8B0000), // Dark red
                          ],
                        ).createShader(bounds),
                        child: Text(
                          course.heading,
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'what I learned :',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        course.description,
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: Color(0xFF333333),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 14),
                      ElevatedButton.icon(
                        onPressed: () => _showCertificateDialog(context, course),
                        icon: const Icon(Icons.workspace_premium_rounded, size: 18, color: Colors.white),
                        label: Text(
                          'View Certificate',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF7F50),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 768;
    
    return Container(
      color: Color(0xFFF9F9F9),
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 16),
      child: Column(
        children: [
          Text(
            'CERTIFICATIONS',
            style: GoogleFonts.outfit(
              textStyle: TextStyle(
                fontSize: isDesktop ? 48 : 32,
                color: Color(0xFFFF7F50),
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 48),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isDesktop) ...[
                _buildArrowButton(
                  icon: Icons.chevron_left,
                  onPressed: _currentPage > 0 ? () {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } : null,
                ),
                SizedBox(width: 16),
              ],
              
              Expanded(
                child: SizedBox(
                  height: isDesktop ? 340 : 460,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return _buildCourseCard(courses[index], isDesktop);
                    },
                  ),
                ),
              ),
              
              if (isDesktop) ...[
                SizedBox(width: 16),
                _buildArrowButton(
                  icon: Icons.chevron_right,
                  onPressed: _currentPage < courses.length - 1 ? () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } : null,
                ),
              ],
            ],
          ),
          
          SizedBox(height: 32),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!isDesktop) ...[
                _buildArrowButton(
                  icon: Icons.chevron_left,
                  onPressed: _currentPage > 0 ? () {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } : null,
                ),
                SizedBox(width: 24),
              ],
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  courses.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 12 : 8,
                    height: _currentPage == index ? 12 : 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index 
                        ? Color(0xFFFF7F50) 
                        : Color(0xFFFF7F50).withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              
              if (!isDesktop) ...[
                SizedBox(width: 24),
                _buildArrowButton(
                  icon: Icons.chevron_right,
                  onPressed: _currentPage < courses.length - 1 ? () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } : null,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class EducationItem {
  final String degree;
  final String institution;
  final String duration;
  final String grade;
  final String description;

  EducationItem({
    required this.degree,
    required this.institution,
    required this.duration,
    required this.grade,
    required this.description,
  });
}

final List<EducationItem> educationList = [
  EducationItem(
    degree: 'Master of Computer Applications (MCA)',
    institution: 'NMAM Institute of Technology, Nitte',
    duration: '2024 – 2026',
    grade: 'CGPA: 8.29 / 10',
    description: 'Specialized in advanced software development, full-stack web technologies, databases, and software engineering.',
  ),
  EducationItem(
    degree: 'Bachelor of Computer Applications (BCA)',
    institution: 'Canara College, Mangalore (Affiliated to Mangalore University)',
    duration: '2021 – 2024',
    grade: 'Percentage: 79.45%',
    description: 'Built a strong foundation in programming, database management systems, object-oriented programming, web development, and software engineering.',
  ),
  EducationItem(
    degree: 'Pre-University Course (PUC)',
    institution: 'Besant National Pre-University College, Mangalore\nDepartment of Pre-University Education, Karnataka',
    duration: '2019 – 2021',
    grade: 'Percentage: 80.16%',
    description: 'Completed the Pre-University Course with a focus on academic fundamentals and analytical skills.',
  ),
  EducationItem(
    degree: 'Secondary School Leaving Certificate (SSLC)',
    institution: 'Sharada Ganapathi Vidyakendra\nKarnataka Secondary Education Examination Board (KSEEB)',
    duration: '2018 – 2019',
    grade: 'Percentage: 76.64%',
    description: 'Completed secondary education with a strong academic foundation.',
  ),
];

class EducationCard extends StatefulWidget {
  final EducationItem item;
  final bool isDesktop;

  const EducationCard({Key? key, required this.item, required this.isDesktop}) : super(key: key);

  @override
  _EducationCardState createState() => _EducationCardState();
}

class _EducationCardState extends State<EducationCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..translate(_isHovered ? 8.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _isHovered 
                  ? Colors.black.withOpacity(0.08) 
                  : Colors.black.withOpacity(0.03),
              blurRadius: _isHovered ? 24 : 12,
              offset: _isHovered ? const Offset(0, 12) : const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: _isHovered ? const Color(0xFFFF7F50) : Colors.grey.shade200,
            width: 1.5,
          ),
        ),
        padding: EdgeInsets.all(widget.isDesktop ? 24 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.item.degree,
                    style: GoogleFonts.outfit(
                      fontSize: widget.isDesktop ? 20 : 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF7F50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.item.duration,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF7F50),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.item.institution,
              style: GoogleFonts.outfit(
                fontSize: widget.isDesktop ? 16 : 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF20C997).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                widget.item.grade,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF20C997),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.item.description,
              style: GoogleFonts.outfit(
                fontSize: widget.isDesktop ? 14 : 13,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EducationSection extends StatelessWidget {
  final GlobalKey? headingKey;

  const EducationSection({Key? key, this.headingKey}) : super(key: key);

  Widget _buildTimelineItem(EducationItem item, bool isLast, bool isDesktop) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: isDesktop ? 44 : 36,
                height: isDesktop ? 44 : 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFFF7F50),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF7F50).withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.school_rounded,
                  size: isDesktop ? 20 : 16,
                  color: const Color(0xFFFF7F50),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 3,
                    color: const Color(0xFFFF7F50).withOpacity(0.3),
                  ),
                ),
            ],
          ),
          SizedBox(width: isDesktop ? 24 : 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: EducationCard(item: item, isDesktop: isDesktop),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 40, bottom: 80, left: 16, right: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1024),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              KeyedSubtree(
                key: headingKey,
                child: Text(
                  'EDUCATION',
                  style: GoogleFonts.outfit(
                    fontSize: isDesktop ? 48 : 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF7F50),
                    letterSpacing: 2.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 48),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: educationList.length,
                itemBuilder: (context, index) {
                  return _buildTimelineItem(
                    educationList[index],
                    index == educationList.length - 1,
                    isDesktop,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dhananjaya k - Portfolio',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColor: Color(0xFF20C997), // Aqua/Teal
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: Color(0xFF20C997),
          secondary: Color(0xFFF08A5D), // Accent orange
        ),
      ),
      home: PortfolioPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PortfolioPage extends StatefulWidget {
  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  
  // Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  
  String activeSection = 'home';
  bool _showAllProjects = false;
  
  // Global keys for sections
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _courseKey = GlobalKey();

void _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

void _openResume(String url) {
  // Force download the resume using an anchor element with the download attribute
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', 'Dhananjay_Resume.pdf')
    ..click();
}


  final List<String> technologies = [
    'React', 'JavaScript (ES6+)', 'HTML5 & CSS3', 'Node.js',
    'Git & GitHub', 'MongoDB','Firebase','MySQL','SQLite','PHP','Dart','Flutter','Visual Studio Code','C programming','Java',
    'Python', 'APIs (RESTful, MealDB)','Next.js','Express.js','Responsive Design','Strapi CMS','Agile Development','TypeScript', 'Tailwind CSS', 'PostgreSQL', 'Prisma ORM', 'Redis', 'Socket.IO', 'Vite', 'Chart.js', 'Bootstrap', 'MongoDB Atlas', 'Firebase Authentication', 'Firebase Firestore', 'Cloudinary', 'Vercel', 'Render', 'Google OAuth', 'OpenCV', 'TensorFlow', 'PyTorch', 'NumPy', 'Pandas'
  ];

  final List<Project> projects = [
    Project(
      title: 'AI-POWERED CHICKEN WEIGHT ESTIMATION SYSTEM',
      emoji: '🐔',
      description: 'AI-based system designed to estimate the weight of chickens using image processing and machine learning techniques. The application analyzes visual input to predict weight, reducing the need for manual weighing. Supports automated monitoring and data-driven decision-making to enhance productivity in poultry farming.',
      technologies: 'Python, Machine Learning, Computer Vision, OpenCV, TensorFlow / PyTorch, NumPy, Pandas, Image Processing, GitHub',
      imagePath: 'assets/chicken.png',
      codeUrl: 'https://github.com/dhanu-078/AI-Powered-Chicken-Weight-Estimation-System',
    ),
    Project(
      title: 'REAL-TIME CHAT APPLICATION',
      emoji: '💬',
      description: 'Developed a full-stack real-time chat application using React, Node.js, Express, and MongoDB, enabling live messaging with secure authentication. Implemented real-time communication and persistent data storage for user messages. Integrated WebSocket (Socket.IO) for instant message delivery and real-time updates.',
      technologies: 'React.js, Vite, HTML5, CSS3, JavaScript (ES6+), Node.js, Express.js, Socket.IO, MongoDB Atlas',
      imagePath: 'assets/chat_app.png',
      codeUrl: 'https://github.com/dhanu-078/chat-web-app',
    ),
    Project(
      title: 'GROCERY SHOPPING WEBSITE',
      description: 'An online platform for browsing and purchasing groceries with real-time cart, order history, and secure checkout. Optimized for both desktop and mobile users. Features intuitive product search, category-based browsing, and a seamless checkout process. Integrated secure user authentication and efficient order management for an enhanced shopping experience.',
      technologies: 'HTML, CSS, JavaScript, MySQL',
      imagePath: 'assets/grocery_app.png',
      codeUrl: 'https://github.com/dhanu-078/Groceroo-Grocery-Shopping-Website',
    ),
    Project(
      title: 'FARMER TO STORE CROP SELLING APP',
      emoji: '💬',
      description: 'A Flutter mobile application that connects farmers directly with stores to sell their harvested crops efficiently. The app provides an intuitive interface for listing, browsing, and purchasing agricultural produce, improving transparency and reducing intermediaries. Designed to empower farmers with direct market access and crop trade processes.',
      technologies: 'Flutter, Dart, Firebase Authentication, Firebase Firestore Database, Firebase Storage',
      imagePath: 'assets/farmer_app.png',
      codeUrl: 'https://github.com/dhanu-078/Flutter-Farmer-to-Store-Crop-Selling-App-',
    ),
    Project(
      title: 'VACCINATION CENSUS SYSTEM',
      emoji: '📊',
      description: 'A web-based vaccination census system developed to collect, manage, and visualize vaccination data efficiently. The application provides interactive dashboards with graphical representations to analyze vaccination coverage and trends. It helps in structured data management and supports better decision-making through data visualization.',
      technologies: 'React.js, Chart.js, HTML, CSS, JavaScript, Node.js, Express.js, Prisma ORM, MySQL (RDBMS), GitHub',
      imagePath: 'assets/census_system.png',
      codeUrl: 'https://github.com/dhanu-078/vaccination-census-system',
    ),
    Project(
      title: 'DELICIOUS RECIPES',
      description: 'Delicious Recipes – A recipe website that helps users discover, search, and explore a variety of dishes from around the world. Features include smart search, detailed meal information, and easy-to-follow instructions for every level of cook. Provides a responsive and intuitive interface, allowing users to quickly find recipes based on ingredients, categories, or cuisine.',
      technologies: 'React, React Router, CSS, TheMealDB API, Vite, Git and GitHub, Deployment Platform : Vercel',
      imagePath: 'assets/mealdb_app.png',
      demoUrl: 'https://mealdb-recipe-app.vercel.app/',
      codeUrl: 'https://github.com/dhanu-078/mealdb-recipe-app',
    ),
    Project(
      title: 'MAYONIX INNOVATIONS',
      description: 'Mayonix Innovations – A modern, AI-focused corporate website showcasing the company’s services, portfolio, blogs, and career opportunities. Contributed to implementing multilingual localization, SEO enhancements, CMS integration, responsive UI improvements, dynamic blog management, and performance optimizations to deliver a scalable and user-friendly web experience.',
      technologies:  'Next.js, React.js, TypeScript, Strapi CMS, Node.js, PostgreSQL, SQLite, Redis, Tailwind CSS, HTML5, CSS3, REST APIs, Cloudflare Turnstile, Cloudinary, Brevo',
      imagePath: 'assets/mayonix.png',
      demoUrl: 'https://www.mayonix.com/',
),
    Project(
      title: 'COMPANYOS',
      description: 'CompanyOS – A full-stack organizational management platform designed to streamline internship lifecycle, team collaboration, expense tracking, and attendance management. Features include Google OAuth authentication, role-based access control, real-time dashboards, intern management, standup tracking, expense monitoring, and calendar-based leave management through an intuitive and responsive interface.',
      technologies: 'React.js, Node.js, Express.js, MongoDB, Google OAuth, REST APIs, Google Apps Script, CSS, Git & GitHub, Render',
      imagePath: 'assets/companyos.png',
      demoUrl: 'https://mayonix-intranet-2.onrender.com/',
    ),
    Project(
      title: 'ID CARD APP',
      emoji: '🚀',
      description: 'A clean and minimal digital ID card application built using Flutter. This project showcases a personal profile with a profile picture, name, role, and contact information.its a great starter project for mobile/web Flutter developers.The app is responsive and optimized for deployment on the web using Flutter web build.',
      technologies: 'Flutter, Dart',
      imagePath: 'assets/idcard.png',
      demoUrl: 'https://college-id-card-ecru.vercel.app/',
      codeUrl: 'https://github.com/dhanu-078/College-ID-Card',
    ),
    Project(
      title: 'TIC-TAC-TOE GAME',
      description: 'Tic-Tac-Toe Game - A simple, interactive Tic-Tac-Toe game built using HTML, CSS, and JavaScript. Players take turns marking a 3x3 grid, aiming to get three marks in a row. The app tracks the game state, declares a winner, and allows for multiple rounds. It\'s a fun way to showcase my skills in building interactive web applications.',
      technologies: 'HTML, CSS, JavaScript',
      imagePath: 'assets/tic_tac_toe.png',
      demoUrl: 'https://dhanu-078.github.io/tic-tac-toe/',
      codeUrl: 'https://github.com/dhanu-078/tic-tac-toe',
    ),
    Project(
      title: 'FLUTTER COUNTER APPLICATION',
      description: 'A simple and intuitive mobile application built using Flutter that demonstrates basic state management and user interaction. The app features responsive UI elements allowing users to increment and decrement a counter value with button taps. It serves as an excellent starter project for learning Flutter fundamentals and understanding widget-based UI construction.',
      technologies: 'Flutter, Dart',
      imagePath: 'assets/counter.png',
      codeUrl: 'https://github.com/dhanu-078/Flutter-Counter-Application',
    ),
    Project(
      title: 'MYRESTAURANT – DIGITAL RESTAURANT MENU WEBSITE',
      description: 'A responsive and user-friendly restaurant menu website built to showcase food items with images, descriptions, pricing, and an integrated contact form. Users can easily browse the menu, search for dishes, and send inquiries through EmailJS without leaving the page. Designed with clean UI/UX principles, the site works smoothly across devices.',
      technologies: 'HTML5, CSS3, JavaScript, Bootstrap, jQuery, EmailJS, GitHub',
      imagePath: 'assets/restaurant.png',
      codeUrl: 'https://github.com/dhanu-078/MyRestaurant-Digital-Restaurant-Menu-Website',
    ),
  ];

  void scrollToSection(GlobalKey key, String sectionId) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
        alignment: 0.1, // Position slightly from top for better visibility
        alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
      );
      setState(() {
        activeSection = sectionId;
      });
    }
  }

 void handleSubmit() {
  if (_nameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _messageController.text.isNotEmpty) {

    final templateParams = jsify({
  'name': _nameController.text,
  'email': _emailController.text,
  'message': _messageController.text,
});

    print(templateParams);
    print("Name: ${_nameController.text}");
    print("Email: ${_emailController.text}");
    print("Message: ${_messageController.text}");

    send(
      'service_hddj0du',   // e.g. service_abc123
      'template_y8mjho9',  // e.g. template_xyz789
      templateParams,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Message Sent!'),
          content: Text('Thank you for reaching out.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _nameController.clear();
                _emailController.clear();
                _messageController.clear();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
Widget _buildProjectCard(Project project) {
  return MouseRegion(
    onHover: (_) => setState(() {}),
    child: AnimatedScale(
      scale: 1.0,
      duration: Duration(milliseconds: 200),
      child: Container(
        width: 340,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Color(0xFFFF7F50), Color(0xFFF39C12)],
          ),
        ),
        padding: EdgeInsets.all(1.5), // Gradient border
        child: Container(
          height: 600, // Fixed height to make all cards equal size
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (project.imagePath != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    project.imagePath!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                  ),
                ),
              SizedBox(height: 20),
              Text(
                project.title,
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF7F50),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        project.description,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: Color(0xFF333333),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Technologies used: ',
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold, // Bold label
                              ),
                            ),
                            TextSpan(
                              text: project.technologies,
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                color: Color(0xFFFF7F50), // Main coral/orange accent color
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (project.demoUrl != null)
                    _buildProjectButton('View Demo', Icons.open_in_new, project.demoUrl!, Color(0xFFFF7F50)),
                  SizedBox(width: 12),
                  if (project.codeUrl != null)
                    _buildProjectButton('View Code', Icons.code, project.codeUrl!, Color(0xFFFF9900)),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _footerSection({required String title, required List<Widget> items, bool isIcons = false}) {
  return SizedBox(
    width: 300,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16),
        isIcons
            ? Row(
                children: items,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: items.map((item) => Padding(padding: EdgeInsets.only(bottom: 10), child: item)).toList(),
              ),
      ],
    ),
  );
}

Widget _linkText(String text, String anchor) {
  return Text(
    text,
    style: GoogleFonts.outfit(
      fontSize: 14,
      color: Colors.white.withOpacity(0.9),
      decoration: TextDecoration.underline,
    ),
  );
}

Widget _externalLink(String text, String url) {
  return InkWell(
    onTap: () => _launchURL(url),
    child: Text(
      text,
      style: GoogleFonts.outfit(
        fontSize: 14,
        color: Colors.white.withOpacity(0.9),
        decoration: TextDecoration.underline,
      ),
    ),
  );
}

Widget _plainText(String text) {
  return Text(
    text,
    style: GoogleFonts.outfit(
      fontSize: 14,
      color: Colors.white.withOpacity(0.9),
    ),
  );
}

Widget _socialIcon(IconData icon, String url) {
  return Padding(
    padding: const EdgeInsets.only(right: 16),
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchURL(url),
        child: FaIcon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    ),
  );
}

Widget _buildProjectButton(String text, IconData icon, String url, Color color) {
  return ElevatedButton.icon(
    onPressed: () => _launchURL(url),
    icon: Icon(icon, size: 18),
    label: Text(text, style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 4,
    ),
  );
}

Widget _linkButton(String label, [GlobalKey? key, String? sectionId, String? externalUrl]) {
  return TextButton(
    onPressed: () {
      if (externalUrl != null) {
        _launchURL(externalUrl);
      } else if (key != null && sectionId != null) {
        scrollToSection(key, sectionId);
      }
    },
    child: Text(
      label,
      style: GoogleFonts.outfit(
        color: Colors.white.withOpacity(0.9),
        fontSize: 14,
        // No underline
        decoration: TextDecoration.none,
      ),
    ),
  );
}

Widget _buildContactForm() {
  final inputDecoration = (String hint) => InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.outfit(
          color: Colors.grey[600],
          fontSize: 16,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFFF7F50), width: 2),
        ),
      );

  return Container(
    padding: EdgeInsets.all(32),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
       TextField(
           controller: _nameController,
           decoration: inputDecoration('Your Name'),
           style: GoogleFonts.outfit(),
          ),

        SizedBox(height: 24),
        TextField(
             controller: _emailController,
             decoration: inputDecoration('Your Email'),
             style: GoogleFonts.outfit(),
           ),

        SizedBox(height: 24),
        TextField(
            controller: _messageController,
            decoration: inputDecoration('Your Message'),
            maxLines: 5,
            style: GoogleFonts.outfit(),
          ),

        SizedBox(height: 32),
        SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: handleSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFF7F50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
            ),
            child: Text(
              'Send Message',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              // Home Section
              /*SliverToBoxAdapter(
                child: Container(
                  key: _homeKey,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFB923C),
                        Color(0xFFF97316),
                        Color(0xFFEA580C),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dhananjaya k',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width > 768 ? 80 : 56,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Web Developer',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width > 768 ? 32 : 24,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),*/
              
              
// About Section
SliverToBoxAdapter(
  child: Container(
    key: _aboutKey,
    color: Color(0xFFF9FAFB),
    padding: EdgeInsets.only(top: 80, bottom: 40, left: 16, right: 16),
    child: LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 768;

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1024),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Left Side: Description
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ABOUT ME',
                                style: GoogleFonts.outfit(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF7F50),
                                ),
                              ),
                              SizedBox(height: 24),
                              Text(
                                "Welcome to my portfolio! Here, you'll find my education, technical skills, certifications, and a collection of projects that showcase my passion for web and software development. I am a Full-Stack Web Developer who enjoys building modern, responsive, and user-friendly web applications using React.js, Next.js, Node.js, Express.js, and MySQL. Thank you for visiting, and feel free to reach out!",
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Right Side: Squircle Image with Animated Gradient Border
                      Container(
                        width: 280,
                        height: 280,
                        margin: const EdgeInsets.only(left: 32, top: 40),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: AnimatedGradientBorder(
                          borderWidth: 4.0,
                          borderRadius: BorderRadius.circular(24),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/profile.png', // ✅ Make sure this path is correct
                              fit: BoxFit.cover,
                              width: 280,
                              height: 280,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'ABOUT ME',
                        style: GoogleFonts.outfit(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF7F50),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32),
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 15,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: AnimatedGradientBorder(
                          borderWidth: 3.5,
                          borderRadius: BorderRadius.circular(20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.5),
                            child: Image.asset(
                              'assets/profile.png',
                              fit: BoxFit.cover,
                              width: 200,
                              height: 200,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 32),
                      Text(
                        "Welcome to my portfolio! Here, you'll find my education, technical skills, certifications, and a collection of projects that showcase my passion for web and software development. I am a Full-Stack Web Developer who enjoys building modern, responsive, and user-friendly web applications using React.js, Next.js, Node.js, Express.js, and MySQL. Thank you for visiting, and feel free to reach out!",
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
          ),
        );
      },
    ),
  ),
),

// Education Section
SliverToBoxAdapter(
  child: EducationSection(headingKey: _educationKey),
),

              // Skills Section
              SliverToBoxAdapter(
                child: Container(
                  key: _skillsKey,
                  color: Color(0xFFF9FAFB),
                  padding: EdgeInsets.symmetric(vertical: 80, horizontal: 16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 1024),
                    child: Column(
                      children: [
                        Text(
                          'Technologies & Tools I Work With',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width > 768 ? 36 : 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 48),
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          alignment: WrapAlignment.center,
                          children: technologies.map((tech) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            decoration: BoxDecoration(
                              color: Color(0xFFF97316),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              tech,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Projects Section
            SliverToBoxAdapter(
  child: Container(
    key: _projectsKey,
    color: Color(0xFFF4F4F4),
    padding: EdgeInsets.symmetric(vertical: 80, horizontal: 16),
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 1200),
      child: Column(
        children: [
          Text(
            'PROJECTS',
            style: GoogleFonts.outfit(
              textStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 768 ? 36 : 28,
                color: Color(0xFFFF7F50),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 48),
          AnimatedSize(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: (_showAllProjects ? projects : projects.sublist(0, 8)).map((project) {
                return _buildProjectCard(project);
              }).toList(),
            ),
          ),
          SizedBox(height: 40),
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                _showAllProjects = !_showAllProjects;
              });
            },
            icon: Icon(
              _showAllProjects ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Color(0xFFFF7F50),
            ),
            label: Text(
              _showAllProjects ? 'Show Less' : 'More Projects',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF7F50),
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Color(0xFFFF7F50), width: 2),
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    ),
  ),
),

//Course Section
SliverToBoxAdapter(
  child: Container(
    key: _courseKey,
    child: CourseSection(),
  ),
),


              
              // Contact Section
              SliverToBoxAdapter(
  child: KeyedSubtree(
    key: _contactKey,
    child: Container(
      color: Color(0xFFF9FAFB),
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 768;
          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1024),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'CONTACT ME',
                  style: GoogleFonts.outfit(
                    fontSize: isDesktop ? 48 : 32,
                    color: Color(0xFFFF7F50),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 64),
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: isDesktop ? 600 : double.infinity),
                    child: _buildContactForm(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  ),
),

              // Footer
      SliverToBoxAdapter(
  child: Container(
    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFF7F50), Color(0xFFF39C12)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1200),
          child: Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              _footerSection(
                title: 'Quick Links',
                items: [
                  _linkButton('Home', _aboutKey, 'about'),
                  _linkButton('Education', _educationKey, 'education'),
                  _linkButton('Projects', _projectsKey, 'projects'),
                  _linkButton('Certificates', _courseKey, 'course'),
                  _linkButton('Contact', _contactKey, 'contact'),
                  TextButton(
                    onPressed: () => _openResume('/resume.pdf'),
                    child: Text(
                      'Resume',
                      style: GoogleFonts.outfit(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
              _footerSection(
                title: 'Get in Touch',
                items: [
                  _plainText('Email: dhananjaydhanu2004@gmail.com'),
                  _plainText('Phone: +91 9148750944'),
                  _plainText('Location: Mudipu, Karnataka, India'),
                ],
              ),
              _footerSection(
                title: 'Follow Me',
                items: [
                  _socialIcon(FontAwesomeIcons.github, 'https://github.com/dhanu-078'),
                  _socialIcon(FontAwesomeIcons.linkedin, 'https://www.linkedin.com/in/dhananjayak2024/'),
                  _socialIcon(FontAwesomeIcons.instagram, 'https://www.instagram.com/dhhananjay_/?hl=en'),
                  _socialIcon(FontAwesomeIcons.envelope, 'mailto:dhananjaydhanu2004@gmail.com'),
                ],
                isIcons: true,
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
        Divider(color: Colors.white.withOpacity(0.3), thickness: 1),
        SizedBox(height: 20),
        Column(
          children: [
            Text(
              'Made with ❤️ by Dhananjaya k',
              style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
            ),
            SizedBox(height: 6),
            Text(
              '"Dream big, work hard, stay focused."',
              style: GoogleFonts.outfit(color: Colors.white70, fontSize: 13),
            ),
            SizedBox(height: 6),
            Text(
              '© ${DateTime.now().year} All rights reserved.',
              style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ],
    ),
  ),
),
], // This closes the slivers list
          ), // This closes the CustomScrollView

          
          // Fixed Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFF7F50), // Orange background
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      'Dhananjaya k',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    SizedBox(height: 2),
    Text(
      'Web Developer',
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.white.withOpacity(0.9),
      ),
    ),
  ],
),

                      if (MediaQuery.of(context).size.width > 768)
                        Row(
                          children: [
                            _buildNavButton('Home', 'about', _aboutKey, Icons.home_rounded),
                            SizedBox(width: 32),
                            _buildNavButton('Education', 'education', _educationKey, Icons.school),
                            SizedBox(width: 32),
                            _buildNavButton('Skills', 'skills', _skillsKey, Icons.code),
                            SizedBox(width: 32),
                            _buildNavButton('Projects', 'projects', _projectsKey, Icons.work),
                            SizedBox(width: 32),
                            _buildNavButton('Certificates', 'course', _courseKey, Icons.workspace_premium_rounded),
                            SizedBox(width: 32),
                            _buildNavButton('Contact', 'contact', _contactKey, Icons.contact_mail),
                          ],
                        )
                      else
                        IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState?.openEndDrawer();
                          },
                          icon: Icon(Icons.menu, color: Colors.white),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      endDrawer: MediaQuery.of(context).size.width <= 768 ? Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFF97316),
              ),
                            child: Text(
                'Navigation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildDrawerItem('Home', 'about', _aboutKey, Icons.home_rounded),
            _buildDrawerItem('Education', 'education', _educationKey, Icons.school),
            _buildDrawerItem('Skills', 'skills', _skillsKey, Icons.code),
            _buildDrawerItem('Projects', 'projects', _projectsKey, Icons.work),
            _buildDrawerItem('Certificates', 'course', _courseKey, Icons.workspace_premium_rounded),
            _buildDrawerItem('Contact', 'contact', _contactKey, Icons.contact_mail),
          ],
        ),
      ) : null,
    );
  }

  Widget _buildDrawerItem(String label, String sectionId, GlobalKey key, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        Navigator.of(context).pop();
        scrollToSection(key, sectionId);
      },
    );
  }

  Widget _buildNavButton(String label, String sectionId, GlobalKey key, IconData icon) {
    return TextButton.icon(
      onPressed: () => scrollToSection(key, sectionId),
      icon: Icon(icon, color: Colors.white),
label: Text(
  label,
  style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
  ),
),

    );
  }

  Widget _buildQuickLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('QUICK LINKS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 16),
        _buildLinkButton('Home', _aboutKey, 'about'),
        _buildLinkButton('Education', _educationKey, 'education'),
        _buildLinkButton('Projects', _projectsKey, 'projects'),
        _buildLinkButton('Contact', _contactKey, 'contact'),
        TextButton(
          onPressed: () => _openResume('/resume.pdf'),
          child: Text('Resume', style: TextStyle(color: Colors.white.withOpacity(0.9))),
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('GET IN TOUCH', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 16),
        _buildContactRow(Icons.email, 'dhananjaydhanu2004@gmail.com'),
        _buildContactRow(Icons.phone, '+91 9148750944'),
        _buildContactRow(Icons.location_on, 'Mudipu, Karnataka, India'),
      ],
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        SizedBox(width: 8),
        Flexible(child: Text(text, style: TextStyle(color: Colors.white.withOpacity(0.9)))),
      ],
    );
  }

  Widget _buildLinkButton(String label, GlobalKey key, String sectionId) {
    return TextButton(
      onPressed: () => scrollToSection(key, sectionId),
      child: Text(label, style: TextStyle(color: Colors.white.withOpacity(0.9))),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return InkWell(
      onTap: () {}, // Add actual URLs using launchUrl if needed
      child: Icon(icon, size: 28, color: Colors.white.withOpacity(0.9)),
    );
  }
}




