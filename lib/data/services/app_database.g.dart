// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HabitsTable extends Habits with TableInfo<$HabitsTable, HabitRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorIndexMeta = const VerificationMeta(
    'colorIndex',
  );
  @override
  late final GeneratedColumn<int> colorIndex = GeneratedColumn<int>(
    'color_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconIndexMeta = const VerificationMeta(
    'iconIndex',
  );
  @override
  late final GeneratedColumn<int> iconIndex = GeneratedColumn<int>(
    'icon_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduleBitmaskMeta = const VerificationMeta(
    'scheduleBitmask',
  );
  @override
  late final GeneratedColumn<int> scheduleBitmask = GeneratedColumn<int>(
    'schedule_bitmask',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reminderMinutesMeta = const VerificationMeta(
    'reminderMinutes',
  );
  @override
  late final GeneratedColumn<int> reminderMinutes = GeneratedColumn<int>(
    'reminder_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderEnabledMeta = const VerificationMeta(
    'reminderEnabled',
  );
  @override
  late final GeneratedColumn<bool> reminderEnabled = GeneratedColumn<bool>(
    'reminder_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reminder_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _statusIndexMeta = const VerificationMeta(
    'statusIndex',
  );
  @override
  late final GeneratedColumn<int> statusIndex = GeneratedColumn<int>(
    'status_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
    'group_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    colorIndex,
    iconIndex,
    scheduleBitmask,
    reminderMinutes,
    reminderEnabled,
    statusIndex,
    createdAt,
    groupId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color_index')) {
      context.handle(
        _colorIndexMeta,
        colorIndex.isAcceptableOrUnknown(data['color_index']!, _colorIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_colorIndexMeta);
    }
    if (data.containsKey('icon_index')) {
      context.handle(
        _iconIndexMeta,
        iconIndex.isAcceptableOrUnknown(data['icon_index']!, _iconIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_iconIndexMeta);
    }
    if (data.containsKey('schedule_bitmask')) {
      context.handle(
        _scheduleBitmaskMeta,
        scheduleBitmask.isAcceptableOrUnknown(
          data['schedule_bitmask']!,
          _scheduleBitmaskMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduleBitmaskMeta);
    }
    if (data.containsKey('reminder_minutes')) {
      context.handle(
        _reminderMinutesMeta,
        reminderMinutes.isAcceptableOrUnknown(
          data['reminder_minutes']!,
          _reminderMinutesMeta,
        ),
      );
    }
    if (data.containsKey('reminder_enabled')) {
      context.handle(
        _reminderEnabledMeta,
        reminderEnabled.isAcceptableOrUnknown(
          data['reminder_enabled']!,
          _reminderEnabledMeta,
        ),
      );
    }
    if (data.containsKey('status_index')) {
      context.handle(
        _statusIndexMeta,
        statusIndex.isAcceptableOrUnknown(
          data['status_index']!,
          _statusIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_statusIndexMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      colorIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_index'],
      )!,
      iconIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}icon_index'],
      )!,
      scheduleBitmask: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}schedule_bitmask'],
      )!,
      reminderMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_minutes'],
      ),
      reminderEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminder_enabled'],
      )!,
      statusIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status_index'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_id'],
      ),
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class HabitRow extends DataClass implements Insertable<HabitRow> {
  final String id;
  final String name;
  final int colorIndex;
  final int iconIndex;
  final int scheduleBitmask;
  final int? reminderMinutes;
  final bool reminderEnabled;
  final int statusIndex;
  final DateTime createdAt;
  final String? groupId;
  const HabitRow({
    required this.id,
    required this.name,
    required this.colorIndex,
    required this.iconIndex,
    required this.scheduleBitmask,
    this.reminderMinutes,
    required this.reminderEnabled,
    required this.statusIndex,
    required this.createdAt,
    this.groupId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['color_index'] = Variable<int>(colorIndex);
    map['icon_index'] = Variable<int>(iconIndex);
    map['schedule_bitmask'] = Variable<int>(scheduleBitmask);
    if (!nullToAbsent || reminderMinutes != null) {
      map['reminder_minutes'] = Variable<int>(reminderMinutes);
    }
    map['reminder_enabled'] = Variable<bool>(reminderEnabled);
    map['status_index'] = Variable<int>(statusIndex);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<String>(groupId);
    }
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      name: Value(name),
      colorIndex: Value(colorIndex),
      iconIndex: Value(iconIndex),
      scheduleBitmask: Value(scheduleBitmask),
      reminderMinutes: reminderMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderMinutes),
      reminderEnabled: Value(reminderEnabled),
      statusIndex: Value(statusIndex),
      createdAt: Value(createdAt),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
    );
  }

  factory HabitRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      colorIndex: serializer.fromJson<int>(json['colorIndex']),
      iconIndex: serializer.fromJson<int>(json['iconIndex']),
      scheduleBitmask: serializer.fromJson<int>(json['scheduleBitmask']),
      reminderMinutes: serializer.fromJson<int?>(json['reminderMinutes']),
      reminderEnabled: serializer.fromJson<bool>(json['reminderEnabled']),
      statusIndex: serializer.fromJson<int>(json['statusIndex']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      groupId: serializer.fromJson<String?>(json['groupId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'colorIndex': serializer.toJson<int>(colorIndex),
      'iconIndex': serializer.toJson<int>(iconIndex),
      'scheduleBitmask': serializer.toJson<int>(scheduleBitmask),
      'reminderMinutes': serializer.toJson<int?>(reminderMinutes),
      'reminderEnabled': serializer.toJson<bool>(reminderEnabled),
      'statusIndex': serializer.toJson<int>(statusIndex),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'groupId': serializer.toJson<String?>(groupId),
    };
  }

  HabitRow copyWith({
    String? id,
    String? name,
    int? colorIndex,
    int? iconIndex,
    int? scheduleBitmask,
    Value<int?> reminderMinutes = const Value.absent(),
    bool? reminderEnabled,
    int? statusIndex,
    DateTime? createdAt,
    Value<String?> groupId = const Value.absent(),
  }) => HabitRow(
    id: id ?? this.id,
    name: name ?? this.name,
    colorIndex: colorIndex ?? this.colorIndex,
    iconIndex: iconIndex ?? this.iconIndex,
    scheduleBitmask: scheduleBitmask ?? this.scheduleBitmask,
    reminderMinutes: reminderMinutes.present
        ? reminderMinutes.value
        : this.reminderMinutes,
    reminderEnabled: reminderEnabled ?? this.reminderEnabled,
    statusIndex: statusIndex ?? this.statusIndex,
    createdAt: createdAt ?? this.createdAt,
    groupId: groupId.present ? groupId.value : this.groupId,
  );
  HabitRow copyWithCompanion(HabitsCompanion data) {
    return HabitRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      colorIndex: data.colorIndex.present
          ? data.colorIndex.value
          : this.colorIndex,
      iconIndex: data.iconIndex.present ? data.iconIndex.value : this.iconIndex,
      scheduleBitmask: data.scheduleBitmask.present
          ? data.scheduleBitmask.value
          : this.scheduleBitmask,
      reminderMinutes: data.reminderMinutes.present
          ? data.reminderMinutes.value
          : this.reminderMinutes,
      reminderEnabled: data.reminderEnabled.present
          ? data.reminderEnabled.value
          : this.reminderEnabled,
      statusIndex: data.statusIndex.present
          ? data.statusIndex.value
          : this.statusIndex,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorIndex: $colorIndex, ')
          ..write('iconIndex: $iconIndex, ')
          ..write('scheduleBitmask: $scheduleBitmask, ')
          ..write('reminderMinutes: $reminderMinutes, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('statusIndex: $statusIndex, ')
          ..write('createdAt: $createdAt, ')
          ..write('groupId: $groupId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    colorIndex,
    iconIndex,
    scheduleBitmask,
    reminderMinutes,
    reminderEnabled,
    statusIndex,
    createdAt,
    groupId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.colorIndex == this.colorIndex &&
          other.iconIndex == this.iconIndex &&
          other.scheduleBitmask == this.scheduleBitmask &&
          other.reminderMinutes == this.reminderMinutes &&
          other.reminderEnabled == this.reminderEnabled &&
          other.statusIndex == this.statusIndex &&
          other.createdAt == this.createdAt &&
          other.groupId == this.groupId);
}

class HabitsCompanion extends UpdateCompanion<HabitRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> colorIndex;
  final Value<int> iconIndex;
  final Value<int> scheduleBitmask;
  final Value<int?> reminderMinutes;
  final Value<bool> reminderEnabled;
  final Value<int> statusIndex;
  final Value<DateTime> createdAt;
  final Value<String?> groupId;
  final Value<int> rowid;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.colorIndex = const Value.absent(),
    this.iconIndex = const Value.absent(),
    this.scheduleBitmask = const Value.absent(),
    this.reminderMinutes = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.statusIndex = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.groupId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitsCompanion.insert({
    required String id,
    required String name,
    required int colorIndex,
    required int iconIndex,
    required int scheduleBitmask,
    this.reminderMinutes = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    required int statusIndex,
    required DateTime createdAt,
    this.groupId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       colorIndex = Value(colorIndex),
       iconIndex = Value(iconIndex),
       scheduleBitmask = Value(scheduleBitmask),
       statusIndex = Value(statusIndex),
       createdAt = Value(createdAt);
  static Insertable<HabitRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? colorIndex,
    Expression<int>? iconIndex,
    Expression<int>? scheduleBitmask,
    Expression<int>? reminderMinutes,
    Expression<bool>? reminderEnabled,
    Expression<int>? statusIndex,
    Expression<DateTime>? createdAt,
    Expression<String>? groupId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (colorIndex != null) 'color_index': colorIndex,
      if (iconIndex != null) 'icon_index': iconIndex,
      if (scheduleBitmask != null) 'schedule_bitmask': scheduleBitmask,
      if (reminderMinutes != null) 'reminder_minutes': reminderMinutes,
      if (reminderEnabled != null) 'reminder_enabled': reminderEnabled,
      if (statusIndex != null) 'status_index': statusIndex,
      if (createdAt != null) 'created_at': createdAt,
      if (groupId != null) 'group_id': groupId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? colorIndex,
    Value<int>? iconIndex,
    Value<int>? scheduleBitmask,
    Value<int?>? reminderMinutes,
    Value<bool>? reminderEnabled,
    Value<int>? statusIndex,
    Value<DateTime>? createdAt,
    Value<String?>? groupId,
    Value<int>? rowid,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      colorIndex: colorIndex ?? this.colorIndex,
      iconIndex: iconIndex ?? this.iconIndex,
      scheduleBitmask: scheduleBitmask ?? this.scheduleBitmask,
      reminderMinutes: reminderMinutes ?? this.reminderMinutes,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      statusIndex: statusIndex ?? this.statusIndex,
      createdAt: createdAt ?? this.createdAt,
      groupId: groupId ?? this.groupId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (colorIndex.present) {
      map['color_index'] = Variable<int>(colorIndex.value);
    }
    if (iconIndex.present) {
      map['icon_index'] = Variable<int>(iconIndex.value);
    }
    if (scheduleBitmask.present) {
      map['schedule_bitmask'] = Variable<int>(scheduleBitmask.value);
    }
    if (reminderMinutes.present) {
      map['reminder_minutes'] = Variable<int>(reminderMinutes.value);
    }
    if (reminderEnabled.present) {
      map['reminder_enabled'] = Variable<bool>(reminderEnabled.value);
    }
    if (statusIndex.present) {
      map['status_index'] = Variable<int>(statusIndex.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorIndex: $colorIndex, ')
          ..write('iconIndex: $iconIndex, ')
          ..write('scheduleBitmask: $scheduleBitmask, ')
          ..write('reminderMinutes: $reminderMinutes, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('statusIndex: $statusIndex, ')
          ..write('createdAt: $createdAt, ')
          ..write('groupId: $groupId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitCompletionsTable extends HabitCompletions
    with TableInfo<$HabitCompletionsTable, HabitCompletionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitCompletionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _markedAtMeta = const VerificationMeta(
    'markedAt',
  );
  @override
  late final GeneratedColumn<DateTime> markedAt = GeneratedColumn<DateTime>(
    'marked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [habitId, date, markedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_completions';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitCompletionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('marked_at')) {
      context.handle(
        _markedAtMeta,
        markedAt.isAcceptableOrUnknown(data['marked_at']!, _markedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_markedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {habitId, date};
  @override
  HabitCompletionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitCompletionRow(
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      markedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}marked_at'],
      )!,
    );
  }

  @override
  $HabitCompletionsTable createAlias(String alias) {
    return $HabitCompletionsTable(attachedDatabase, alias);
  }
}

class HabitCompletionRow extends DataClass
    implements Insertable<HabitCompletionRow> {
  final String habitId;
  final DateTime date;
  final DateTime markedAt;
  const HabitCompletionRow({
    required this.habitId,
    required this.date,
    required this.markedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['habit_id'] = Variable<String>(habitId);
    map['date'] = Variable<DateTime>(date);
    map['marked_at'] = Variable<DateTime>(markedAt);
    return map;
  }

  HabitCompletionsCompanion toCompanion(bool nullToAbsent) {
    return HabitCompletionsCompanion(
      habitId: Value(habitId),
      date: Value(date),
      markedAt: Value(markedAt),
    );
  }

  factory HabitCompletionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitCompletionRow(
      habitId: serializer.fromJson<String>(json['habitId']),
      date: serializer.fromJson<DateTime>(json['date']),
      markedAt: serializer.fromJson<DateTime>(json['markedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'habitId': serializer.toJson<String>(habitId),
      'date': serializer.toJson<DateTime>(date),
      'markedAt': serializer.toJson<DateTime>(markedAt),
    };
  }

  HabitCompletionRow copyWith({
    String? habitId,
    DateTime? date,
    DateTime? markedAt,
  }) => HabitCompletionRow(
    habitId: habitId ?? this.habitId,
    date: date ?? this.date,
    markedAt: markedAt ?? this.markedAt,
  );
  HabitCompletionRow copyWithCompanion(HabitCompletionsCompanion data) {
    return HabitCompletionRow(
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      date: data.date.present ? data.date.value : this.date,
      markedAt: data.markedAt.present ? data.markedAt.value : this.markedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitCompletionRow(')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('markedAt: $markedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(habitId, date, markedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitCompletionRow &&
          other.habitId == this.habitId &&
          other.date == this.date &&
          other.markedAt == this.markedAt);
}

class HabitCompletionsCompanion extends UpdateCompanion<HabitCompletionRow> {
  final Value<String> habitId;
  final Value<DateTime> date;
  final Value<DateTime> markedAt;
  final Value<int> rowid;
  const HabitCompletionsCompanion({
    this.habitId = const Value.absent(),
    this.date = const Value.absent(),
    this.markedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitCompletionsCompanion.insert({
    required String habitId,
    required DateTime date,
    required DateTime markedAt,
    this.rowid = const Value.absent(),
  }) : habitId = Value(habitId),
       date = Value(date),
       markedAt = Value(markedAt);
  static Insertable<HabitCompletionRow> custom({
    Expression<String>? habitId,
    Expression<DateTime>? date,
    Expression<DateTime>? markedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (habitId != null) 'habit_id': habitId,
      if (date != null) 'date': date,
      if (markedAt != null) 'marked_at': markedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitCompletionsCompanion copyWith({
    Value<String>? habitId,
    Value<DateTime>? date,
    Value<DateTime>? markedAt,
    Value<int>? rowid,
  }) {
    return HabitCompletionsCompanion(
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      markedAt: markedAt ?? this.markedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (markedAt.present) {
      map['marked_at'] = Variable<DateTime>(markedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitCompletionsCompanion(')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('markedAt: $markedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserProfileTableTable extends UserProfileTable
    with TableInfo<$UserProfileTableTable, UserProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfileTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarPathMeta = const VerificationMeta(
    'avatarPath',
  );
  @override
  late final GeneratedColumn<String> avatarPath = GeneratedColumn<String>(
    'avatar_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
    'xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _hardcoreModeMeta = const VerificationMeta(
    'hardcoreMode',
  );
  @override
  late final GeneratedColumn<bool> hardcoreMode = GeneratedColumn<bool>(
    'hardcore_mode',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("hardcore_mode" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _themePreferenceIndexMeta =
      const VerificationMeta('themePreferenceIndex');
  @override
  late final GeneratedColumn<int> themePreferenceIndex = GeneratedColumn<int>(
    'theme_preference_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _localeTagMeta = const VerificationMeta(
    'localeTag',
  );
  @override
  late final GeneratedColumn<String> localeTag = GeneratedColumn<String>(
    'locale_tag',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('ru'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    avatarPath,
    level,
    xp,
    hardcoreMode,
    themePreferenceIndex,
    localeTag,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profile_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('avatar_path')) {
      context.handle(
        _avatarPathMeta,
        avatarPath.isAcceptableOrUnknown(data['avatar_path']!, _avatarPathMeta),
      );
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    }
    if (data.containsKey('hardcore_mode')) {
      context.handle(
        _hardcoreModeMeta,
        hardcoreMode.isAcceptableOrUnknown(
          data['hardcore_mode']!,
          _hardcoreModeMeta,
        ),
      );
    }
    if (data.containsKey('theme_preference_index')) {
      context.handle(
        _themePreferenceIndexMeta,
        themePreferenceIndex.isAcceptableOrUnknown(
          data['theme_preference_index']!,
          _themePreferenceIndexMeta,
        ),
      );
    }
    if (data.containsKey('locale_tag')) {
      context.handle(
        _localeTagMeta,
        localeTag.isAcceptableOrUnknown(data['locale_tag']!, _localeTagMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      avatarPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_path'],
      ),
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      xp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp'],
      )!,
      hardcoreMode: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}hardcore_mode'],
      )!,
      themePreferenceIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}theme_preference_index'],
      )!,
      localeTag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale_tag'],
      )!,
    );
  }

  @override
  $UserProfileTableTable createAlias(String alias) {
    return $UserProfileTableTable(attachedDatabase, alias);
  }
}

class UserProfileRow extends DataClass implements Insertable<UserProfileRow> {
  final int id;
  final String displayName;
  final String? avatarPath;
  final int level;
  final int xp;
  final bool hardcoreMode;
  final int themePreferenceIndex;
  final String localeTag;
  const UserProfileRow({
    required this.id,
    required this.displayName,
    this.avatarPath,
    required this.level,
    required this.xp,
    required this.hardcoreMode,
    required this.themePreferenceIndex,
    required this.localeTag,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || avatarPath != null) {
      map['avatar_path'] = Variable<String>(avatarPath);
    }
    map['level'] = Variable<int>(level);
    map['xp'] = Variable<int>(xp);
    map['hardcore_mode'] = Variable<bool>(hardcoreMode);
    map['theme_preference_index'] = Variable<int>(themePreferenceIndex);
    map['locale_tag'] = Variable<String>(localeTag);
    return map;
  }

  UserProfileTableCompanion toCompanion(bool nullToAbsent) {
    return UserProfileTableCompanion(
      id: Value(id),
      displayName: Value(displayName),
      avatarPath: avatarPath == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarPath),
      level: Value(level),
      xp: Value(xp),
      hardcoreMode: Value(hardcoreMode),
      themePreferenceIndex: Value(themePreferenceIndex),
      localeTag: Value(localeTag),
    );
  }

  factory UserProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfileRow(
      id: serializer.fromJson<int>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      avatarPath: serializer.fromJson<String?>(json['avatarPath']),
      level: serializer.fromJson<int>(json['level']),
      xp: serializer.fromJson<int>(json['xp']),
      hardcoreMode: serializer.fromJson<bool>(json['hardcoreMode']),
      themePreferenceIndex: serializer.fromJson<int>(
        json['themePreferenceIndex'],
      ),
      localeTag: serializer.fromJson<String>(json['localeTag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'displayName': serializer.toJson<String>(displayName),
      'avatarPath': serializer.toJson<String?>(avatarPath),
      'level': serializer.toJson<int>(level),
      'xp': serializer.toJson<int>(xp),
      'hardcoreMode': serializer.toJson<bool>(hardcoreMode),
      'themePreferenceIndex': serializer.toJson<int>(themePreferenceIndex),
      'localeTag': serializer.toJson<String>(localeTag),
    };
  }

  UserProfileRow copyWith({
    int? id,
    String? displayName,
    Value<String?> avatarPath = const Value.absent(),
    int? level,
    int? xp,
    bool? hardcoreMode,
    int? themePreferenceIndex,
    String? localeTag,
  }) => UserProfileRow(
    id: id ?? this.id,
    displayName: displayName ?? this.displayName,
    avatarPath: avatarPath.present ? avatarPath.value : this.avatarPath,
    level: level ?? this.level,
    xp: xp ?? this.xp,
    hardcoreMode: hardcoreMode ?? this.hardcoreMode,
    themePreferenceIndex: themePreferenceIndex ?? this.themePreferenceIndex,
    localeTag: localeTag ?? this.localeTag,
  );
  UserProfileRow copyWithCompanion(UserProfileTableCompanion data) {
    return UserProfileRow(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      avatarPath: data.avatarPath.present
          ? data.avatarPath.value
          : this.avatarPath,
      level: data.level.present ? data.level.value : this.level,
      xp: data.xp.present ? data.xp.value : this.xp,
      hardcoreMode: data.hardcoreMode.present
          ? data.hardcoreMode.value
          : this.hardcoreMode,
      themePreferenceIndex: data.themePreferenceIndex.present
          ? data.themePreferenceIndex.value
          : this.themePreferenceIndex,
      localeTag: data.localeTag.present ? data.localeTag.value : this.localeTag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileRow(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('level: $level, ')
          ..write('xp: $xp, ')
          ..write('hardcoreMode: $hardcoreMode, ')
          ..write('themePreferenceIndex: $themePreferenceIndex, ')
          ..write('localeTag: $localeTag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    displayName,
    avatarPath,
    level,
    xp,
    hardcoreMode,
    themePreferenceIndex,
    localeTag,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfileRow &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.avatarPath == this.avatarPath &&
          other.level == this.level &&
          other.xp == this.xp &&
          other.hardcoreMode == this.hardcoreMode &&
          other.themePreferenceIndex == this.themePreferenceIndex &&
          other.localeTag == this.localeTag);
}

class UserProfileTableCompanion extends UpdateCompanion<UserProfileRow> {
  final Value<int> id;
  final Value<String> displayName;
  final Value<String?> avatarPath;
  final Value<int> level;
  final Value<int> xp;
  final Value<bool> hardcoreMode;
  final Value<int> themePreferenceIndex;
  final Value<String> localeTag;
  const UserProfileTableCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.avatarPath = const Value.absent(),
    this.level = const Value.absent(),
    this.xp = const Value.absent(),
    this.hardcoreMode = const Value.absent(),
    this.themePreferenceIndex = const Value.absent(),
    this.localeTag = const Value.absent(),
  });
  UserProfileTableCompanion.insert({
    this.id = const Value.absent(),
    required String displayName,
    this.avatarPath = const Value.absent(),
    this.level = const Value.absent(),
    this.xp = const Value.absent(),
    this.hardcoreMode = const Value.absent(),
    this.themePreferenceIndex = const Value.absent(),
    this.localeTag = const Value.absent(),
  }) : displayName = Value(displayName);
  static Insertable<UserProfileRow> custom({
    Expression<int>? id,
    Expression<String>? displayName,
    Expression<String>? avatarPath,
    Expression<int>? level,
    Expression<int>? xp,
    Expression<bool>? hardcoreMode,
    Expression<int>? themePreferenceIndex,
    Expression<String>? localeTag,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (avatarPath != null) 'avatar_path': avatarPath,
      if (level != null) 'level': level,
      if (xp != null) 'xp': xp,
      if (hardcoreMode != null) 'hardcore_mode': hardcoreMode,
      if (themePreferenceIndex != null)
        'theme_preference_index': themePreferenceIndex,
      if (localeTag != null) 'locale_tag': localeTag,
    });
  }

  UserProfileTableCompanion copyWith({
    Value<int>? id,
    Value<String>? displayName,
    Value<String?>? avatarPath,
    Value<int>? level,
    Value<int>? xp,
    Value<bool>? hardcoreMode,
    Value<int>? themePreferenceIndex,
    Value<String>? localeTag,
  }) {
    return UserProfileTableCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      avatarPath: avatarPath ?? this.avatarPath,
      level: level ?? this.level,
      xp: xp ?? this.xp,
      hardcoreMode: hardcoreMode ?? this.hardcoreMode,
      themePreferenceIndex: themePreferenceIndex ?? this.themePreferenceIndex,
      localeTag: localeTag ?? this.localeTag,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (avatarPath.present) {
      map['avatar_path'] = Variable<String>(avatarPath.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (xp.present) {
      map['xp'] = Variable<int>(xp.value);
    }
    if (hardcoreMode.present) {
      map['hardcore_mode'] = Variable<bool>(hardcoreMode.value);
    }
    if (themePreferenceIndex.present) {
      map['theme_preference_index'] = Variable<int>(themePreferenceIndex.value);
    }
    if (localeTag.present) {
      map['locale_tag'] = Variable<String>(localeTag.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileTableCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('level: $level, ')
          ..write('xp: $xp, ')
          ..write('hardcoreMode: $hardcoreMode, ')
          ..write('themePreferenceIndex: $themePreferenceIndex, ')
          ..write('localeTag: $localeTag')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $HabitCompletionsTable habitCompletions = $HabitCompletionsTable(
    this,
  );
  late final $UserProfileTableTable userProfileTable = $UserProfileTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    habits,
    habitCompletions,
    userProfileTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'habits',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('habit_completions', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$HabitsTableCreateCompanionBuilder =
    HabitsCompanion Function({
      required String id,
      required String name,
      required int colorIndex,
      required int iconIndex,
      required int scheduleBitmask,
      Value<int?> reminderMinutes,
      Value<bool> reminderEnabled,
      required int statusIndex,
      required DateTime createdAt,
      Value<String?> groupId,
      Value<int> rowid,
    });
typedef $$HabitsTableUpdateCompanionBuilder =
    HabitsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> colorIndex,
      Value<int> iconIndex,
      Value<int> scheduleBitmask,
      Value<int?> reminderMinutes,
      Value<bool> reminderEnabled,
      Value<int> statusIndex,
      Value<DateTime> createdAt,
      Value<String?> groupId,
      Value<int> rowid,
    });

final class $$HabitsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsTable, HabitRow> {
  $$HabitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HabitCompletionsTable, List<HabitCompletionRow>>
  _habitCompletionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitCompletions,
    aliasName: $_aliasNameGenerator(db.habits.id, db.habitCompletions.habitId),
  );

  $$HabitCompletionsTableProcessedTableManager get habitCompletionsRefs {
    final manager = $$HabitCompletionsTableTableManager(
      $_db,
      $_db.habitCompletions,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _habitCompletionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorIndex => $composableBuilder(
    column: $table.colorIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get iconIndex => $composableBuilder(
    column: $table.iconIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scheduleBitmask => $composableBuilder(
    column: $table.scheduleBitmask,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderMinutes => $composableBuilder(
    column: $table.reminderMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get statusIndex => $composableBuilder(
    column: $table.statusIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupId => $composableBuilder(
    column: $table.groupId,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> habitCompletionsRefs(
    Expression<bool> Function($$HabitCompletionsTableFilterComposer f) f,
  ) {
    final $$HabitCompletionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitCompletions,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitCompletionsTableFilterComposer(
            $db: $db,
            $table: $db.habitCompletions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorIndex => $composableBuilder(
    column: $table.colorIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get iconIndex => $composableBuilder(
    column: $table.iconIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scheduleBitmask => $composableBuilder(
    column: $table.scheduleBitmask,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderMinutes => $composableBuilder(
    column: $table.reminderMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get statusIndex => $composableBuilder(
    column: $table.statusIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupId => $composableBuilder(
    column: $table.groupId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get colorIndex => $composableBuilder(
    column: $table.colorIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get iconIndex =>
      $composableBuilder(column: $table.iconIndex, builder: (column) => column);

  GeneratedColumn<int> get scheduleBitmask => $composableBuilder(
    column: $table.scheduleBitmask,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderMinutes => $composableBuilder(
    column: $table.reminderMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get statusIndex => $composableBuilder(
    column: $table.statusIndex,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get groupId =>
      $composableBuilder(column: $table.groupId, builder: (column) => column);

  Expression<T> habitCompletionsRefs<T extends Object>(
    Expression<T> Function($$HabitCompletionsTableAnnotationComposer a) f,
  ) {
    final $$HabitCompletionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitCompletions,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitCompletionsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitCompletions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsTable,
          HabitRow,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (HabitRow, $$HabitsTableReferences),
          HabitRow,
          PrefetchHooks Function({bool habitCompletionsRefs})
        > {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> colorIndex = const Value.absent(),
                Value<int> iconIndex = const Value.absent(),
                Value<int> scheduleBitmask = const Value.absent(),
                Value<int?> reminderMinutes = const Value.absent(),
                Value<bool> reminderEnabled = const Value.absent(),
                Value<int> statusIndex = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> groupId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                name: name,
                colorIndex: colorIndex,
                iconIndex: iconIndex,
                scheduleBitmask: scheduleBitmask,
                reminderMinutes: reminderMinutes,
                reminderEnabled: reminderEnabled,
                statusIndex: statusIndex,
                createdAt: createdAt,
                groupId: groupId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int colorIndex,
                required int iconIndex,
                required int scheduleBitmask,
                Value<int?> reminderMinutes = const Value.absent(),
                Value<bool> reminderEnabled = const Value.absent(),
                required int statusIndex,
                required DateTime createdAt,
                Value<String?> groupId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion.insert(
                id: id,
                name: name,
                colorIndex: colorIndex,
                iconIndex: iconIndex,
                scheduleBitmask: scheduleBitmask,
                reminderMinutes: reminderMinutes,
                reminderEnabled: reminderEnabled,
                statusIndex: statusIndex,
                createdAt: createdAt,
                groupId: groupId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$HabitsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({habitCompletionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (habitCompletionsRefs) db.habitCompletions,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (habitCompletionsRefs)
                    await $_getPrefetchedData<
                      HabitRow,
                      $HabitsTable,
                      HabitCompletionRow
                    >(
                      currentTable: table,
                      referencedTable: $$HabitsTableReferences
                          ._habitCompletionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$HabitsTableReferences(
                        db,
                        table,
                        p0,
                      ).habitCompletionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.habitId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsTable,
      HabitRow,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (HabitRow, $$HabitsTableReferences),
      HabitRow,
      PrefetchHooks Function({bool habitCompletionsRefs})
    >;
typedef $$HabitCompletionsTableCreateCompanionBuilder =
    HabitCompletionsCompanion Function({
      required String habitId,
      required DateTime date,
      required DateTime markedAt,
      Value<int> rowid,
    });
typedef $$HabitCompletionsTableUpdateCompanionBuilder =
    HabitCompletionsCompanion Function({
      Value<String> habitId,
      Value<DateTime> date,
      Value<DateTime> markedAt,
      Value<int> rowid,
    });

final class $$HabitCompletionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $HabitCompletionsTable,
          HabitCompletionRow
        > {
  $$HabitCompletionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HabitsTable _habitIdTable(_$AppDatabase db) => db.habits.createAlias(
    $_aliasNameGenerator(db.habitCompletions.habitId, db.habits.id),
  );

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<String>('habit_id')!;

    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HabitCompletionsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitCompletionsTable> {
  $$HabitCompletionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get markedAt => $composableBuilder(
    column: $table.markedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitCompletionsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitCompletionsTable> {
  $$HabitCompletionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get markedAt => $composableBuilder(
    column: $table.markedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableOrderingComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitCompletionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitCompletionsTable> {
  $$HabitCompletionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get markedAt =>
      $composableBuilder(column: $table.markedAt, builder: (column) => column);

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitCompletionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitCompletionsTable,
          HabitCompletionRow,
          $$HabitCompletionsTableFilterComposer,
          $$HabitCompletionsTableOrderingComposer,
          $$HabitCompletionsTableAnnotationComposer,
          $$HabitCompletionsTableCreateCompanionBuilder,
          $$HabitCompletionsTableUpdateCompanionBuilder,
          (HabitCompletionRow, $$HabitCompletionsTableReferences),
          HabitCompletionRow,
          PrefetchHooks Function({bool habitId})
        > {
  $$HabitCompletionsTableTableManager(
    _$AppDatabase db,
    $HabitCompletionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitCompletionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitCompletionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitCompletionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> habitId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> markedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitCompletionsCompanion(
                habitId: habitId,
                date: date,
                markedAt: markedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String habitId,
                required DateTime date,
                required DateTime markedAt,
                Value<int> rowid = const Value.absent(),
              }) => HabitCompletionsCompanion.insert(
                habitId: habitId,
                date: date,
                markedAt: markedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HabitCompletionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (habitId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.habitId,
                                referencedTable:
                                    $$HabitCompletionsTableReferences
                                        ._habitIdTable(db),
                                referencedColumn:
                                    $$HabitCompletionsTableReferences
                                        ._habitIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HabitCompletionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitCompletionsTable,
      HabitCompletionRow,
      $$HabitCompletionsTableFilterComposer,
      $$HabitCompletionsTableOrderingComposer,
      $$HabitCompletionsTableAnnotationComposer,
      $$HabitCompletionsTableCreateCompanionBuilder,
      $$HabitCompletionsTableUpdateCompanionBuilder,
      (HabitCompletionRow, $$HabitCompletionsTableReferences),
      HabitCompletionRow,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$UserProfileTableTableCreateCompanionBuilder =
    UserProfileTableCompanion Function({
      Value<int> id,
      required String displayName,
      Value<String?> avatarPath,
      Value<int> level,
      Value<int> xp,
      Value<bool> hardcoreMode,
      Value<int> themePreferenceIndex,
      Value<String> localeTag,
    });
typedef $$UserProfileTableTableUpdateCompanionBuilder =
    UserProfileTableCompanion Function({
      Value<int> id,
      Value<String> displayName,
      Value<String?> avatarPath,
      Value<int> level,
      Value<int> xp,
      Value<bool> hardcoreMode,
      Value<int> themePreferenceIndex,
      Value<String> localeTag,
    });

class $$UserProfileTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfileTableTable> {
  $$UserProfileTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hardcoreMode => $composableBuilder(
    column: $table.hardcoreMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get themePreferenceIndex => $composableBuilder(
    column: $table.themePreferenceIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localeTag => $composableBuilder(
    column: $table.localeTag,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfileTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfileTableTable> {
  $$UserProfileTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hardcoreMode => $composableBuilder(
    column: $table.hardcoreMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get themePreferenceIndex => $composableBuilder(
    column: $table.themePreferenceIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localeTag => $composableBuilder(
    column: $table.localeTag,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfileTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfileTableTable> {
  $$UserProfileTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => column,
  );

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  GeneratedColumn<bool> get hardcoreMode => $composableBuilder(
    column: $table.hardcoreMode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get themePreferenceIndex => $composableBuilder(
    column: $table.themePreferenceIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localeTag =>
      $composableBuilder(column: $table.localeTag, builder: (column) => column);
}

class $$UserProfileTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfileTableTable,
          UserProfileRow,
          $$UserProfileTableTableFilterComposer,
          $$UserProfileTableTableOrderingComposer,
          $$UserProfileTableTableAnnotationComposer,
          $$UserProfileTableTableCreateCompanionBuilder,
          $$UserProfileTableTableUpdateCompanionBuilder,
          (
            UserProfileRow,
            BaseReferences<
              _$AppDatabase,
              $UserProfileTableTable,
              UserProfileRow
            >,
          ),
          UserProfileRow,
          PrefetchHooks Function()
        > {
  $$UserProfileTableTableTableManager(
    _$AppDatabase db,
    $UserProfileTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfileTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfileTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfileTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> avatarPath = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<bool> hardcoreMode = const Value.absent(),
                Value<int> themePreferenceIndex = const Value.absent(),
                Value<String> localeTag = const Value.absent(),
              }) => UserProfileTableCompanion(
                id: id,
                displayName: displayName,
                avatarPath: avatarPath,
                level: level,
                xp: xp,
                hardcoreMode: hardcoreMode,
                themePreferenceIndex: themePreferenceIndex,
                localeTag: localeTag,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String displayName,
                Value<String?> avatarPath = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<bool> hardcoreMode = const Value.absent(),
                Value<int> themePreferenceIndex = const Value.absent(),
                Value<String> localeTag = const Value.absent(),
              }) => UserProfileTableCompanion.insert(
                id: id,
                displayName: displayName,
                avatarPath: avatarPath,
                level: level,
                xp: xp,
                hardcoreMode: hardcoreMode,
                themePreferenceIndex: themePreferenceIndex,
                localeTag: localeTag,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfileTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfileTableTable,
      UserProfileRow,
      $$UserProfileTableTableFilterComposer,
      $$UserProfileTableTableOrderingComposer,
      $$UserProfileTableTableAnnotationComposer,
      $$UserProfileTableTableCreateCompanionBuilder,
      $$UserProfileTableTableUpdateCompanionBuilder,
      (
        UserProfileRow,
        BaseReferences<_$AppDatabase, $UserProfileTableTable, UserProfileRow>,
      ),
      UserProfileRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$HabitCompletionsTableTableManager get habitCompletions =>
      $$HabitCompletionsTableTableManager(_db, _db.habitCompletions);
  $$UserProfileTableTableTableManager get userProfileTable =>
      $$UserProfileTableTableTableManager(_db, _db.userProfileTable);
}
