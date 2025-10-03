/// Annotation to indicate that a field should be completely ignored during
/// code generation.
///
/// This is useful for:
/// - Getters that should not be included in Create/Update/Delete classes
/// - Computed properties that don't need to be persisted
/// - Fields that should only exist in the Read class
///
/// Example:
/// ```dart
/// @FirestoreDocument(path: 'users/{userId}')
/// class UserSchema {
///   final String firstName;
///   final String lastName;
///
///   @IgnoreJsonSerialization()
///   String get fullName => '$firstName $lastName'; // Won't be in Create/Update
/// }
/// ```
///
/// When this annotation is used:
/// - The field will NOT appear in Create, Update, or Delete classes
/// - The field will still appear in the Read class (if it's a getter)
/// - No fromJson or toJson will be generated for this field
class IgnoreJsonSerialization {
  /// Creates a const instance of [IgnoreJsonSerialization].
  const IgnoreJsonSerialization();
}
