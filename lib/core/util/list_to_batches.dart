abstract class ListToBatches {
  listToBatches({required int batchSize, required List list});
}

class ListToBatchesImpl implements ListToBatches {
  @override
  listToBatches({required int batchSize, required List list}) {
    final batches = [];
    for (int i = 0; i < list.length; i += batchSize) {
      int end = (i + batchSize < list.length) ? i + batchSize : list.length;
      batches.add(list.sublist(i, end));
    }
    return batches;
  }
}
