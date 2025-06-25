import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const LawyerLamApp());
}

class LawyerLamApp extends StatefulWidget {
  const LawyerLamApp({super.key});

  @override
  State<LawyerLamApp> createState() => _LawyerLamAppState();
}

class _LawyerLamAppState extends State<LawyerLamApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luật Sư Lâm',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: Colors.grey.shade100,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      home: HomePage(
        onToggleTheme: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const HomePage({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Luật Sư Lâm',
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: isDarkMode ? 'Chuyển sang chế độ sáng' : 'Chuyển sang chế độ tối',
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggleTheme,
            color: Colors.indigo,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.width < 600 ? 200 : 280,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: const [
                      LawyerImage(
                        assetPath: 'assets/images/lam1.jpeg',
                        caption: 'Trung Thực',
                      ),
                      SizedBox(width: 16),
                      LawyerImage(
                        assetPath: 'assets/images/lam2.jpeg',
                        caption: 'Tỉ mỉ',
                      ),
                      SizedBox(width: 16),
                      LawyerImage(
                        assetPath: 'assets/images/lam3.jpeg',
                        caption: 'Tận Tâm',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Ngành Tư Vấn',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 16),
              const LawCategory(
                title: 'Luật Hôn Nhân Gia Đình',
                description:
                    'Tư vấn ly hôn, chia tài sản, quyền nuôi con, đăng ký kết hôn, nhận con nuôi và các vấn đề gia đình khác.',
              ),
              const LawCategory(
                title: 'Luật Bất Động Sản',
                description:
                    'Hỗ trợ pháp lý giao dịch nhà đất, sang tên sổ đỏ, di chúc, thừa kế và giải quyết tranh chấp.',
              ),
              const LawCategory(
                title: 'Luật Chứng Khoán',
                description:
                    'Tư vấn phát hành cổ phiếu, niêm yết, hợp đồng đầu tư và tuân thủ luật chứng khoán Việt Nam.',
              ),
              const SizedBox(height: 32),
              const ContactSection(),
            ],
          ),
        ),
      ),
    );
  }
}


class LawyerImage extends StatelessWidget {
  final String assetPath;
  final String caption;

  const LawyerImage({
    super.key,
    required this.assetPath,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    final captionColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    final double imageSize = MediaQuery.of(context).size.width < 600 ? 140 : 220;

    return Column(
      children: [
        Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.indigo, width: 3),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(assetPath, fit: BoxFit.cover),
        ),
        const SizedBox(height: 8),
        Text(
          caption,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: captionColor,
          ),
        ),
      ],
    );
  }
}

class LawCategory extends StatelessWidget {
  final String title;
  final String description;

  const LawCategory({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor = isDark ? Colors.grey[900]! : Colors.white;
    final borderColor = isDark ? Colors.grey[700]! : Colors.grey.shade300;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.gavel, size: 28, color: Colors.indigo),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 40, thickness: 1),
        Text(
          'Liên hệ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
        ),
        const SizedBox(height: 12),
        Text('📞 Điện Thoại: 0963938219', style: TextStyle(color: textColor)),
        Text('💬 Zalo: 0963938219', style: TextStyle(color: textColor)),
        Text('📧 Email: luatsulam75@gmail.com', style: TextStyle(color: textColor)),
        Text('📍 Địa chỉ: Đường Số 2, Hiệp Bình Phước, Thành Phố Thủ Đức',
            style: TextStyle(color: textColor)),
        const SizedBox(height: 20),
      ],
    );
  }
}
