import 'package:bmi_app/splash_screen.dart';
import 'package:flutter/material.dart';


void main() {

  runApp(const MyApp());
  // whenever your initialization is completed, remove the splash screen:

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
          bodySmall: TextStyle(fontSize: 14, color: Colors.black87),
          titleLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.deepPurple),
        ),
      ),
      home:const SplashScreen(),
      // const MyHomePage(title: 'BMI Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();

  var result = "";
  var bgcolor = Colors.deepPurple.shade200;

  @override
  void initState() {
    super.initState();

    // Clear the output whenever any of the text fields are changed
    wtController.addListener(_clearResult);
    ftController.addListener(_clearResult);
    inController.addListener(_clearResult);
  }

  void _clearResult() {
    setState(() {
      result = "";
      bgcolor = Colors.deepPurple.shade200; // Reset background color if any field is changed
    });
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: bgcolor,
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Calculate Your BMI',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: wtController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your weight (in Kgs)',
                      prefixIcon: Icon(Icons.line_weight),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: ftController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your height (in feet)',
                      prefixIcon: Icon(Icons.height),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: inController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your height (in inch)',
                      prefixIcon: Icon(Icons.height),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _hideKeyboard();  // Hide the keyboard when the button is pressed

                      var wt = wtController.text.trim();
                      var ft = ftController.text.trim();
                      var inch = inController.text.trim();

                      if (wt.isNotEmpty && ft.isNotEmpty && inch.isNotEmpty) {
                        // BMI calculation
                        var iwt = int.parse(wt);
                        var iFt = int.parse(ft);
                        var iInch = int.parse(inch);

                        var tInch = (iFt * 12) + iInch;
                        var tCm = tInch * 2.54;
                        var tM = tCm / 100;
                        var bmi = iwt / (tM * tM);

                        var msg = '';
                        if (bmi > 25) {
                          msg = 'You are overweight!';
                          bgcolor = Colors.orange.shade200;
                        } else if (bmi < 18) {
                          msg = 'You are underweight!';
                          bgcolor = Colors.red.shade300;
                        } else {
                          msg = 'You are healthy!';
                          bgcolor = Colors.green.shade200;
                        }

                        setState(() {
                          result = '$msg\nYour BMI is: ${bmi.toStringAsFixed(2)}';
                        });
                      } else {
                        setState(() {
                          result = 'Please fill all the required fields!';
                          bgcolor = Colors.deepPurple.shade200; // Revert to normal background color
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Calculate'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    result,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
