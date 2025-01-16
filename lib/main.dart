import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_jokes/screens/home.dart';
import 'package:random_jokes/screens/details.dart';
import 'package:random_jokes/screens/random_joke.dart';
import 'package:random_jokes/provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.data}");

  // Show notification manually
  await _showNotification(message);
}

Future<void> _showNotification(RemoteMessage message) async {
  // Check if the notification is empty
  if ((message.notification == null ||
      (message.notification?.title == null && message.notification?.body == null)) &&
      message.data.isEmpty) {
    return; // Skip empty notifications
  }

  // Extract title and body from notification or data fields
  final notificationTitle = message.notification?.title ?? message.data['title'] ?? 'No Title';
  final notificationBody = message.notification?.body ?? message.data['body'] ?? 'No Body';

  const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    'random_jokes_channel',
    'Random Jokes Channel',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  // Use a unique ID for each notification to avoid duplicates
  final notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  await flutterLocalNotificationsPlugin.show(
    notificationId,
    notificationTitle,
    notificationBody,
    notificationDetails,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Firebase Messaging Initialization
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  String? token = await messaging.getToken();
  print('FCM Token: $token');

  // Request permissions for notifications
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  // Set up notification channel for Android
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'random_jokes_channel',
    'Random Jokes Channel',
    importance: Importance.max,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Initialize Flutter Local Notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  // Handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received a foreground message: ${message.data}');
    // Show notification only if the app is in the foreground (no need for background handler)
    if (message.notification != null) {
      _showNotification(message);
    }
  });

  // Handle background and terminated notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/details": (context) => const Details(),
        "/random-joke": (context) => const RandomJokeScreen(),
      },
    );
  }
}
