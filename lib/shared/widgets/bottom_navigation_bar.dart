import 'package:flutter/material.dart';
import 'package:habitious/core/theme/app_colors.dart';

class AppBottomBar extends StatelessWidget {
  final int currentIndex;
  // final ValueChanged<int> onTap;

  const AppBottomBar({
    Key? key,
    required this.currentIndex,
    // required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFF1C1C1E), // Тонкая линия разделения сверху
            width: 0.5,
          ),
        ),
      ),
      child: Theme(
        // Убираем дефолтные эффекты нажатия
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          // onTap: onTap,
          backgroundColor: AppColors.darkCard,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF7B61FF), // Фиолетовый акцент
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontFamily: 'SF Pro Display',
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontFamily: 'SF Pro Display',
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              label: 'Статистика',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_rounded),
              label: 'Друзья',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Профиль',
            ),
          ],
        ),
      ),
    );
  }
}