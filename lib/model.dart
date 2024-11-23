// class Task {
//   final String id;
//   final String title;
//   final String notes;
//   final DateTime dueDate;
//   final String priority;
//   final bool isComplete;

//   Task({
//     required this.id,
//     required this.title,
//     required this.notes,
//     required this.dueDate,
//     this.priority = 'None',
//     this.isComplete = false,
//   });

//   factory Task.fromJson(Map<String, dynamic> json) {
//     return Task(
//       id: json['id'],
//       title: json['title'],
//       notes: json['notes'],
//       dueDate: DateTime.parse(json['dueDate']),
//       priority: json['priority'],
//       isComplete: json['isComplete'],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'title': title,
//         'notes': notes,
//         'dueDate': dueDate.toIso8601String(),
//         'priority': priority,
//         'isComplete': isComplete,
//       };
// }

class Task {
  final String? id;
  final String title;
  final String notes;
  final DateTime dueDate;
  final String priority;
  final bool isComplete;

  Task({
    this.id,
    required this.title,
    required this.notes,
    required this.dueDate,
    required this.priority,
    this.isComplete = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'], // Matches the API-generated ID
      title: json['title'],
      notes: json['notes'],
      dueDate: DateTime.parse(json['dueDate']),
      priority: json['priority'],
      isComplete: json['isComplete'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'notes': notes,
      'dueDate': dueDate.toIso8601String(),
      'priority': priority,
      'isComplete': isComplete,
    };
  }

  Task copyWith({
    String? id,
    String? title,
    String? notes,
    DateTime? dueDate,
    String? priority,
    bool? isComplete,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
