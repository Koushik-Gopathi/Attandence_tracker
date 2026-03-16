import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AttendanceHomePage(),
    );
  }
}

class AttendanceHomePage extends StatefulWidget {
  const AttendanceHomePage({super.key});

  @override
  State<AttendanceHomePage> createState() => _AttendanceHomePageState();
}

class _AttendanceHomePageState extends State<AttendanceHomePage> {
  final List<String> subjects = [
    'DSA',
    'Probability',
    'System Security',
    'Machine Learning',
    'Multimedia'
  ];

  final List<String> students = [
    'Koushik',
    'Jaswanth',
    'Varshith',
    'Anand',
    'sarath'
  ];

  late Map<String, Map<String, String>> attendanceRecord;

  @override
  void initState() {
    super.initState();

    attendanceRecord = {};

    for (var subject in subjects) {
      attendanceRecord[subject] = {};
      for (var student in students) {
        attendanceRecord[subject]![student] = "Not Marked";
      }
    }
  }

  void markAttendance(String subject, String student, String status) {
    setState(() {
      attendanceRecord[subject]![student] = status;
    });
  }

  int getStudentTotalClasses(String student) {
    int count = 0;

    for (var subject in subjects) {
      if (attendanceRecord[subject]![student] != "Not Marked") {
        count++;
      }
    }

    return count;
  }

  int getStudentAttendedClasses(String student) {
    int count = 0;

    for (var subject in subjects) {
      if (attendanceRecord[subject]![student] == "Present") {
        count++;
      }
    }

    return count;
  }

  int getPresentCount(String subject) {
  int count = 0;

  for (var student in students) {
    if (attendanceRecord[subject]![student] == "Present") {
      count++;
    }
  }

  return count;
}

int getAbsentCount(String subject) {
  int count = 0;

  for (var student in students) {
    if (attendanceRecord[subject]![student] == "Absent") {
      count++;
    }
  }

  return count;
}

  Color getStatusColor(String status) {
    if (status == "Present") {
      return Colors.green;
    } else if (status == "Absent") {
      return Colors.red;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance Tracker"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: subjects.length,
        itemBuilder: (context, subjectIndex) {
          String subject = subjects[subjectIndex];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 15),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Present: ${getPresentCount(subject)}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Absent: ${getAbsentCount(subject)}",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: students.map((student) {
                      String status = attendanceRecord[subject]![student]!;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// student name
                            Text(
                              student,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            /// buttons row
                            Row(
                              children: [

                                /// present button
                                ElevatedButton(
                                  onPressed: () {
                                    markAttendance(
                                        subject, student, "Present");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                  ),
                                  child: const Text(
                                    "Present",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),

                                const SizedBox(width: 8),

                                /// absent button
                                ElevatedButton(
                                  onPressed: () {
                                    markAttendance(
                                        subject, student, "Absent");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                  ),
                                  child: const Text(
                                    "Absent",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                /// status
                                Text(
                                  "Status: $status",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: getStatusColor(status),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 6),

                            /// student attendance summary
                            Text(
                              "Attended: ${getStudentAttendedClasses(student)} / ${getStudentTotalClasses(student)}",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}