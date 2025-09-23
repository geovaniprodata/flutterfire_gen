// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'read_status.dart';

// **************************************************************************
// Generator: FlutterFireGen
// **************************************************************************

class ReadReadStatus {
  const ReadReadStatus({
    required this.lastReadAt,
    required this.readStatusId,
    required this.path,
    required this.readStatusReference,
  });

  final DateTime? lastReadAt;

  final String readStatusId;

  final String path;

  final DocumentReference<ReadReadStatus> readStatusReference;

  factory ReadReadStatus.fromJson(Map<String, dynamic> json) {
    final extendedJson = <String, dynamic>{
      ...json,
    };
    return ReadReadStatus(
      lastReadAt: (extendedJson['lastReadAt'] as Timestamp?)?.toDate(),
      readStatusId: extendedJson['readStatusId'] as String,
      path: extendedJson['path'] as String,
      readStatusReference: extendedJson['readStatusReference']
          as DocumentReference<ReadReadStatus>,
    );
  }

  factory ReadReadStatus.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return ReadReadStatus.fromJson(<String, dynamic>{
      ...data,
      'readStatusId': ds.id,
      'path': ds.reference.path,
      'readStatusReference': ds.reference.parent.doc(ds.id).withConverter(
            fromFirestore: (ds, _) => ReadReadStatus.fromDocumentSnapshot(ds),
            toFirestore: (obj, _) => throw UnimplementedError(),
          ),
    });
  }

  ReadReadStatus copyWith({
    DateTime? lastReadAt,
    String? readStatusId,
    String? path,
    DocumentReference<ReadReadStatus>? readStatusReference,
  }) {
    return ReadReadStatus(
      lastReadAt: lastReadAt ?? this.lastReadAt,
      readStatusId: readStatusId ?? this.readStatusId,
      path: path ?? this.path,
      readStatusReference: readStatusReference ?? this.readStatusReference,
    );
  }
}

/// Represents the data structure for creating a new readStatus document in Cloud Firestore.
///
/// This class is used to define the necessary data for creating a new readStatus document.
/// `@alwaysUseFieldValueServerTimestampWhenCreating` annotated fields are
/// automatically set to the server's timestamp.
class CreateReadStatus {
  const CreateReadStatus({
    this.lastReadAt,
  });

  final DateTime? lastReadAt;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'lastReadAt': lastReadAt == null ? null : Timestamp.fromDate(lastReadAt!),
    };
    final jsonPostProcessors = <({String key, dynamic value})>[];
    return {
      ...json,
      ...Map.fromEntries(jsonPostProcessors
          .map((record) => MapEntry(record.key, record.value))),
    };
  }
}

/// Represents the data structure for updating a readStatus document in Cloud Firestore.
///
/// This class provides a way to specify which fields of a readStatus document should
/// be updated. Fields set to `null` will not be updated. It also automatically
/// sets the `@alwaysUseFieldValueServerTimestampWhenUpdating` annotated fields
/// to the server's timestamp upon updating.
class UpdateReadStatus {
  const UpdateReadStatus({
    this.lastReadAt,
  });

  final DateTime? lastReadAt;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      if (lastReadAt != null)
        'lastReadAt':
            lastReadAt == null ? null : Timestamp.fromDate(lastReadAt!),
    };
    final jsonPostProcessors = <({String key, dynamic value})>[];
    return {
      ...json,
      ...Map.fromEntries(jsonPostProcessors
          .map((record) => MapEntry(record.key, record.value))),
    };
  }
}

/// Represents the data structure for deleting a readStatus document in Cloud Firestore.
class DeleteReadStatus {}

/// Reference to the 'readStatuses' collection with a converter for [ReadReadStatus].
/// This allows for type-safe read operations from Firestore, converting
/// Firestore documents to [ReadReadStatus] objects.
CollectionReference<ReadReadStatus> readReadStatusesCollectionReference({
  required String chatRoomId,
}) =>
    FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('readStatuses')
        .withConverter<ReadReadStatus>(
          fromFirestore: (ds, _) => ReadReadStatus.fromDocumentSnapshot(ds),
          toFirestore: (_, __) => throw UnimplementedError(),
        );

/// Creates a [DocumentReference] for a specific ReadStatus document.
DocumentReference<ReadReadStatus> readReadStatusDocumentReference({
  required String chatRoomId,
  required String readStatusId,
}) =>
    readReadStatusesCollectionReference(
      chatRoomId: chatRoomId,
    ).doc(readStatusId);

/// Reference to the 'readStatuses' collection with a converter for [CreateReadStatus].
/// This enables type-safe create operations in Firestore, converting
/// [CreateReadStatus] objects to Firestore document data.
CollectionReference<CreateReadStatus> createReadStatusesCollectionReference({
  required String chatRoomId,
}) =>
    FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('readStatuses')
        .withConverter<CreateReadStatus>(
          fromFirestore: (_, __) => throw UnimplementedError(),
          toFirestore: (obj, _) => obj.toJson(),
        );

/// Creates a [DocumentReference] for a specific ReadStatus document.
DocumentReference<CreateReadStatus> createReadStatusDocumentReference({
  required String chatRoomId,
  required String readStatusId,
}) =>
    createReadStatusesCollectionReference(
      chatRoomId: chatRoomId,
    ).doc(readStatusId);

/// Reference to the 'readStatuses' collection with a converter for [UpdateReadStatus].
/// This allows for type-safe update operations in Firestore, converting
/// [UpdateReadStatus] objects to Firestore document data.
CollectionReference<UpdateReadStatus> updateReadStatusesCollectionReference({
  required String chatRoomId,
}) =>
    FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('readStatuses')
        .withConverter<UpdateReadStatus>(
          fromFirestore: (_, __) => throw UnimplementedError(),
          toFirestore: (obj, _) => obj.toJson(),
        );

/// Creates a [DocumentReference] for a specific ReadStatus document.
DocumentReference<UpdateReadStatus> updateReadStatusDocumentReference({
  required String chatRoomId,
  required String readStatusId,
}) =>
    updateReadStatusesCollectionReference(
      chatRoomId: chatRoomId,
    ).doc(readStatusId);

/// Reference to the 'readStatuses' collection with a converter for [DeleteReadStatus].
/// This reference is used specifically for delete operations and does not
/// support reading or writing data to Firestore.
CollectionReference<DeleteReadStatus> deleteReadStatusesCollectionReference({
  required String chatRoomId,
}) =>
    FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('readStatuses')
        .withConverter<DeleteReadStatus>(
          fromFirestore: (_, __) => throw UnimplementedError(),
          toFirestore: (_, __) => throw UnimplementedError(),
        );

/// Creates a [DocumentReference] for a specific ReadStatus document.
DocumentReference<DeleteReadStatus> deleteReadStatusDocumentReference({
  required String chatRoomId,
  required String readStatusId,
}) =>
    deleteReadStatusesCollectionReference(
      chatRoomId: chatRoomId,
    ).doc(readStatusId);

/// Reference to the 'readStatuses' collection group with a converter for [ReadReadStatus].
/// This allows for type-safe read operations from Firestore, converting
/// Firestore documents from various paths in the 'readStatuses' collection group
/// into [ReadReadStatus] objects. It facilitates unified handling of 'readStatuses' documents
/// scattered across different locations in Firestore, ensuring consistent
/// data structure and manipulation.
final readReadStatusesCollectionGroupReference = FirebaseFirestore.instance
    .collectionGroup('readStatuses')
    .withConverter<ReadReadStatus>(
      fromFirestore: (ds, _) => ReadReadStatus.fromDocumentSnapshot(ds),
      toFirestore: (_, __) => throw UnimplementedError(),
    );

/// A sealed class that serves as a base for representing batch write operations in Firestore.
///
/// This class is the abstract base for subclasses that define specific types
/// of batch operations, such as creating, updating, or deleting readStatus documents.
/// It is used as a part of a type hierarchy for batch operations and is not
/// intended for direct instantiation. Instead, it establishes a common
/// interface and structure for various types of batch write operations.
///
/// The use of a sealed class here ensures type safety and polymorphic handling
/// of different batch operation types, while allowing specific implementations
/// in the subclasses.
sealed class BatchWriteReadStatus {
  const BatchWriteReadStatus();
}

/// Represents a batch operation for creating a readStatus document in Firestore.
///
/// This class is used as part of a batch write to Firestore, specifically for
/// creating new readStatus documents. It encapsulates the ID of the new readStatus document
/// and the data required for creation.
final class BatchCreateReadStatus extends BatchWriteReadStatus {
  const BatchCreateReadStatus({
    required this.chatRoomId,
    required this.readStatusId,
    required this.createReadStatus,
  });

  final String chatRoomId;

  final String readStatusId;

  final CreateReadStatus createReadStatus;
}

/// Represents a batch operation for updating an existing readStatus document in Firestore.
///
/// This class is utilized in a batch write process to Firestore, allowing for
/// the update of existing readStatus documents. It includes the readStatus document's ID
/// and the data for the update.
final class BatchUpdateReadStatus extends BatchWriteReadStatus {
  const BatchUpdateReadStatus({
    required this.chatRoomId,
    required this.readStatusId,
    required this.updateReadStatus,
  });

  final String chatRoomId;

  final String readStatusId;

  final UpdateReadStatus updateReadStatus;
}

// Represents a batch operation for deleting a readStatus document in Firestore.
///
/// Used in a batch write to Firestore for deleting a readStatus document. This class
/// only requires the ID of the readStatus document to be deleted, as no additional
/// data is needed for deletion.
final class BatchDeleteReadStatus extends BatchWriteReadStatus {
  const BatchDeleteReadStatus({
    required this.chatRoomId,
    required this.readStatusId,
  });

  final String chatRoomId;

  final String readStatusId;
}

/// A service class for managing readStatus documents in the database.
///
/// This class provides methods to perform CRUD (Create, Read, Update, Delete)
/// operations on readStatus documents, along with additional utilities like counting
/// documents, and calculating sum and average values for specific fields.
///
/// It includes methods to:
///
/// - Fetch single or multiple [ReadReadStatus] documents ([fetchDocuments], [fetchDocument]).
/// - Subscribe to real-time updates of single or multiple [ReadReadStatus] documents ([subscribeDocuments], [subscribeDocument]).
/// - Count documents based on queries ([count]).
/// - Calculate sum ([getSum]) and average ([getAverage]) of specific fields across documents.
/// - Add ([add]), set ([set]), update ([update]), and delete ([delete]) readStatus documents.
///
/// The class uses Firebase Firestore as the backend, assuming [ReadReadStatus],
/// [CreateReadStatus], [UpdateReadStatus] are models representing the data.
///
/// Usage:
///
/// - To fetch or subscribe to readStatus documents, or to count them, use the corresponding fetch, subscribe, and count methods.
/// - To modify readStatus documents, use the methods for adding, setting, updating, or deleting.
/// - To perform aggregate calculations like sum and average, use [getSum] and [getAverage].
///
/// This class abstracts the complexities of direct Firestore usage and provides
/// a straightforward API for readStatus document operations.
class ReadStatusQuery {
  /// Fetches a list of [ReadReadStatus] documents from Cloud Firestore.
  ///
  /// This method retrieves documents based on the provided query and sorts them
  /// if a [compare] function is given. You can customize the query by using the
  /// [queryBuilder] and control the source of the documents with [options].
  /// The [asCollectionGroup] parameter determines whether to fetch documents
  /// from the 'readStatuses' collection directly (false) or as a collection group across
  /// different Firestore paths (true).
  ///
  /// Parameters:
  ///
  /// - [options] Optional [GetOptions] to define the source of the documents (server, cache).
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [compare] Optional function to sort the ReadReadStatus documents.
  /// - [asCollectionGroup] Fetch the 'readStatuses' as a collection group if true.
  ///
  /// Returns a list of [ReadReadStatus] documents.
  Future<List<ReadReadStatus>> fetchDocuments({
    required String chatRoomId,
    GetOptions? options,
    Query<ReadReadStatus>? Function(Query<ReadReadStatus> query)? queryBuilder,
    int Function(ReadReadStatus lhs, ReadReadStatus rhs)? compare,
    bool asCollectionGroup = false,
  }) async {
    Query<ReadReadStatus> query = asCollectionGroup
        ? readReadStatusesCollectionGroupReference
        : readReadStatusesCollectionReference(
            chatRoomId: chatRoomId,
          );
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final qs = await query.get(options);
    final result = qs.docs.map((qds) => qds.data()).toList();
    if (compare != null) {
      result.sort(compare);
    }
    return result;
  }

  /// Subscribes to a stream of [ReadReadStatus] documents from Cloud Firestore.
  ///
  /// This method returns a stream of [ReadReadStatus] documents, which updates in
  /// real-time based on the database changes. You can customize the query using
  /// [queryBuilder]. The documents can be sorted using the [compare] function.
  /// The [asCollectionGroup] parameter determines whether to query the 'readStatuses'
  /// collection directly (false) or as a collection group across different
  /// Firestore paths (true).
  ///
  /// Parameters:
  ///
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [compare] Optional function to sort the ReadReadStatus documents.
  /// - [includeMetadataChanges] Include metadata changes in the stream.
  /// - [excludePendingWrites] Exclude documents with pending writes from the stream.
  /// - [asCollectionGroup] Query the 'readStatuses' as a collection group if true.
  Stream<List<ReadReadStatus>> subscribeDocuments({
    required String chatRoomId,
    Query<ReadReadStatus>? Function(Query<ReadReadStatus> query)? queryBuilder,
    int Function(ReadReadStatus lhs, ReadReadStatus rhs)? compare,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
    bool asCollectionGroup = false,
  }) {
    Query<ReadReadStatus> query = asCollectionGroup
        ? readReadStatusesCollectionGroupReference
        : readReadStatusesCollectionReference(
            chatRoomId: chatRoomId,
          );
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    var streamQs =
        query.snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamQs = streamQs.where((qs) => !qs.metadata.hasPendingWrites);
    }
    return streamQs.map((qs) {
      final result = qs.docs.map((qds) => qds.data()).toList();
      if (compare != null) {
        result.sort(compare);
      }
      return result;
    });
  }

  /// Counts the number of readStatus documents in Cloud Firestore.
  ///
  /// This method returns the count of documents based on the provided query.
  /// You can customize the query by using the [queryBuilder].
  /// The [asCollectionGroup] parameter determines whether to count documents
  /// in the 'readStatuses' collection directly (false) or across various Firestore
  /// paths as a collection group (true). The [source] parameter allows you to
  /// specify whether to count documents from the server or the local cache.
  ///
  /// Parameters:
  ///
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [source] Source of the count, either from the server or local cache.
  /// - [asCollectionGroup] Count the 'readStatuses' as a collection group if true.
  ///
  /// Returns the count of documents as an integer.
  Future<int?> count({
    required String chatRoomId,
    Query<ReadReadStatus>? Function(Query<ReadReadStatus> query)? queryBuilder,
    AggregateSource source = AggregateSource.server,
    bool asCollectionGroup = false,
  }) async {
    Query<ReadReadStatus> query = asCollectionGroup
        ? readReadStatusesCollectionGroupReference
        : readReadStatusesCollectionReference(
            chatRoomId: chatRoomId,
          );
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final aggregateQuery = await query.count();
    final aggregateQs = await aggregateQuery.get(source: source);
    return aggregateQs.count;
  }

  /// Returns the sum of the values of the documents that match the query.
  ///
  /// This method returns the sum of the values of the documents that match the query.
  /// You can customize the query by using the [queryBuilder].
  /// The [asCollectionGroup] parameter determines whether to query the 'readStatuses'
  /// collection directly (false) or as a collection group across different
  /// Firestore paths (true).
  ///
  /// Parameters:
  ///
  /// - [field] The field to sum over.
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [asCollectionGroup] Query the 'readStatuses' as a collection group if true.
  ///
  /// Returns the sum of the values of the documents that match the query.
  Future<double?> getSum({
    required String field,
    required String chatRoomId,
    Query<ReadReadStatus>? Function(Query<ReadReadStatus> query)? queryBuilder,
    AggregateSource source = AggregateSource.server,
    bool asCollectionGroup = false,
  }) async {
    Query<ReadReadStatus> query = asCollectionGroup
        ? readReadStatusesCollectionGroupReference
        : readReadStatusesCollectionReference(
            chatRoomId: chatRoomId,
          );
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final aggregateQuery = await query.aggregate(sum(field));
    final aggregateQs = await aggregateQuery.get(source: source);
    return aggregateQs.getSum(field);
  }

  /// Returns the average of the values of the documents that match the query.
  ///
  /// This method returns the average of the values of the documents that match the query.
  /// You can customize the query by using the [queryBuilder].
  /// The [asCollectionGroup] parameter determines whether to query the 'readStatuses'
  /// collection directly (false) or as a collection group across different
  /// Firestore paths (true).
  ///
  /// Parameters:
  ///
  /// - [field] The field to average over.
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [asCollectionGroup] Query the 'readStatuses' as a collection group if true.
  ///
  /// Returns the average of the values of the documents that match the query.
  Future<double?> getAverage({
    required String field,
    required String chatRoomId,
    Query<ReadReadStatus>? Function(Query<ReadReadStatus> query)? queryBuilder,
    AggregateSource source = AggregateSource.server,
    bool asCollectionGroup = false,
  }) async {
    Query<ReadReadStatus> query = asCollectionGroup
        ? readReadStatusesCollectionGroupReference
        : readReadStatusesCollectionReference(
            chatRoomId: chatRoomId,
          );
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final aggregateQuery = await query.aggregate(average(field));
    final aggregateQs = await aggregateQuery.get(source: source);
    return aggregateQs.getAverage(field);
  }

  /// Fetches a single [ReadReadStatus] document from Cloud Firestore by its ID.
  ///
  /// This method retrieves a specific document using the provided [readStatusId].
  /// You can control the data retrieval with [GetOptions].
  Future<ReadReadStatus?> fetchDocument({
    required String chatRoomId,
    required String readStatusId,
    GetOptions? options,
  }) async {
    final ds = await readReadStatusDocumentReference(
      chatRoomId: chatRoomId,
      readStatusId: readStatusId,
    ).get(options);
    return ds.data();
  }

  /// Subscribes to a stream of a single [ReadReadStatus] document from Cloud Firestore by its ID.
  ///
  /// This method returns a stream of a single [ReadReadStatus] document, which updates in
  /// real-time based on the database changes. You can control the data retrieval with [GetOptions].
  Stream<ReadReadStatus?> subscribeDocument({
    required String chatRoomId,
    required String readStatusId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    var streamDs = readReadStatusDocumentReference(
      chatRoomId: chatRoomId,
      readStatusId: readStatusId,
    ).snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }

  /// Adds a readStatus document to Cloud Firestore.
  ///
  /// This method creates a new document in Cloud Firestore using the provided
  /// [createReadStatus] data.
  Future<DocumentReference<CreateReadStatus>> add({
    required String chatRoomId,
    required CreateReadStatus createReadStatus,
  }) =>
      createReadStatusesCollectionReference(
        chatRoomId: chatRoomId,
      ).add(createReadStatus);

  /// Sets a readStatus document to Cloud Firestore.
  ///
  /// This method creates a new document in Cloud Firestore using the provided
  /// [createReadStatus] data.
  Future<void> set({
    required String chatRoomId,
    required String readStatusId,
    required CreateReadStatus createReadStatus,
    SetOptions? options,
  }) =>
      createReadStatusDocumentReference(
        chatRoomId: chatRoomId,
        readStatusId: readStatusId,
      ).set(createReadStatus, options);

  /// Updates a readStatus document in Cloud Firestore.
  ///
  /// This method partially updates the document identified by [readStatusId] with the
  /// provided [updateReadStatus] data.
  /// The update is based on the structure defined in `UpdateReadStatus.toJson()`.
  Future<void> update({
    required String chatRoomId,
    required String readStatusId,
    required UpdateReadStatus updateReadStatus,
  }) =>
      updateReadStatusDocumentReference(
        chatRoomId: chatRoomId,
        readStatusId: readStatusId,
      ).update(updateReadStatus.toJson());

  /// Deletes a readStatus document from Cloud Firestore.
  ///
  /// This method deletes an existing document identified by [readStatusId].
  Future<void> delete({
    required String chatRoomId,
    required String readStatusId,
  }) =>
      deleteReadStatusDocumentReference(
        chatRoomId: chatRoomId,
        readStatusId: readStatusId,
      ).delete();

  /// Performs a batch write operation in Firestore using a list of [BatchWriteReadStatus] tasks.
  ///
  /// This function allows for executing multiple Firestore write operations (create, update, delete)
  /// as a single batch. This ensures that all operations either complete successfully or fail
  /// without applying any changes, providing atomicity.
  ///
  /// Parameters:
  ///
  /// - [batchWriteTasks] A list of [BatchWriteReadStatus] objects, each representing a specific
  /// write operation (create, update, or delete) for ReadStatus documents.
  ///
  /// The function iterates over each task in [batchWriteTasks] and performs the corresponding
  /// Firestore operation. This includes:
  ///
  /// - Creating new documents for tasks of type [BatchCreateReadStatus].
  /// - Updating existing documents for tasks of type [BatchUpdateReadStatus].
  /// - Deleting documents for tasks of type [BatchDeleteReadStatus].
  ///
  /// Returns a `Future<void>` that completes when the batch operation is committed successfully.
  ///
  /// Throws:
  ///
  /// - Firestore exceptions if the batch commit fails or if there are issues with the individual
  /// operations within the batch.
  Future<void> batchWrite(List<BatchWriteReadStatus> batchWriteTasks) {
    final batch = FirebaseFirestore.instance.batch();
    for (final task in batchWriteTasks) {
      switch (task) {
        case BatchCreateReadStatus(
            chatRoomId: final chatRoomId,
            readStatusId: final readStatusId,
            createReadStatus: final createReadStatus,
          ):
          batch.set(
            createReadStatusDocumentReference(
              chatRoomId: chatRoomId,
              readStatusId: readStatusId,
            ),
            createReadStatus,
          );
        case BatchUpdateReadStatus(
            chatRoomId: final chatRoomId,
            readStatusId: final readStatusId,
            updateReadStatus: final updateReadStatus,
          ):
          batch.update(
            updateReadStatusDocumentReference(
              chatRoomId: chatRoomId,
              readStatusId: readStatusId,
            ),
            updateReadStatus.toJson(),
          );
        case BatchDeleteReadStatus(
            chatRoomId: final chatRoomId,
            readStatusId: final readStatusId
          ):
          batch.delete(deleteReadStatusDocumentReference(
            chatRoomId: chatRoomId,
            readStatusId: readStatusId,
          ));
      }
    }
    return batch.commit();
  }
}
