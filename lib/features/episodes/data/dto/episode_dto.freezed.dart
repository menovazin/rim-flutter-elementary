// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'episode_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EpisodeDto {

 int get id; String get name;@JsonKey(name: 'air_date') String get airDate; String get episode; List<String> get characters;
/// Create a copy of EpisodeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EpisodeDtoCopyWith<EpisodeDto> get copyWith => _$EpisodeDtoCopyWithImpl<EpisodeDto>(this as EpisodeDto, _$identity);

  /// Serializes this EpisodeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EpisodeDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.airDate, airDate) || other.airDate == airDate)&&(identical(other.episode, episode) || other.episode == episode)&&const DeepCollectionEquality().equals(other.characters, characters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,airDate,episode,const DeepCollectionEquality().hash(characters));

@override
String toString() {
  return 'EpisodeDto(id: $id, name: $name, airDate: $airDate, episode: $episode, characters: $characters)';
}


}

/// @nodoc
abstract mixin class $EpisodeDtoCopyWith<$Res>  {
  factory $EpisodeDtoCopyWith(EpisodeDto value, $Res Function(EpisodeDto) _then) = _$EpisodeDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name,@JsonKey(name: 'air_date') String airDate, String episode, List<String> characters
});




}
/// @nodoc
class _$EpisodeDtoCopyWithImpl<$Res>
    implements $EpisodeDtoCopyWith<$Res> {
  _$EpisodeDtoCopyWithImpl(this._self, this._then);

  final EpisodeDto _self;
  final $Res Function(EpisodeDto) _then;

/// Create a copy of EpisodeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? airDate = null,Object? episode = null,Object? characters = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,airDate: null == airDate ? _self.airDate : airDate // ignore: cast_nullable_to_non_nullable
as String,episode: null == episode ? _self.episode : episode // ignore: cast_nullable_to_non_nullable
as String,characters: null == characters ? _self.characters : characters // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [EpisodeDto].
extension EpisodeDtoPatterns on EpisodeDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EpisodeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EpisodeDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EpisodeDto value)  $default,){
final _that = this;
switch (_that) {
case _EpisodeDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EpisodeDto value)?  $default,){
final _that = this;
switch (_that) {
case _EpisodeDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'air_date')  String airDate,  String episode,  List<String> characters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EpisodeDto() when $default != null:
return $default(_that.id,_that.name,_that.airDate,_that.episode,_that.characters);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'air_date')  String airDate,  String episode,  List<String> characters)  $default,) {final _that = this;
switch (_that) {
case _EpisodeDto():
return $default(_that.id,_that.name,_that.airDate,_that.episode,_that.characters);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name, @JsonKey(name: 'air_date')  String airDate,  String episode,  List<String> characters)?  $default,) {final _that = this;
switch (_that) {
case _EpisodeDto() when $default != null:
return $default(_that.id,_that.name,_that.airDate,_that.episode,_that.characters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EpisodeDto implements EpisodeDto {
  const _EpisodeDto({this.id = 0, this.name = '', @JsonKey(name: 'air_date') this.airDate = '', this.episode = '', final  List<String> characters = const <String>[]}): _characters = characters;
  factory _EpisodeDto.fromJson(Map<String, dynamic> json) => _$EpisodeDtoFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String name;
@override@JsonKey(name: 'air_date') final  String airDate;
@override@JsonKey() final  String episode;
 final  List<String> _characters;
@override@JsonKey() List<String> get characters {
  if (_characters is EqualUnmodifiableListView) return _characters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_characters);
}


/// Create a copy of EpisodeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EpisodeDtoCopyWith<_EpisodeDto> get copyWith => __$EpisodeDtoCopyWithImpl<_EpisodeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EpisodeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EpisodeDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.airDate, airDate) || other.airDate == airDate)&&(identical(other.episode, episode) || other.episode == episode)&&const DeepCollectionEquality().equals(other._characters, _characters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,airDate,episode,const DeepCollectionEquality().hash(_characters));

@override
String toString() {
  return 'EpisodeDto(id: $id, name: $name, airDate: $airDate, episode: $episode, characters: $characters)';
}


}

/// @nodoc
abstract mixin class _$EpisodeDtoCopyWith<$Res> implements $EpisodeDtoCopyWith<$Res> {
  factory _$EpisodeDtoCopyWith(_EpisodeDto value, $Res Function(_EpisodeDto) _then) = __$EpisodeDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name,@JsonKey(name: 'air_date') String airDate, String episode, List<String> characters
});




}
/// @nodoc
class __$EpisodeDtoCopyWithImpl<$Res>
    implements _$EpisodeDtoCopyWith<$Res> {
  __$EpisodeDtoCopyWithImpl(this._self, this._then);

  final _EpisodeDto _self;
  final $Res Function(_EpisodeDto) _then;

/// Create a copy of EpisodeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? airDate = null,Object? episode = null,Object? characters = null,}) {
  return _then(_EpisodeDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,airDate: null == airDate ? _self.airDate : airDate // ignore: cast_nullable_to_non_nullable
as String,episode: null == episode ? _self.episode : episode // ignore: cast_nullable_to_non_nullable
as String,characters: null == characters ? _self._characters : characters // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$EpisodeResponseDto {

 InfoDto get info; List<EpisodeDto> get results;
/// Create a copy of EpisodeResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EpisodeResponseDtoCopyWith<EpisodeResponseDto> get copyWith => _$EpisodeResponseDtoCopyWithImpl<EpisodeResponseDto>(this as EpisodeResponseDto, _$identity);

  /// Serializes this EpisodeResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EpisodeResponseDto&&(identical(other.info, info) || other.info == info)&&const DeepCollectionEquality().equals(other.results, results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,info,const DeepCollectionEquality().hash(results));

@override
String toString() {
  return 'EpisodeResponseDto(info: $info, results: $results)';
}


}

/// @nodoc
abstract mixin class $EpisodeResponseDtoCopyWith<$Res>  {
  factory $EpisodeResponseDtoCopyWith(EpisodeResponseDto value, $Res Function(EpisodeResponseDto) _then) = _$EpisodeResponseDtoCopyWithImpl;
@useResult
$Res call({
 InfoDto info, List<EpisodeDto> results
});


$InfoDtoCopyWith<$Res> get info;

}
/// @nodoc
class _$EpisodeResponseDtoCopyWithImpl<$Res>
    implements $EpisodeResponseDtoCopyWith<$Res> {
  _$EpisodeResponseDtoCopyWithImpl(this._self, this._then);

  final EpisodeResponseDto _self;
  final $Res Function(EpisodeResponseDto) _then;

/// Create a copy of EpisodeResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? info = null,Object? results = null,}) {
  return _then(_self.copyWith(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as InfoDto,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<EpisodeDto>,
  ));
}
/// Create a copy of EpisodeResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InfoDtoCopyWith<$Res> get info {
  
  return $InfoDtoCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}


/// Adds pattern-matching-related methods to [EpisodeResponseDto].
extension EpisodeResponseDtoPatterns on EpisodeResponseDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EpisodeResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EpisodeResponseDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EpisodeResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _EpisodeResponseDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EpisodeResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _EpisodeResponseDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( InfoDto info,  List<EpisodeDto> results)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EpisodeResponseDto() when $default != null:
return $default(_that.info,_that.results);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( InfoDto info,  List<EpisodeDto> results)  $default,) {final _that = this;
switch (_that) {
case _EpisodeResponseDto():
return $default(_that.info,_that.results);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( InfoDto info,  List<EpisodeDto> results)?  $default,) {final _that = this;
switch (_that) {
case _EpisodeResponseDto() when $default != null:
return $default(_that.info,_that.results);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EpisodeResponseDto implements EpisodeResponseDto {
  const _EpisodeResponseDto({this.info = const InfoDto(), final  List<EpisodeDto> results = const <EpisodeDto>[]}): _results = results;
  factory _EpisodeResponseDto.fromJson(Map<String, dynamic> json) => _$EpisodeResponseDtoFromJson(json);

@override@JsonKey() final  InfoDto info;
 final  List<EpisodeDto> _results;
@override@JsonKey() List<EpisodeDto> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}


/// Create a copy of EpisodeResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EpisodeResponseDtoCopyWith<_EpisodeResponseDto> get copyWith => __$EpisodeResponseDtoCopyWithImpl<_EpisodeResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EpisodeResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EpisodeResponseDto&&(identical(other.info, info) || other.info == info)&&const DeepCollectionEquality().equals(other._results, _results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,info,const DeepCollectionEquality().hash(_results));

@override
String toString() {
  return 'EpisodeResponseDto(info: $info, results: $results)';
}


}

/// @nodoc
abstract mixin class _$EpisodeResponseDtoCopyWith<$Res> implements $EpisodeResponseDtoCopyWith<$Res> {
  factory _$EpisodeResponseDtoCopyWith(_EpisodeResponseDto value, $Res Function(_EpisodeResponseDto) _then) = __$EpisodeResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 InfoDto info, List<EpisodeDto> results
});


@override $InfoDtoCopyWith<$Res> get info;

}
/// @nodoc
class __$EpisodeResponseDtoCopyWithImpl<$Res>
    implements _$EpisodeResponseDtoCopyWith<$Res> {
  __$EpisodeResponseDtoCopyWithImpl(this._self, this._then);

  final _EpisodeResponseDto _self;
  final $Res Function(_EpisodeResponseDto) _then;

/// Create a copy of EpisodeResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? info = null,Object? results = null,}) {
  return _then(_EpisodeResponseDto(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as InfoDto,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<EpisodeDto>,
  ));
}

/// Create a copy of EpisodeResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InfoDtoCopyWith<$Res> get info {
  
  return $InfoDtoCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}

// dart format on
