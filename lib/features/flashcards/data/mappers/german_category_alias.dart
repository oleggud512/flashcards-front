import 'package:flashcards/features/flashcards/domain/entities/german_category_alias.dart';

const _noun = 'noun';
const _adjective = 'adjective';
const _regularVerb = 'regular_verb';
const _irregularVerb = 'irregular_verb';
const _pronoun = 'pronoun';
const _adverb = 'adverb';
const _preposition = 'preposition';
const _conjunction = 'conjunction';
const _modalParticle = 'modal_particle';
const _interjection = 'interjection';
const _fixedConstruction = 'fixed_construction';

extension type GermanCategoryAliasStr(String str) {
  GermanCategoryAlias? toDomain() => switch (str.toLowerCase().trim()) {
    _noun => .noun,
    _adjective => .adjective,
    _regularVerb => .regularVerb,
    _irregularVerb => .irregularVerb,
    _pronoun => .pronoun,
    _adverb => .adverb,
    _preposition => .preposition,
    _conjunction => .conjunction,
    _modalParticle => .modalParticle,
    _interjection => .interjection,
    _fixedConstruction => .fixedConstruction,
    _ => null,
  };
}

extension GermanCategoryAliasMapper on GermanCategoryAlias {
  String toData() => switch (this) {
    .noun => _noun,
    .adjective => _adjective,
    .regularVerb => _regularVerb,
    .irregularVerb => _irregularVerb,
    .pronoun => _pronoun,
    .adverb => _adverb,
    .preposition => _preposition,
    .conjunction => _conjunction,
    .modalParticle => _modalParticle,
    .interjection => _interjection,
    .fixedConstruction => _fixedConstruction,
  };
}
