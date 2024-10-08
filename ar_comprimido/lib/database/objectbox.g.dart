// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import '../dados.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 185278035458131309),
      name: 'Dados',
      lastPropertyId: const IdUid(9, 7649702276766651938),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7693103748690401295),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6047575188043807563),
            name: 'local',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1755218858127515255),
            name: 'componente',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1828078371572098529),
            name: 'obs',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 3219764348904189482),
            name: 'classificacao',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 3717991742090465466),
            name: 'data',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 769684790879052303),
            name: 'qtd',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 717982977329124693),
            name: 'fotoPath',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 7649702276766651938),
            name: 'tag',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Shortcut for [Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [Store.new] for an explanation of all parameters.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// Returns the ObjectBox model definition for this project for use with
/// [Store.new].
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 185278035458131309),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Dados: EntityDefinition<Dados>(
        model: _entities[0],
        toOneRelations: (Dados object) => [],
        toManyRelations: (Dados object) => {},
        getId: (Dados object) => object.id,
        setId: (Dados object, int id) {
          object.id = id;
        },
        objectToFB: (Dados object, fb.Builder fbb) {
          final localOffset = fbb.writeString(object.local);
          final componenteOffset = fbb.writeString(object.componente);
          final obsOffset = fbb.writeString(object.obs);
          final classificacaoOffset = fbb.writeString(object.classificacao);
          final dataOffset = fbb.writeString(object.data);
          final qtdOffset = fbb.writeString(object.qtd);
          final fotoPathOffset = fbb.writeString(object.fotoPath);
          fbb.startTable(10);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, localOffset);
          fbb.addOffset(2, componenteOffset);
          fbb.addOffset(3, obsOffset);
          fbb.addOffset(4, classificacaoOffset);
          fbb.addOffset(5, dataOffset);
          fbb.addOffset(6, qtdOffset);
          fbb.addOffset(7, fotoPathOffset);
          fbb.addInt64(8, object.tag);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final classificacaoParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 12, '');
          final componenteParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final dataParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 14, '');
          final tagParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 20, 0);
          final localParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final obsParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 10, '');
          final qtdParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 16, '');
          final fotoPathParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 18, '');
          final object = Dados(
              classificacao: classificacaoParam,
              componente: componenteParam,
              data: dataParam,
              tag: tagParam,
              local: localParam,
              obs: obsParam,
              qtd: qtdParam,
              fotoPath: fotoPathParam)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Dados] entity fields to define ObjectBox queries.
class Dados_ {
  /// see [Dados.id]
  static final id = QueryIntegerProperty<Dados>(_entities[0].properties[0]);

  /// see [Dados.local]
  static final local = QueryStringProperty<Dados>(_entities[0].properties[1]);

  /// see [Dados.componente]
  static final componente =
      QueryStringProperty<Dados>(_entities[0].properties[2]);

  /// see [Dados.obs]
  static final obs = QueryStringProperty<Dados>(_entities[0].properties[3]);

  /// see [Dados.classificacao]
  static final classificacao =
      QueryStringProperty<Dados>(_entities[0].properties[4]);

  /// see [Dados.data]
  static final data = QueryStringProperty<Dados>(_entities[0].properties[5]);

  /// see [Dados.qtd]
  static final qtd = QueryStringProperty<Dados>(_entities[0].properties[6]);

  /// see [Dados.fotoPath]
  static final fotoPath =
      QueryStringProperty<Dados>(_entities[0].properties[7]);

  /// see [Dados.tag]
  static final tag = QueryIntegerProperty<Dados>(_entities[0].properties[8]);
}
