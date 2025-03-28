import 'package:day_in_bloom_v1/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InputUserInfoScreen extends StatefulWidget {
  const InputUserInfoScreen({super.key});

  @override
  _InputUserInfoScreenState createState() => _InputUserInfoScreenState();
}

class _InputUserInfoScreenState extends State<InputUserInfoScreen> {
  final Map<String, TextEditingController> _controllers = {
    "이름": TextEditingController(),
    "키 (cm)": TextEditingController(),
    "체중 (kg)": TextEditingController(),
    "나이 (세)": TextEditingController(),
  };

  String? _selectedGender;
  final List<String> _genders = ["남성", "여성"];

  void _onComplete() {
    if (_controllers.values.any((controller) => controller.text.isEmpty) ||
        _selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("모든 정보를 입력해주세요.")),
      );
      return;
    }

    final userInfo = {
      "이름": _controllers["이름"]!.text,
      "키": _controllers["키 (cm)"]!.text,
      "체중": _controllers["체중 (kg)"]!.text,
      "나이": _controllers["나이 (세)"]!.text,
      "성별": _selectedGender,
    };

    print("사용자 정보: $userInfo");

    context.go('/main');
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  children: [
                    TextSpan(text: "필수 사용자 정보", style: TextStyle(color: Colors.orange)),
                    TextSpan(text: "를 입력해주세요!"),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              for (var entry in _controllers.entries)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: entry.value,
                    decoration: InputDecoration(
                      labelText: entry.key,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.orange, width: 2),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    keyboardType: entry.key == "이름" ? TextInputType.text : TextInputType.number,
                  ),
                ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                items: _genders
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.orange, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "성별 선택",
                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                ),
                isDense: true,
                isExpanded: true,
                alignment: AlignmentDirectional.bottomStart,
                dropdownColor: Colors.white,
              ),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.orange,
                    ),
                    onPressed: _onComplete,
                    child: const Text(
                      "입력 완료",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
}
