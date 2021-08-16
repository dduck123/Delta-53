
final String tableEmployee ='employee';

class EmployeeFields{
  static final List<String> values = [
    id, email, password, name
  ];
  static final String id = '_id';
  static final String email = '_email';
  static final String password = '_password';
  static final String name = '_name';

}

class Employee {
  final int? id;
  final String email;
  final String password;
  final String name;


  const Employee({
    required this.id,
    required this.email,
    required this.password,
    required this.name
  });

  Employee copy({
    int? id,
    String? email,
    String? password,
    String? name

  }) =>
      Employee(
          id: id ?? this.id,
          email: email ?? this.email,
          password: password ?? this.password,
          name: name ?? this.name
      );

  static Employee fromJson(Map<String, Object?> json) => Employee(
    id: json[EmployeeFields.id] as int?,
    email: json[EmployeeFields.email] as String,
    password: json[EmployeeFields.password] as String,
    name: json[EmployeeFields.name] as String,

  );

  Map<String, Object?> toJson() => {
    EmployeeFields.id: id,
    EmployeeFields.email: email,
    EmployeeFields.password: password,
    EmployeeFields.name: name,
  };

}

