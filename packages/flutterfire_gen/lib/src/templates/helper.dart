// Este é um exemplo de como os templates devem filtrar campos
// Adicione esta lógica aos templates: create_class_template.dart,
// update_class_template.dart, delete_class_template.dart

import '../configs/code_generation_config.dart';
import '../configs/field_config.dart';

/// Helper para filtrar campos que devem ser incluídos nas classes de escrita
/// (Create, Update, Delete)
class TemplateFieldHelper {
  /// Retorna apenas os campos que devem ser incluídos nas classes de escrita
  static List<FieldConfig> getWriteFields(CodeGenerationConfig config) {
    return config.fieldConfigs.where((field) => field.shouldIncludeInWriteClasses).toList();
  }

  /// Retorna apenas os campos que devem ser incluídos na classe Read
  static List<FieldConfig> getReadFields(CodeGenerationConfig config) {
    return config.fieldConfigs.where((field) => field.shouldIncludeInReadClass).toList();
  }
}

// EXEMPLO DE USO NOS TEMPLATES:

// ============================================
// read_class_template.dart (CRITICAL FIX)
// ============================================
/*
class ReadClassTemplate {
  final CodeGenerationConfig config;
  
  String generate() {
    final buffer = StringBuffer();
    
    // IMPORTANTE: Filtrar campos ignorados do fromJson
    final fieldsForFromJson = config.fieldConfigs
        .where((field) => !field.ignoreJsonSerialization) // ✅ Filtra @IgnoreJsonSerialization
        .toList();
    
    // Factory fromJson - usar apenas fieldsForFromJson
    buffer.writeln('factory ${config.readClassName}.fromJson(Map<String, dynamic> json) {');
    buffer.writeln('  final extendedJson = json;');
    buffer.writeln('  return ${config.readClassName}(');
    
    for (final field in fieldsForFromJson) {
      // Gerar código de desserialização usando FromJsonFieldParser
      buffer.writeln('    // ${field.name}');
    }
    
    buffer.writeln('  );');
    buffer.writeln('}');
    
    return buffer.toString();
  }
}
*/

// ============================================
// EXEMPLO COMPLETO: Read Class com Filtro
// ============================================

String generateReadClass(CodeGenerationConfig config) {
  // Campos ignorados NÃO devem estar no fromJson
  final fieldsForFromJson = config.fieldConfigs.where((field) => !field.ignoreJsonSerialization).toList();

  // Mas TODOS os campos devem estar na classe
  final allFields = config.fieldConfigs;

  final buffer = StringBuffer()
    ..writeln('class ${config.readClassName} {')
    ..writeln('  const ${config.readClassName}({');

  // Constructor parameters (TODOS os campos, incluindo ignorados)
  for (final field in allFields) {
    if (field.readDefaultValueString != null) {
      buffer.writeln('    this.${field.name} = ${field.readDefaultValueString},');
    } else {
      buffer.writeln('    required this.${field.name},');
    }
  }

  buffer
    ..writeln('  });')
    ..writeln();

  // Factory fromJson (APENAS campos não-ignorados)
  buffer
    ..writeln('  factory ${config.readClassName}.fromJson(Map<String, dynamic> json) {')
    ..writeln('    final extendedJson = json;')
    ..writeln('    return ${config.readClassName}(');

  for (final field in fieldsForFromJson) {
    // ✅ Filtra ignorados
    // Gerar código usando FromJsonFieldParser
    buffer.writeln('      // ${field.name}: ...,');
  }

  buffer
    ..writeln('    );')
    ..writeln('  }')
    ..writeln();

  // Fields (TODOS, incluindo ignorados)
  for (final field in allFields) {
    buffer.writeln('  final ${field.typeName()} ${field.name};');
  }

  buffer.writeln('}');

  return buffer.toString();
}

// ============================================
// create_class_template.dart (ANTES)
// ============================================
/*
class CreateClassTemplate {
  final CodeGenerationConfig config;
  
  String generate() {
    final buffer = StringBuffer();
    
    // Gera campos do construtor
    for (final field in config.fieldConfigs) { // ❌ Inclui todos os campos
      buffer.writeln('  final ${field.typeName()} ${field.name};');
    }
    
    return buffer.toString();
  }
}
*/

// ============================================
// create_class_template.dart (DEPOIS)
// ============================================
/*
class CreateClassTemplate {
  final CodeGenerationConfig config;
  
  String generate() {
    final buffer = StringBuffer();
    
    // Filtra apenas campos que devem estar nas classes de escrita
    final writeFields = config.fieldConfigs
        .where((field) => !field.ignoreJsonSerialization) // ✅ Filtra campos ignorados
        .toList();
    
    // Gera campos do construtor
    for (final field in writeFields) {
      buffer.writeln('  final ${field.typeName()} ${field.name};');
    }
    
    return buffer.toString();
  }
}
*/

// ============================================
// EXEMPLO COMPLETO: Create Class
// ============================================

String generateCreateClass(CodeGenerationConfig config) {
  final writeFields = config.fieldConfigs.where((field) => !field.ignoreJsonSerialization).toList();

  final buffer = StringBuffer()
    ..writeln('class ${config.createClassName} {')
    ..writeln('  const ${config.createClassName}({');

  // Constructor parameters (apenas campos não-ignorados)
  for (final field in writeFields) {
    if (field.createDefaultValueString != null) {
      buffer.writeln('    this.${field.name} = ${field.createDefaultValueString},');
    } else {
      buffer.writeln('    required this.${field.name},');
    }
  }

  buffer
    ..writeln('  });')
    ..writeln();

  // Fields (apenas campos não-ignorados)
  for (final field in writeFields) {
    final typeName = field.allowFieldValue ? field.typeName(wrapByFirestoreData: true) : field.typeName();
    buffer.writeln('  final $typeName ${field.name};');
  }

  buffer
    ..writeln()
    ..writeln('  Map<String, dynamic> toJson() {')
    ..writeln('    return {');

  // toJson (apenas campos não-ignorados)
  for (final field in writeFields) {
    // Gera código de serialização usando ToJsonFieldParser
    buffer.writeln('      // Serialização para ${field.name}');
  }

  buffer
    ..writeln('    };')
    ..writeln('  }')
    ..writeln('}');

  return buffer.toString();
}

// ============================================
// EXEMPLO COMPLETO: Update Class
// ============================================

String generateUpdateClass(CodeGenerationConfig config) {
  final writeFields = config.fieldConfigs.where((field) => !field.ignoreJsonSerialization).toList();

  final buffer = StringBuffer()
    ..writeln('class ${config.updateClassName} {')
    ..writeln('  const ${config.updateClassName}({');

  // Constructor parameters (todos nullable em Update)
  for (final field in writeFields) {
    buffer.writeln('    this.${field.name},');
  }

  buffer
    ..writeln('  });')
    ..writeln();

  // Fields (todos nullable)
  for (final field in writeFields) {
    final typeName = field.allowFieldValue ? field.typeName(forceNullable: true, wrapByFirestoreData: true) : field.typeName(forceNullable: true);
    buffer.writeln('  final $typeName ${field.name};');
  }

  buffer
    ..writeln()
    ..writeln('  Map<String, dynamic> toJson() {')
    ..writeln('    return {');

  // toJson com skipIfNull
  for (final field in writeFields) {
    buffer.writeln('      // Serialização condicional para ${field.name}');
  }

  buffer
    ..writeln('    };')
    ..writeln('  }')
    ..writeln('}');

  return buffer.toString();
}

// ============================================
// EXEMPLO COMPLETO: Read Class
// ============================================

// String generateReadClass(CodeGenerationConfig config) {
//   // Read class inclui TODOS os campos (mesmo os @IgnoreJsonSerialization)
//   // Pois getters computados ainda devem aparecer na classe de leitura
//   final allFields = config.fieldConfigs;

//   final buffer = StringBuffer()
//     ..writeln('class ${config.readClassName} {')
//     ..writeln('  const ${config.readClassName}({');

//   // Constructor parameters
//   for (final field in allFields) {
//     if (field.readDefaultValueString != null) {
//       buffer.writeln('    this.${field.name} = ${field.readDefaultValueString},');
//     } else {
//       buffer.writeln('    required this.${field.name},');
//     }
//   }

//   buffer
//     ..writeln('  });')
//     ..writeln();

//   // Factory fromJson
//   buffer
//     ..writeln('  factory ${config.readClassName}.fromJson(Map<String, dynamic> json) {')
//     ..writeln('    return ${config.readClassName}(');

//   // fromJson apenas para campos não-ignorados
//   final writeFields = allFields
//       .where((field) => !field.ignoreJsonSerialization)
//       .toList();

//   for (final field in writeFields) {
//     buffer.writeln('      // Desserialização para ${field.name}');
//   }

//   buffer
//     ..writeln('    );')
//     ..writeln('  }')
//     ..writeln();

//   // Fields
//   for (final field in allFields) {
//     buffer.writeln('  final ${field.typeName()} ${field.name};');
//   }

//   buffer.writeln('}');

//   return buffer.toString();
// }
