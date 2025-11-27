import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/core/firebase/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTaskToFirestore(Task task) {
    var taskCollection = getTaskCollection(); // collection
    var docRef = taskCollection.doc(); // document
    task.id = docRef.id; //auto id
    return docRef.set(task);
  }
}
