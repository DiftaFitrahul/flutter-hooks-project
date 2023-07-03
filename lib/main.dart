import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

// Stream<String> getTime() => Stream.periodic(
//       const Duration(seconds: 1),
//       (_) {
//         return DateTime.now().toIso8601String();
//       },
//     );

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final timeNow = useStream(getTime());
//     return Scaffold(
//       appBar: AppBar(title: Text(timeNow.data ?? "Home Page")),
//     );
//   }
// }


class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final text = useState('');
    useEffect(() {
      controller.addListener(() {
        text.value = controller.text;
      });
      return null;
    }, [controller]);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
          ),
          Text('you typed : ${text.value}')
        ],
      ),
    );
  }
}
