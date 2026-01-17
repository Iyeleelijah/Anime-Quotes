import '../../data/models/quotes.dart';
import '../quotes/naruto.dart' as naruto;
import '../quotes/one_piece.dart' as onepiece;
import '../quotes/demon_slayer.dart' as demon_slayer;
import '../quotes/vinland_saga.dart' as vinland;
import '../quotes/aot.dart' as aot;
import '../quotes/jujutsu.dart' as jujutsu;



final Map<String, List<Quote>> quotesByCategory = {
  'naruto': naruto.naruto,
  'onepiece': onepiece.onepiece,
  'demonslayer': demon_slayer.demonslayer,
  'vinland': vinland.vinland,
  'aot': aot.aot,
  'jujutsu': jujutsu.jujutsu,
};
