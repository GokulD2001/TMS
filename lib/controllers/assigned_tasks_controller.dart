import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/task_model.dart';

class AssignedTaskController extends GetxController {
  final String userId;
  AssignedTaskController({required this.userId});

  final RxList<AssignedTaskModel> tasks = <AssignedTaskModel>[].obs;
  final RxMap<String, String> userCache = <String, String>{}.obs;
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      isLoading.value = true;
      error.value = '';
      final snapshot =
          await FirebaseFirestore.instance
              .collection('tasks')
              .where('assigned_to', isEqualTo: userId)
              .get();

      tasks.value =
          snapshot.docs
              .map((doc) => AssignedTaskModel.fromMap(doc.data()))
              .toList();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> getUserName(String userId) async {
    if (userCache.containsKey(userId)) return userCache[userId]!;

    final doc =
        await FirebaseFirestore.instance
            .collection('employees')
            .doc(userId)
            .get();
    final name = doc.data()?['name'] ?? 'Unknown';
    userCache[userId] = name;
    return name;
  }
}
