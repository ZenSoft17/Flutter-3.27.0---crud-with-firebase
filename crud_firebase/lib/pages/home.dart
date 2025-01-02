import 'package:flutter/material.dart';
import 'package:crud_firebase/servicies/firebase_servicies.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crud Test Firebase',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[900],
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Lógica para búsqueda si es necesario
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Lógica para notificaciones si es necesario
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: getPeople(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  var person = snapshot.data?[index];
                  String id = person['id'];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    shadowColor: Colors.black.withOpacity(0.2),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 18.0),
                      leading: Icon(Icons.person, color: Colors.blue[900]),
                      title: Text(
                        '${person['name']} ${person['lastname']}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[800],
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          'ID: $id',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue[800]),
                            onPressed: () {
                              Navigator.pushNamed(context, '/edit', arguments: person);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red[600]),
                            onPressed: () {
                              deletePerson(id.toString(), context).then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Persona eliminada correctamente'),
                                  ),
                                );
                                setState(() {});
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Colors.blue[900],
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
