import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laboratorio 11',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laboratorio 11'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MaterialExampleScreen(),
                  ),
                );
              },
              child: const Text('Ir a Ejemplo de Material'),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              color: CupertinoColors.activeBlue,
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const CupertinoExampleScreen(),
                  ),
                );
              },
              child: const Text('Ir a Ejemplo de Cupertino'),
            ),
          ],
        ),
      ),
    );
  }
}

class MaterialExampleScreen extends StatefulWidget {
  const MaterialExampleScreen({super.key});

  @override
  State<MaterialExampleScreen> createState() => _MaterialExampleScreenState();
}

class _MaterialExampleScreenState extends State<MaterialExampleScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool switchValue = false;

  Future<void> _selectDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alerta'),
          content: const Text('¿Quieres continuar con esta acción?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laboratorio 11 - Ejemplo de Material'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _selectDate,
              child: Text(
                selectedDate == null
                    ? 'Seleccionar Fecha'
                    : 'Fecha: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectTime,
              child: Text(
                selectedTime == null
                    ? 'Seleccionar Hora'
                    : 'Hora: ${selectedTime!.format(context)}',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Switch:'),
                Switch(
                  value: switchValue,
                  onChanged: (bool value) {
                    setState(() {
                      switchValue = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showAlertDialog,
              child: const Text('Mostrar Alerta'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Regresar al Inicio'),
            ),
          ],
        ),
      ),
    );
  }
}

class CupertinoExampleScreen extends StatefulWidget {
  const CupertinoExampleScreen({super.key});

  @override
  State<CupertinoExampleScreen> createState() =>
      _CupertinoExampleScreenState();
}

class _CupertinoExampleScreenState extends State<CupertinoExampleScreen> {
  DateTime date = DateTime.now();
  Duration timer = const Duration();
  bool switchValue = false;

  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 200,
        padding: const EdgeInsets.only(top: 6.0),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: date,
            onDateTimeChanged: (DateTime newDate) {
              setState(() => date = newDate);
            },
          ),
        ),
      ),
    );
  }

  void _showTimerPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 200,
        padding: const EdgeInsets.only(top: 6.0),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoTimerPicker(
            initialTimerDuration: timer,
            onTimerDurationChanged: (Duration newTimer) {
              setState(() => timer = newTimer);
            },
          ),
        ),
      ),
    );
  }

  void _showImagePickerDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Agregar Imagen'),
        content: const Text('Selecciona una opción:'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Abrir Cámara'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: const Text('Seleccionar de Galería'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Aceptar'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Laboratorio 11 - Ejemplo de Cupertino'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Fecha seleccionada: ${date.day}-${date.month}-${date.year}',
              style: const TextStyle(fontSize: 18),
            ),
            CupertinoButton(
              color: CupertinoColors.activeGreen,
              child: const Text('Seleccionar Fecha'),
              onPressed: _showDatePicker,
            ),
            const SizedBox(height: 20),
            Text(
              'Duración: ${timer.inHours}h ${timer.inMinutes % 60}m ${timer.inSeconds % 60}s',
              style: const TextStyle(fontSize: 18),
            ),
            CupertinoButton(
              color: CupertinoColors.activeOrange,
              child: const Text('Seleccionar Temporizador'),
              onPressed: _showTimerPicker,
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              color: CupertinoColors.activeBlue,
              child: const Text('Agregar Imagen'),
              onPressed: _showImagePickerDialog,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Switch:'),
                CupertinoSwitch(
                  value: switchValue,
                  activeColor: const Color(0xFF34C759),
                  onChanged: (bool value) {
                    setState(() {
                      switchValue = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              color: CupertinoColors.systemRed,
              child: const Text('Mostrar Alerta'),
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: const Text('Alerta'),
                    content: const Text('¿Deseas continuar con esta acción?'),
                    actions: [
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        child: const Text('Cancelar'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        child: const Text('Aceptar'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              color: CupertinoColors.activeBlue,
              child: const Text('Regresar al Inicio'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
