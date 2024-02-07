import 'package:flutter/material.dart';
import 'package:flutter_floor/data/dao.dart';
import 'package:flutter_floor/data/database.dart';
import 'package:flutter_floor/data/entity/employee.dart';
import 'package:faker/faker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('employee_database.db').build();
  final dao = database.employeeDao;
  runApp(MyApp(dao: dao));
}

class MyApp extends StatelessWidget {
  final EmployeeDao? dao;
  const MyApp({super.key, required this.dao});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Floor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainScreen(dao: dao),
    );
  }
}

class MainScreen extends StatefulWidget {
  final EmployeeDao? dao;
  const MainScreen({Key? key, required this.dao}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Floor Database"),
        actions: [
          IconButton(
            onPressed: () async {
              final employee = Employee(
                  firstName: Faker().person.firstName(),
                  lastName: Faker().person.lastName(),
                  email: Faker().internet.email());
              await widget.dao!.insertEmployee(employee);
              showSnackBar(scaffoldKey.currentState, 'Employee Added');
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async {
              widget.dao!.deleteAllEmployee();
              setState(() {
                showSnackBar(scaffoldKey.currentState, 'All Employee Deleted');
              });
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: widget.dao!.getAllEmployee(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              var listEmployee = snapshot.data as List<Employee>;
              return Container(
                color: Colors.black12,
                padding: const EdgeInsets.all(0),
                child: ListView.builder(
                  itemCount: listEmployee != null ? listEmployee.length : 0,
                  itemBuilder: (context, index) {
                    return Slidable(
                      startActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) async {
                              final deletedEmployee = listEmployee[index];
                              await widget.dao!.deleteEmployee(deletedEmployee);
                              showSnackBar(
                                  scaffoldKey.currentState, 'Employee Deleted');
                            },
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            onPressed: (context) async {
                              final updatedEmployee = listEmployee[index];
                              updatedEmployee.firstName =
                                  Faker().person.firstName();
                              updatedEmployee.lastName =
                                  Faker().person.lastName();
                              updatedEmployee.email = Faker().internet.email();
                              await widget.dao!.updateEmployee(updatedEmployee);
                              showSnackBar(
                                  scaffoldKey.currentState, 'Employee Updated');
                            },
                            backgroundColor: Colors.greenAccent,
                            foregroundColor: Colors.white,
                            icon: Icons.update,
                            label: 'Update',
                          )
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.only(left: 16),
                        tileColor: Colors.black12,
                        title: Text(
                          '${listEmployee[index].firstName} ${listEmployee[index].lastName}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          '${listEmployee[index].email}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

void showSnackBar(ScaffoldState? currentState, String s) {
  if (currentState != null) {
    ScaffoldMessenger.of(currentState.context).showSnackBar(
      SnackBar(
        content: Text(s),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
