// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user_post_like_task.dart';

// **************************************************************************
// Generator: FlutterFireGen
// **************************************************************************

class ReadAppUserPostLikeTask {
  const ReadAppUserPostLikeTask({
    required this.appUserId,
    required this.appUserPostId,
    required this.appUserPostLikeId,
    required this.appUserPostLikeTaskId,
    required this.path,
    required this.appUserPostLikeTaskReference,
  });

  final String appUserId;

  final String appUserPostId;

  final String appUserPostLikeId;

  final String appUserPostLikeTaskId;

  final String path;

  final DocumentReference<ReadAppUserPostLikeTask> appUserPostLikeTaskReference;

  factory ReadAppUserPostLikeTask.fromJson(Map<String, dynamic> json) {
    final extendedJson = <String, dynamic>{
      ...json,
    };
    return ReadAppUserPostLikeTask(
      appUserId: extendedJson['appUserId'] as String,
      appUserPostId: extendedJson['appUserPostId'] as String,
      appUserPostLikeId: extendedJson['appUserPostLikeId'] as String,
      appUserPostLikeTaskId: extendedJson['appUserPostLikeTaskId'] as String,
      path: extendedJson['path'] as String,
      appUserPostLikeTaskReference: extendedJson['appUserPostLikeTaskReference']
          as DocumentReference<ReadAppUserPostLikeTask>,
    );
  }

  factory ReadAppUserPostLikeTask.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return ReadAppUserPostLikeTask.fromJson(<String, dynamic>{
      ...data,
      'appUserPostLikeTaskId': ds.id,
      'path': ds.reference.path,
      'appUserPostLikeTaskReference':
          ds.reference.parent.doc(ds.id).withConverter(
                fromFirestore: (ds, _) =>
                    ReadAppUserPostLikeTask.fromDocumentSnapshot(ds),
                toFirestore: (obj, _) => throw UnimplementedError(),
              ),
    });
  }

  ReadAppUserPostLikeTask copyWith({
    String? appUserId,
    String? appUserPostId,
    String? appUserPostLikeId,
    String? appUserPostLikeTaskId,
    String? path,
    DocumentReference<ReadAppUserPostLikeTask>? appUserPostLikeTaskReference,
  }) {
    return ReadAppUserPostLikeTask(
      appUserId: appUserId ?? this.appUserId,
      appUserPostId: appUserPostId ?? this.appUserPostId,
      appUserPostLikeId: appUserPostLikeId ?? this.appUserPostLikeId,
      appUserPostLikeTaskId:
          appUserPostLikeTaskId ?? this.appUserPostLikeTaskId,
      path: path ?? this.path,
      appUserPostLikeTaskReference:
          appUserPostLikeTaskReference ?? this.appUserPostLikeTaskReference,
    );
  }
}

/// Represents the data structure for creating a new appUserPostLikeTask document in Cloud Firestore.
///
/// This class is used to define the necessary data for creating a new appUserPostLikeTask document.
/// `@alwaysUseFieldValueServerTimestampWhenCreating` annotated fields are
/// automatically set to the server's timestamp.
class CreateAppUserPostLikeTask {
  const CreateAppUserPostLikeTask({
    required this.appUserId,
    required this.appUserPostId,
    required this.appUserPostLikeId,
  });

  final String appUserId;

  final String appUserPostId;

  final String appUserPostLikeId;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'appUserId': appUserId,
      'appUserPostId': appUserPostId,
      'appUserPostLikeId': appUserPostLikeId,
    };
    final jsonPostProcessors = <({String key, dynamic value})>[];
    return {
      ...json,
      ...Map.fromEntries(jsonPostProcessors
          .map((record) => MapEntry(record.key, record.value))),
    };
  }
}

/// Represents the data structure for updating a appUserPostLikeTask document in Cloud Firestore.
///
/// This class provides a way to specify which fields of a appUserPostLikeTask document should
/// be updated. Fields set to `null` will not be updated. It also automatically
/// sets the `@alwaysUseFieldValueServerTimestampWhenUpdating` annotated fields
/// to the server's timestamp upon updating.
class UpdateAppUserPostLikeTask {
  const UpdateAppUserPostLikeTask({
    this.appUserId,
    this.appUserPostId,
    this.appUserPostLikeId,
  });

  final String? appUserId;

  final String? appUserPostId;

  final String? appUserPostLikeId;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      if (appUserId != null) 'appUserId': appUserId,
      if (appUserPostId != null) 'appUserPostId': appUserPostId,
      if (appUserPostLikeId != null) 'appUserPostLikeId': appUserPostLikeId,
    };
    final jsonPostProcessors = <({String key, dynamic value})>[];
    return {
      ...json,
      ...Map.fromEntries(jsonPostProcessors
          .map((record) => MapEntry(record.key, record.value))),
    };
  }
}

/// Represents the data structure for deleting a appUserPostLikeTask document in Cloud Firestore.
class DeleteAppUserPostLikeTask {}

/// Reference to the 'appUserPostLikeTasks' collection with a converter for [ReadAppUserPostLikeTask].
/// This allows for type-safe read operations from Firestore, converting
/// Firestore documents to [ReadAppUserPostLikeTask] objects.
final readAppUserPostLikeTasksCollectionReference = FirebaseFirestore.instance
    .collection('appUserPostLikeTasks')
    .withConverter<ReadAppUserPostLikeTask>(
      fromFirestore: (ds, _) =>
          ReadAppUserPostLikeTask.fromDocumentSnapshot(ds),
      toFirestore: (_, __) => throw UnimplementedError(),
    );

/// Creates a [DocumentReference] for a specific AppUserPostLikeTask document.
DocumentReference<ReadAppUserPostLikeTask>
    readAppUserPostLikeTaskDocumentReference({
  required String appUserPostLikeTaskId,
}) =>
        readAppUserPostLikeTasksCollectionReference.doc(appUserPostLikeTaskId);

/// Reference to the 'appUserPostLikeTasks' collection with a converter for [CreateAppUserPostLikeTask].
/// This enables type-safe create operations in Firestore, converting
/// [CreateAppUserPostLikeTask] objects to Firestore document data.
final createAppUserPostLikeTasksCollectionReference = FirebaseFirestore.instance
    .collection('appUserPostLikeTasks')
    .withConverter<CreateAppUserPostLikeTask>(
      fromFirestore: (_, __) => throw UnimplementedError(),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// Creates a [DocumentReference] for a specific AppUserPostLikeTask document.
DocumentReference<CreateAppUserPostLikeTask>
    createAppUserPostLikeTaskDocumentReference({
  required String appUserPostLikeTaskId,
}) =>
        createAppUserPostLikeTasksCollectionReference
            .doc(appUserPostLikeTaskId);

/// Reference to the 'appUserPostLikeTasks' collection with a converter for [UpdateAppUserPostLikeTask].
/// This allows for type-safe update operations in Firestore, converting
/// [UpdateAppUserPostLikeTask] objects to Firestore document data.
final updateAppUserPostLikeTasksCollectionReference = FirebaseFirestore.instance
    .collection('appUserPostLikeTasks')
    .withConverter<UpdateAppUserPostLikeTask>(
      fromFirestore: (_, __) => throw UnimplementedError(),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// Creates a [DocumentReference] for a specific AppUserPostLikeTask document.
DocumentReference<UpdateAppUserPostLikeTask>
    updateAppUserPostLikeTaskDocumentReference({
  required String appUserPostLikeTaskId,
}) =>
        updateAppUserPostLikeTasksCollectionReference
            .doc(appUserPostLikeTaskId);

/// Reference to the 'appUserPostLikeTasks' collection with a converter for [DeleteAppUserPostLikeTask].
/// This reference is used specifically for delete operations and does not
/// support reading or writing data to Firestore.
final deleteAppUserPostLikeTasksCollectionReference = FirebaseFirestore.instance
    .collection('appUserPostLikeTasks')
    .withConverter<DeleteAppUserPostLikeTask>(
      fromFirestore: (_, __) => throw UnimplementedError(),
      toFirestore: (_, __) => throw UnimplementedError(),
    );

/// Creates a [DocumentReference] for a specific AppUserPostLikeTask document.
DocumentReference<DeleteAppUserPostLikeTask>
    deleteAppUserPostLikeTaskDocumentReference({
  required String appUserPostLikeTaskId,
}) =>
        deleteAppUserPostLikeTasksCollectionReference
            .doc(appUserPostLikeTaskId);

/// Reference to the 'appUserPostLikeTasks' collection group with a converter for [ReadAppUserPostLikeTask].
/// This allows for type-safe read operations from Firestore, converting
/// Firestore documents from various paths in the 'appUserPostLikeTasks' collection group
/// into [ReadAppUserPostLikeTask] objects. It facilitates unified handling of 'appUserPostLikeTasks' documents
/// scattered across different locations in Firestore, ensuring consistent
/// data structure and manipulation.
final readAppUserPostLikeTasksCollectionGroupReference = FirebaseFirestore
    .instance
    .collectionGroup('appUserPostLikeTasks')
    .withConverter<ReadAppUserPostLikeTask>(
      fromFirestore: (ds, _) =>
          ReadAppUserPostLikeTask.fromDocumentSnapshot(ds),
      toFirestore: (_, __) => throw UnimplementedError(),
    );

/// A sealed class that serves as a base for representing batch write operations in Firestore.
///
/// This class is the abstract base for subclasses that define specific types
/// of batch operations, such as creating, updating, or deleting appUserPostLikeTask documents.
/// It is used as a part of a type hierarchy for batch operations and is not
/// intended for direct instantiation. Instead, it establishes a common
/// interface and structure for various types of batch write operations.
///
/// The use of a sealed class here ensures type safety and polymorphic handling
/// of different batch operation types, while allowing specific implementations
/// in the subclasses.
sealed class BatchWriteAppUserPostLikeTask {
  const BatchWriteAppUserPostLikeTask();
}

/// Represents a batch operation for creating a appUserPostLikeTask document in Firestore.
///
/// This class is used as part of a batch write to Firestore, specifically for
/// creating new appUserPostLikeTask documents. It encapsulates the ID of the new appUserPostLikeTask document
/// and the data required for creation.
final class BatchCreateAppUserPostLikeTask
    extends BatchWriteAppUserPostLikeTask {
  const BatchCreateAppUserPostLikeTask({
    required this.appUserPostLikeTaskId,
    required this.createAppUserPostLikeTask,
  });

  final String appUserPostLikeTaskId;

  final CreateAppUserPostLikeTask createAppUserPostLikeTask;
}

/// Represents a batch operation for updating an existing appUserPostLikeTask document in Firestore.
///
/// This class is utilized in a batch write process to Firestore, allowing for
/// the update of existing appUserPostLikeTask documents. It includes the appUserPostLikeTask document's ID
/// and the data for the update.
final class BatchUpdateAppUserPostLikeTask
    extends BatchWriteAppUserPostLikeTask {
  const BatchUpdateAppUserPostLikeTask({
    required this.appUserPostLikeTaskId,
    required this.updateAppUserPostLikeTask,
  });

  final String appUserPostLikeTaskId;

  final UpdateAppUserPostLikeTask updateAppUserPostLikeTask;
}

// Represents a batch operation for deleting a appUserPostLikeTask document in Firestore.
///
/// Used in a batch write to Firestore for deleting a appUserPostLikeTask document. This class
/// only requires the ID of the appUserPostLikeTask document to be deleted, as no additional
/// data is needed for deletion.
final class BatchDeleteAppUserPostLikeTask
    extends BatchWriteAppUserPostLikeTask {
  const BatchDeleteAppUserPostLikeTask({
    required this.appUserPostLikeTaskId,
  });

  final String appUserPostLikeTaskId;
}

/// A service class for managing appUserPostLikeTask documents in the database.
///
/// This class provides methods to perform CRUD (Create, Read, Update, Delete)
/// operations on appUserPostLikeTask documents, along with additional utilities like counting
/// documents, and calculating sum and average values for specific fields.
///
/// It includes methods to:
///
/// - Fetch single or multiple [ReadAppUserPostLikeTask] documents ([fetchDocuments], [fetchDocument]).
/// - Subscribe to real-time updates of single or multiple [ReadAppUserPostLikeTask] documents ([subscribeDocuments], [subscribeDocument]).
/// - Count documents based on queries ([count]).
/// - Calculate sum ([getSum]) and average ([getAverage]) of specific fields across documents.
/// - Add ([add]), set ([set]), update ([update]), and delete ([delete]) appUserPostLikeTask documents.
///
/// The class uses Firebase Firestore as the backend, assuming [ReadAppUserPostLikeTask],
/// [CreateAppUserPostLikeTask], [UpdateAppUserPostLikeTask] are models representing the data.
///
/// Usage:
///
/// - To fetch or subscribe to appUserPostLikeTask documents, or to count them, use the corresponding fetch, subscribe, and count methods.
/// - To modify appUserPostLikeTask documents, use the methods for adding, setting, updating, or deleting.
/// - To perform aggregate calculations like sum and average, use [getSum] and [getAverage].
///
/// This class abstracts the complexities of direct Firestore usage and provides
/// a straightforward API for appUserPostLikeTask document operations.
class AppUserPostLikeTaskQuery {
  /// Fetches a list of [ReadAppUserPostLikeTask] documents from Cloud Firestore.
  ///
  /// This method retrieves documents based on the provided query and sorts them
  /// if a [compare] function is given. You can customize the query by using the
  /// [queryBuilder] and control the source of the documents with [options].
  /// The [asCollectionGroup] parameter determines whether to fetch documents
  /// from the 'appUserPostLikeTasks' collection directly (false) or as a collection group across
  /// different Firestore paths (true).
  ///
  /// Parameters:
  ///
  /// - [options] Optional [GetOptions] to define the source of the documents (server, cache).
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [compare] Optional function to sort the ReadAppUserPostLikeTask documents.
  /// - [asCollectionGroup] Fetch the 'appUserPostLikeTasks' as a collection group if true.
  ///
  /// Returns a list of [ReadAppUserPostLikeTask] documents.
  Future<List<ReadAppUserPostLikeTask>> fetchDocuments({
    GetOptions? options,
    Query<ReadAppUserPostLikeTask>? Function(
            Query<ReadAppUserPostLikeTask> query)?
        queryBuilder,
    int Function(ReadAppUserPostLikeTask lhs, ReadAppUserPostLikeTask rhs)?
        compare,
    bool asCollectionGroup = false,
  }) async {
    Query<ReadAppUserPostLikeTask> query = asCollectionGroup
        ? readAppUserPostLikeTasksCollectionGroupReference
        : readAppUserPostLikeTasksCollectionReference;
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

  /// Subscribes to a stream of [ReadAppUserPostLikeTask] documents from Cloud Firestore.
  ///
  /// This method returns a stream of [ReadAppUserPostLikeTask] documents, which updates in
  /// real-time based on the database changes. You can customize the query using
  /// [queryBuilder]. The documents can be sorted using the [compare] function.
  /// The [asCollectionGroup] parameter determines whether to query the 'appUserPostLikeTasks'
  /// collection directly (false) or as a collection group across different
  /// Firestore paths (true).
  ///
  /// Parameters:
  ///
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [compare] Optional function to sort the ReadAppUserPostLikeTask documents.
  /// - [includeMetadataChanges] Include metadata changes in the stream.
  /// - [excludePendingWrites] Exclude documents with pending writes from the stream.
  /// - [asCollectionGroup] Query the 'appUserPostLikeTasks' as a collection group if true.
  Stream<List<ReadAppUserPostLikeTask>> subscribeDocuments({
    Query<ReadAppUserPostLikeTask>? Function(
            Query<ReadAppUserPostLikeTask> query)?
        queryBuilder,
    int Function(ReadAppUserPostLikeTask lhs, ReadAppUserPostLikeTask rhs)?
        compare,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
    bool asCollectionGroup = false,
  }) {
    Query<ReadAppUserPostLikeTask> query = asCollectionGroup
        ? readAppUserPostLikeTasksCollectionGroupReference
        : readAppUserPostLikeTasksCollectionReference;
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

  /// Counts the number of appUserPostLikeTask documents in Cloud Firestore.
  ///
  /// This method returns the count of documents based on the provided query.
  /// You can customize the query by using the [queryBuilder].
  /// The [asCollectionGroup] parameter determines whether to count documents
  /// in the 'appUserPostLikeTasks' collection directly (false) or across various Firestore
  /// paths as a collection group (true). The [source] parameter allows you to
  /// specify whether to count documents from the server or the local cache.
  ///
  /// Parameters:
  ///
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [source] Source of the count, either from the server or local cache.
  /// - [asCollectionGroup] Count the 'appUserPostLikeTasks' as a collection group if true.
  ///
  /// Returns the count of documents as an integer.
  Future<int?> count({
    Query<ReadAppUserPostLikeTask>? Function(
            Query<ReadAppUserPostLikeTask> query)?
        queryBuilder,
    AggregateSource source = AggregateSource.server,
    bool asCollectionGroup = false,
  }) async {
    Query<ReadAppUserPostLikeTask> query = asCollectionGroup
        ? readAppUserPostLikeTasksCollectionGroupReference
        : readAppUserPostLikeTasksCollectionReference;
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
  /// The [asCollectionGroup] parameter determines whether to query the 'appUserPostLikeTasks'
  /// collection directly (false) or as a collection group across different
  /// Firestore paths (true).
  ///
  /// Parameters:
  ///
  /// - [field] The field to sum over.
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [asCollectionGroup] Query the 'appUserPostLikeTasks' as a collection group if true.
  ///
  /// Returns the sum of the values of the documents that match the query.
  Future<double?> getSum({
    required String field,
    Query<ReadAppUserPostLikeTask>? Function(
            Query<ReadAppUserPostLikeTask> query)?
        queryBuilder,
    AggregateSource source = AggregateSource.server,
    bool asCollectionGroup = false,
  }) async {
    Query<ReadAppUserPostLikeTask> query = asCollectionGroup
        ? readAppUserPostLikeTasksCollectionGroupReference
        : readAppUserPostLikeTasksCollectionReference;
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
  /// The [asCollectionGroup] parameter determines whether to query the 'appUserPostLikeTasks'
  /// collection directly (false) or as a collection group across different
  /// Firestore paths (true).
  ///
  /// Parameters:
  ///
  /// - [field] The field to average over.
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [asCollectionGroup] Query the 'appUserPostLikeTasks' as a collection group if true.
  ///
  /// Returns the average of the values of the documents that match the query.
  Future<double?> getAverage({
    required String field,
    Query<ReadAppUserPostLikeTask>? Function(
            Query<ReadAppUserPostLikeTask> query)?
        queryBuilder,
    AggregateSource source = AggregateSource.server,
    bool asCollectionGroup = false,
  }) async {
    Query<ReadAppUserPostLikeTask> query = asCollectionGroup
        ? readAppUserPostLikeTasksCollectionGroupReference
        : readAppUserPostLikeTasksCollectionReference;
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final aggregateQuery = await query.aggregate(average(field));
    final aggregateQs = await aggregateQuery.get(source: source);
    return aggregateQs.getAverage(field);
  }

  /// Fetches a single [ReadAppUserPostLikeTask] document from Cloud Firestore by its ID.
  ///
  /// This method retrieves a specific document using the provided [appUserPostLikeTaskId].
  /// You can control the data retrieval with [GetOptions].
  Future<ReadAppUserPostLikeTask?> fetchDocument({
    required String appUserPostLikeTaskId,
    GetOptions? options,
  }) async {
    final ds = await readAppUserPostLikeTaskDocumentReference(
      appUserPostLikeTaskId: appUserPostLikeTaskId,
    ).get(options);
    return ds.data();
  }

  /// Subscribes to a stream of a single [ReadAppUserPostLikeTask] document from Cloud Firestore by its ID.
  ///
  /// This method returns a stream of a single [ReadAppUserPostLikeTask] document, which updates in
  /// real-time based on the database changes. You can control the data retrieval with [GetOptions].
  Stream<ReadAppUserPostLikeTask?> subscribeDocument({
    required String appUserPostLikeTaskId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    var streamDs = readAppUserPostLikeTaskDocumentReference(
      appUserPostLikeTaskId: appUserPostLikeTaskId,
    ).snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }

  /// Adds a appUserPostLikeTask document to Cloud Firestore.
  ///
  /// This method creates a new document in Cloud Firestore using the provided
  /// [createAppUserPostLikeTask] data.
  Future<DocumentReference<CreateAppUserPostLikeTask>> add({
    required CreateAppUserPostLikeTask createAppUserPostLikeTask,
  }) =>
      createAppUserPostLikeTasksCollectionReference
          .add(createAppUserPostLikeTask);

  /// Sets a appUserPostLikeTask document to Cloud Firestore.
  ///
  /// This method creates a new document in Cloud Firestore using the provided
  /// [createAppUserPostLikeTask] data.
  Future<void> set({
    required String appUserPostLikeTaskId,
    required CreateAppUserPostLikeTask createAppUserPostLikeTask,
    SetOptions? options,
  }) =>
      createAppUserPostLikeTaskDocumentReference(
        appUserPostLikeTaskId: appUserPostLikeTaskId,
      ).set(createAppUserPostLikeTask, options);

  /// Updates a appUserPostLikeTask document in Cloud Firestore.
  ///
  /// This method partially updates the document identified by [appUserPostLikeTaskId] with the
  /// provided [updateAppUserPostLikeTask] data.
  /// The update is based on the structure defined in `UpdateAppUserPostLikeTask.toJson()`.
  Future<void> update({
    required String appUserPostLikeTaskId,
    required UpdateAppUserPostLikeTask updateAppUserPostLikeTask,
  }) =>
      updateAppUserPostLikeTaskDocumentReference(
        appUserPostLikeTaskId: appUserPostLikeTaskId,
      ).update(updateAppUserPostLikeTask.toJson());

  /// Deletes a appUserPostLikeTask document from Cloud Firestore.
  ///
  /// This method deletes an existing document identified by [appUserPostLikeTaskId].
  Future<void> delete({
    required String appUserPostLikeTaskId,
  }) =>
      deleteAppUserPostLikeTaskDocumentReference(
        appUserPostLikeTaskId: appUserPostLikeTaskId,
      ).delete();

  /// Performs a batch write operation in Firestore using a list of [BatchWriteAppUserPostLikeTask] tasks.
  ///
  /// This function allows for executing multiple Firestore write operations (create, update, delete)
  /// as a single batch. This ensures that all operations either complete successfully or fail
  /// without applying any changes, providing atomicity.
  ///
  /// Parameters:
  ///
  /// - [batchWriteTasks] A list of [BatchWriteAppUserPostLikeTask] objects, each representing a specific
  /// write operation (create, update, or delete) for AppUserPostLikeTask documents.
  ///
  /// The function iterates over each task in [batchWriteTasks] and performs the corresponding
  /// Firestore operation. This includes:
  ///
  /// - Creating new documents for tasks of type [BatchCreateAppUserPostLikeTask].
  /// - Updating existing documents for tasks of type [BatchUpdateAppUserPostLikeTask].
  /// - Deleting documents for tasks of type [BatchDeleteAppUserPostLikeTask].
  ///
  /// Returns a `Future<void>` that completes when the batch operation is committed successfully.
  ///
  /// Throws:
  ///
  /// - Firestore exceptions if the batch commit fails or if there are issues with the individual
  /// operations within the batch.
  Future<void> batchWrite(List<BatchWriteAppUserPostLikeTask> batchWriteTasks) {
    final batch = FirebaseFirestore.instance.batch();
    for (final task in batchWriteTasks) {
      switch (task) {
        case BatchCreateAppUserPostLikeTask(
            appUserPostLikeTaskId: final appUserPostLikeTaskId,
            createAppUserPostLikeTask: final createAppUserPostLikeTask,
          ):
          batch.set(
            createAppUserPostLikeTaskDocumentReference(
              appUserPostLikeTaskId: appUserPostLikeTaskId,
            ),
            createAppUserPostLikeTask,
          );
        case BatchUpdateAppUserPostLikeTask(
            appUserPostLikeTaskId: final appUserPostLikeTaskId,
            updateAppUserPostLikeTask: final updateAppUserPostLikeTask,
          ):
          batch.update(
            updateAppUserPostLikeTaskDocumentReference(
              appUserPostLikeTaskId: appUserPostLikeTaskId,
            ),
            updateAppUserPostLikeTask.toJson(),
          );
        case BatchDeleteAppUserPostLikeTask(
            appUserPostLikeTaskId: final appUserPostLikeTaskId
          ):
          batch.delete(deleteAppUserPostLikeTaskDocumentReference(
            appUserPostLikeTaskId: appUserPostLikeTaskId,
          ));
      }
    }
    return batch.commit();
  }
}
