import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'email_service.dart';
import 'dart:js_util';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';

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
  late Timer _timer;
  int _currentPage = 0;

  final List<Course> courses = [
    Course(
      imagePath: 'assets/asyncjavascript.jpg', // Make sure to add these images to your assets
      heading: 'Async JavaScript',
      description: 'Learned asynchronous programming in JavaScript using callbacks, promises, and async/await',
    ),
    Course(
      imagePath: 'assets/mongodb_course.jpg',
      heading: 'Introduction to MongoDB',
      description: 'This course has been an incredible experience, helping me deepen my understanding of NoSQL databases, CRUD operations, aggregation frameworks, and more.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.8, // Adjust this value for the desired width of each page
    );
    
    // Auto-scroll timer
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < courses.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
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
                  ],
                ),
              ),
            ],
          )
        : SingleChildScrollView( // ADD THIS TO PREVENT OVERFLOW
            child: Column(
              mainAxisSize: MainAxisSize.min, // ADD THIS
              children: [
                // Image section for mobile - MAKE IT SMALLER
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    course.imagePath,
                    height: 150, // REDUCED from 200 to 150
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 150, // REDUCED from 200 to 150
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.image_not_supported,
                          size: 40, // REDUCED from 50 to 40
                          color: Colors.grey[600],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 12), // REDUCED from 16 to 12
                // Content section for mobile
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min, // ADD THIS
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
                          fontSize: 16, // REDUCED from 18 to 16
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2, // ADD THIS TO LIMIT LINES
                        overflow: TextOverflow.ellipsis, // ADD THIS
                      ),
                    ),
                    SizedBox(height: 8), // REDUCED from 12 to 8
                    Text(
                      'what I learned :',
                      style: GoogleFonts.outfit(
                        fontSize: 14, // RESTORED to original size
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6), // REDUCED from 8 to 6
                    Text(
                      course.description,
                      style: GoogleFonts.outfit(
                        fontSize: 12, // RESTORED to original size
                        color: Color(0xFF333333),
                        height: 1.5, // RESTORED to original line height
                      ),
                      textAlign: TextAlign.center,
                      // REMOVED maxLines and overflow to allow full text display
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
          // Course title
          Text(
            'COURSE',
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
          
          // Course carousel
          SizedBox(
            height: isDesktop ? 300 : 400,
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
          
          // Page indicators
          SizedBox(height: 20),
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
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  
  // Global keys for sections
  final GlobalKey _aboutKey = GlobalKey();
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

  final List<String> technologies = [
    'React', 'JavaScript (ES6+)', 'HTML5 & CSS3', 'Node.js',
    'Git & GitHub', 'MongoDB', 'C programming', 'PHP', 'Java',
    'Python', 'APIs (RESTful, MealDB)', 'Responsive Design', 'Agile Development'
  ];

  final List<Project> projects = [
    Project(
      title: 'ID CARD APP',
      emoji: '🚀',
      description: 'A clean and minimal digital ID card application built using Flutter. This project showcases a personal profile with a profile picture, name, role, and contact information.its a great starter project for mobile/web Flutter developers.The app is responsive and optimized for deployment on the web using Flutter web build.',
      technologies: 'Flutter, Dart',
      imagePath: 'assets/idcard.png',
      demoUrl: 'https://web-chi-nine-61.vercel.app/',
      codeUrl: 'https://github.com/dhanu-078/flutter-id-card-app',
    ),
    Project(
      title: 'DELICIOUS RECIPES',
      description: 'Delicious Recipes - A recipe website that helps users discover, search, and explore a variety of dishes from around the world. Features include smart search, detailed meal information, and easy-to-follow instructions for every level of cook.',
      technologies: 'React, React Router, CSS, TheMealDB API, Vite, Git and GitHub, Deployment Platform : Vercel',
      imagePath: 'assets/mealdb_app.png',
      demoUrl: 'https://mealdb-recipe-app.vercel.app/',
      codeUrl: 'https://github.com/dhanu-078/mealdb-recipe-app',
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
  title: 'GROCERY SHOPPING WEBSITE',
  description: 'An online platform for browsing and purchasing groceries with real-time cart, order history, and secure checkout. Optimized for both desktop and mobile users Features intuitive product search, category-based browsing, and a seamless checkout process.',
  technologies: 'HTML, CSS, JavaScript, MySQL',
  imagePath: 'assets/grocery_app.png', // Place your image in assets and update the filename if needed
  demoUrl: 'https://your-grocery-app-demo-link', // Optional: add live demo link if available
  codeUrl: 'https://github.com/dhanu-078/grocery-shopping-website',
         ),
  ];

  void scrollToSection(GlobalKey key, String sectionId) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
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
              Text(
                'Technologies used: ${project.technologies}',
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
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
  key: _aboutKey,
  child: Container(
    color: Color(0xFFF9FAFB),
    padding: EdgeInsets.symmetric(vertical: 80, horizontal: 16),
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
                                "Hello, I'm Dhananjaya k, a passionate web developer with a keen eye for detail and a love for creating seamless user experiences. I specialize in building modern, responsive websites using the latest web technologies such as React, JavaScript, HTML5, and CSS3.\n\nMy goal is to craft fast, beautiful, and interactive applications that solve real-world problems. With a focus on front-end development, I work closely with clients and teams to deliver high-quality projects that exceed expectations. I’m constantly expanding my knowledge and love staying up-to-date with new tools and frameworks in the web development ecosystem.",
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

                      // Right Side: Image with Gradient Circle
                      Container(
                        width: 280,
                        height: 280,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF8B5CF6),
                              Color(0xFF6366F1),
                              Color(0xFFEC4899),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 16,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(6),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/profile.jpg', // ✅ Make sure this path is correct
                            fit: BoxFit.cover,
                            width: 280,
                            height: 280,
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
    shape: BoxShape.circle,
    gradient: LinearGradient(
      colors: [
        Color(0xFF8B5CF6),
        Color(0xFF6366F1),
        Color(0xFFEC4899),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 12,
        offset: Offset(0, 6),
      ),
    ],
  ),
  padding: EdgeInsets.all(5),
  child: ClipOval(
    child: Image.asset(
      'assets/profile.jpg',
      fit: BoxFit.cover,
    ),
  ),
),

                      SizedBox(height: 32),
                      Text(
                        "Hello, I'm Dhananjaya k, a passionate web developer with a keen eye for detail and a love for creating seamless user experiences. I specialize in building modern, responsive websites using the latest web technologies such as React, JavaScript, HTML5, and CSS3.\n\nMy goal is to craft fast, beautiful, and interactive applications that solve real-world problems. With a focus on front-end development, I work closely with clients and teams to deliver high-quality projects that exceed expectations. I’m constantly expanding my knowledge and love staying up-to-date with new tools and frameworks in the web development ecosystem.",
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

              // Skills Section
              SliverToBoxAdapter(
                child: Container(
                  key: _skillsKey,
                  color: Colors.white,
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
            'Projects',
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
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: projects.map((project) {
              return _buildProjectCard(project);
            }).toList(),
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
                  _linkButton('About Me', _aboutKey, 'about'),
                  _linkButton('Projects', _projectsKey, 'projects'),
                  _linkButton('Contact', _contactKey, 'contact'),
                  _linkButton('Resume', null, null, 'https://yourdomain.com/Dhananjaya_K_Resume.pdf'),
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
                  _socialIcon(FontAwesomeIcons.twitter, 'https://twitter.com'),
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
                            _buildNavButton('About', 'about', _aboutKey, Icons.info),
                            SizedBox(width: 32),
                            _buildNavButton('Skills', 'skills', _skillsKey, Icons.code),
                            SizedBox(width: 32),
                            _buildNavButton('Projects', 'projects', _projectsKey, Icons.work),
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
            _buildDrawerItem('About', 'about', _aboutKey, Icons.info),
            _buildDrawerItem('Skills', 'skills', _skillsKey, Icons.code),
            _buildDrawerItem('Projects', 'projects', _projectsKey, Icons.work),
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
        _buildLinkButton('About Me', _aboutKey, 'about'),
        _buildLinkButton('Projects', _projectsKey, 'projects'),
        _buildLinkButton('Contact', _contactKey, 'contact'),
        TextButton(
          onPressed: () {}, // Replace with resume download if needed
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




