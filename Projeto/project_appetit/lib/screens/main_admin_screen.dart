import 'package:flutter/material.dart';
import '../components/custom_nav_bar.dart';
import 'package:project_appetit/screens/profile_screen.dart';
import 'package:project_appetit/screens/home_screen.dart'; // Importe a sua HomeScreen

class MainScreenAdmin extends StatefulWidget {
  const MainScreenAdmin({super.key});

  @override
  State<MainScreenAdmin> createState() => _MainScreenAdminState();
}

class _MainScreenAdminState extends State<MainScreenAdmin> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Transformado em um 'get' para podermos passar a função _onItemTapped para a HomeScreen
  List<Widget> get _telas => [
    // Substituímos o Center de aviso pela HomeScreen real passando a função
    HomeScreen(
  onNavigateToManageChildren: () {
    // Aqui você chama a função que muda a aba nesse arquivo.
    // Provavelmente é _onItemTapped(1); igual no admin
    _onItemTapped(1); 
  },
  onNavigateToProfile: () {  // <-- NOVA FUNÇÃO DE REDIRECIONAMENTO AQUI
        _onItemTapped(4); // 4 é o índice da const ProfileScreen() na lista abaixo
      },
),
    const Center(child: Text("Tela Crianças")), // Aqui no futuro você vai colocar sua ManageChildrenScreen()
    const Center(child: Text("Tela Câmera")),
    const Center(child: Text("Tela Arquivos")),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Painel Administrativo",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: _telas[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}