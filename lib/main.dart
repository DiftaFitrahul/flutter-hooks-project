import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

// class HomePage extends HookWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = useTextEditingController();
//     final text = useState('');
//     useEffect(() {
//       controller.addListener(() {
//         text.value = controller.text;
//       });
//       return null;
//     }, [controller]);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home Page"),
//       ),
//       body: Column(
//         children: [
//           TextField(
//             controller: controller,
//           ),
//           Text('you typed : ${text.value}')
//         ],
//       ),
//     );
//   }
// }

const uri =
    'https://assets.pikiran-rakyat.com/crop/0x0:0x0/x/photo/2022/06/30/692203986.jpg';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print('makan');
    final future = useMemoized(() => NetworkAssetBundle(Uri.parse(uri))
        .load(uri)
        .then((value) => value.buffer.asUint8List())
        .then((value) => Image.memory(value)));

    final snapshot = useFuture(future);
    return Scaffold(
      appBar: AppBar(
        title: Text('makan'),
      ),
      body: Column(
        children: [snapshot.data].compactMap().toList(),
      ),
    );
  }
}

extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([
    E? Function(T?)? transform,
  ]) =>
      map(
        transform ?? (e) => e,
      ).where((e) => e != null).cast();
}

void coba() {
  final data = [1, 2, 3, null, 4];
  final new_data = data.compactMap();
}
