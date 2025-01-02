import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getPeople() async {
  List people = [];

  CollectionReference collectionReferencePeople = db.collection('people');

  QuerySnapshot queryPeople = await collectionReferencePeople.get();

  queryPeople.docs.forEach((doc) {
    var personData = doc.data() as Map<String, dynamic>;
    personData['id'] = doc.id;
    people.add(personData);
  });

  return people;
}

Future<void> addPerson(
    String name, String lastname, BuildContext context) async {
  try {
    await db.collection('people').add({
      'name': name,
      'lastname': lastname,
    });

    print("Datos agregados correctamente.");
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  } catch (e) {
    print("Error al agregar los datos: $e");
  }
}

Future<void> deletePerson(String personId, BuildContext context) async {
  try {
    print("id de la persona : $personId");
    await db.collection('people').doc(personId).delete();
    print("Datos eliminados correctamente.");
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  } catch (e) {
    print("Error al eliminar los datos: $e");
  }
}

Future<void> editPerson(
    String id, String name, String lastname, BuildContext context) async {
  try {
    await db.collection('people').doc(id).update({
      'name': name,
      'lastname': lastname,
    });

    print("Datos actualizados correctamente.");
    // Regresar a la página principal después de la edición
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  } catch (e) {
    print("Error al actualizar los datos: $e");
  }
}
