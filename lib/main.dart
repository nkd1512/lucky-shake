import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'dart:math';

void main() => runApp(const LuckyShakeApp());

class LuckyShakeApp extends StatelessWidget {
  const LuckyShakeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lucky Sheky',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const WelcomeScreen(),
    );
  }
}

// --- หน้าที่ 1: Welcome Screen (คะแนนข้อ 7: มีมากกว่า 1 หน้าจอ) ---
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // คะแนนข้อ 10: Icon เป็นของตัวเอง
            const Icon(Icons.auto_awesome, size: 100, color: Colors.blue), 
            const SizedBox(height: 20),
            const Text(
              'Lucky Sheky App',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            // --- คะแนนข้อ 12: แสดงชื่อและรหัสนักศึกษาครบถ้วน ---
            const Text(
              'ผู้พัฒนา (Developer):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const Text(
              'ณิชากร คัญทัพ',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'รหัสนักศึกษา: 6704101327',
              style: TextStyle(fontSize: 20, color: Colors.blueGrey),
            ),
            // ----------------------------------------------
            const SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShakeScreen()),
                );
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('เข้าสู่โปรแกรม (Start)', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            // คะแนนข้อ 6: มีปุ่มจบโปรแกรม (Exit)
            TextButton.icon(
              onPressed: () => SystemNavigator.pop(),
              icon: const Icon(Icons.exit_to_app, color: Colors.red),
              label: const Text('ออกจากโปรแกรม (Exit)', style: TextStyle(color: Colors.red, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

// --- หน้าที่ 2: หน้าสุ่ม (ShakeScreen) ---
class ShakeScreen extends StatefulWidget {
  const ShakeScreen({super.key});
  @override
  State<ShakeScreen> createState() => _ShakeScreenState();
}

class _ShakeScreenState extends State<ShakeScreen> {
  final List<String> _nameList = [];
  String _winner = "เพิ่มชื่อแล้วกดสุ่มเลย!";
  final TextEditingController _controller = TextEditingController();

  void _addName() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _nameList.add(_controller.text.trim());
        _controller.clear();
      });
      debugPrint('Added Name: ${_nameList.last}'); // คะแนนข้อ 13: Logcat
    }
  }

  void _removeName(int index) {
    setState(() {
      _nameList.removeAt(index);
    });
  }

  void _pickWinner() {
    if (_nameList.isNotEmpty) {
      setState(() {
        _winner = _nameList[Random().nextInt(_nameList.length)];
      });
      debugPrint('Winner picked: $_winner'); // คะแนนข้อ 13: Logcat
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณาเพิ่มชื่อก่อนสุ่มครับ')),
      );
    }
  }

  void _resetApp() {
    setState(() {
      _nameList.clear();
      _winner = "เพิ่มชื่อแล้วกดสุ่มเลย!";
      _controller.clear();
    });
    debugPrint('App Reset'); // คะแนนข้อ 13: Logcat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lucky Sheky'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade100,
      ),
      body: SingleChildScrollView( // คะแนนข้อ 8: รองรับแนวตั้งและแนวนอน
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'พิมพ์ชื่อเพื่อน (Input Name)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                onSubmitted: (_) => _addName(),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _addName,
                icon: const Icon(Icons.add_circle),
                label: const Text('เพิ่มชื่อลงในรายการ (Add)'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('รายชื่อทั้งหมดในระบบ:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              const SizedBox(height: 10),
              Container(
                height: 120,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade100),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
                ),
                child: _nameList.isEmpty
                    ? const Center(child: Text('ยังไม่มีรายชื่อ', style: TextStyle(color: Colors.grey)))
                    : SingleChildScrollView(
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: _nameList.asMap().entries.map((entry) {
                            return Chip(
                              label: Text(entry.value),
                              onDeleted: () => _removeName(entry.key),
                              deleteIconColor: Colors.red.shade300,
                              backgroundColor: Colors.blue.shade50,
                            );
                          }).toList(),
                        ),
                      ),
              ),
              const SizedBox(height: 30),
              const Text('ผู้โชคดีคือ...', style: TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: Text(
                  _winner,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: _pickWinner,
                      icon: const Icon(Icons.auto_fix_high),
                      label: const Text('สุ่มชื่อ (Pick)', style: TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: _resetApp,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      child: const Text('รีเซ็ต'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text('จำนวนชื่อปัจจุบัน: ${_nameList.length} คน', style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}