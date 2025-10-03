/// Annotation to indicate that a field should skip automatic fromJson/toJson
/// calls and use the constructor or value directly.
///
/// This is useful for classes that don't need JSON serialization but are
/// still non-primitive types.
///
/// Example:
/// ```dart
/// @FirestoreDocument(path: 'audits/{auditId}')
/// class AuditSchema {
///   final String id;
///
///   @IgnoreJsonSerialization()
///   final AuditoriaActions actions; // Will call AuditoriaActions() constructor
/// }
/// ```
///
/// When this annotation is used:
/// - In `fromJson`: Instead of calling `ClassName.fromJson(json)`,
///   it will call `ClassName()` (the default constructor)
/// - In `toJson`: Instead of calling `instance.toJson()`,
///   it will use the instance value directly
class IgnoreJsonSerialization {
  /// Creates a const instance of [IgnoreJsonSerialization].
  const IgnoreJsonSerialization();
}
