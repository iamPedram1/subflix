import 'dart:math';

import 'package:subflix/features/shared/domain/models/app_language.dart';
import 'package:subflix/features/subtitles/domain/models/subtitle_line.dart';

class MockTranslationComposer {
  static const List<String> _seedLines = <String>[
    'Keep the channel open. We only get one clean shot at this.',
    'The city looks different when you finally slow down enough to notice.',
    'If this works, nobody outside this room will ever know how close we came.',
    'I need the full file before sunrise, not a promise.',
    'You can feel the tension in the silence right before everything changes.',
    'We crossed every line just to make sure they had a way home.',
    'No hero speech. Just tell me the truth and we move.',
    'That signal was not random. Someone wanted us to find it.',
    'The first draft was chaos, but the final cut feels inevitable.',
    'If we miss this window, the whole plan starts over from zero.',
    'Trust the subtitles. They carry more than dialogue tonight.',
    'This is the part where the impossible starts sounding practical.',
  ];

  static const Map<String, Map<AppLanguage, String>>
  _directTranslations = <String, Map<AppLanguage, String>>{
    'Keep the channel open. We only get one clean shot at this.': <AppLanguage, String>{
      AppLanguage.spanish:
          'Mantengan el canal abierto. Solo tenemos una oportunidad limpia para hacerlo.',
      AppLanguage.arabic: 'ابقوا القناة مفتوحة. لدينا محاولة واحدة نظيفة فقط.',
      AppLanguage.french:
          'Gardez le canal ouvert. Nous n avons qu une seule tentative propre.',
      AppLanguage.german:
          'Haltet den Kanal offen. Wir haben nur einen sauberen Versuch.',
      AppLanguage.portuguese:
          'Mantenham o canal aberto. Temos apenas uma tentativa limpa.',
      AppLanguage.turkish:
          'Hatti acik tutun. Bunu yapmak icin sadece tek temiz sansimiz var.',
    },
    'The city looks different when you finally slow down enough to notice.':
        <AppLanguage, String>{
          AppLanguage.spanish:
              'La ciudad se ve distinta cuando por fin bajas el ritmo y la observas.',
          AppLanguage.arabic:
              'تبدو المدينة مختلفة عندما تتمهل اخيرا بما يكفي لتلاحظها.',
          AppLanguage.french:
              'La ville parait differente quand tu ralentis enfin assez pour la voir.',
          AppLanguage.german:
              'Die Stadt sieht anders aus, wenn du endlich langsam genug wirst, um sie zu bemerken.',
          AppLanguage.portuguese:
              'A cidade parece diferente quando voce finalmente desacelera para nota la.',
          AppLanguage.turkish:
              'Sehir, sonunda fark edecek kadar yavasladiginda baska gorunuyor.',
        },
    'If this works, nobody outside this room will ever know how close we came.':
        <AppLanguage, String>{
          AppLanguage.spanish:
              'Si esto funciona, nadie fuera de esta sala sabra lo cerca que estuvimos.',
          AppLanguage.arabic:
              'إذا نجح هذا فلن يعرف احد خارج هذه الغرفة كم اقتربنا.',
          AppLanguage.french:
              'Si ca marche, personne hors de cette piece ne saura a quel point nous etions proches.',
          AppLanguage.german:
              'Wenn das funktioniert, wird niemand ausserhalb dieses Raums je wissen, wie knapp es war.',
          AppLanguage.portuguese:
              'Se isso der certo, ninguem fora desta sala vai saber o quao perto chegamos.',
          AppLanguage.turkish:
              'Bu ise yararsa, bu odanin disinda kimse ne kadar yaklastigimizi bilmeyecek.',
        },
    'I need the full file before sunrise, not a promise.': <AppLanguage, String>{
      AppLanguage.spanish:
          'Necesito el archivo completo antes del amanecer, no una promesa.',
      AppLanguage.arabic: 'اريد الملف كاملا قبل شروق الشمس وليس وعدا.',
      AppLanguage.french:
          'J ai besoin du fichier complet avant l aube, pas d une promesse.',
      AppLanguage.german:
          'Ich brauche die komplette Datei vor Sonnenaufgang, nicht nur ein Versprechen.',
      AppLanguage.portuguese:
          'Eu preciso do arquivo completo antes do amanhecer, nao de uma promessa.',
      AppLanguage.turkish:
          'Gunes dogmadan once bana tum dosya lazim, soz degil.',
    },
  };

  List<SubtitleLine> buildCatalogLines({
    required String title,
    required AppLanguage targetLanguage,
    int count = 12,
  }) {
    final startIndex = title.hashCode.abs() % _seedLines.length;
    return List<SubtitleLine>.generate(count, (index) {
      final text = _seedLines[(startIndex + index) % _seedLines.length];
      final startMs = index * 5200;
      final endMs = startMs + 3600 + (index % 3 * 250);
      return SubtitleLine(
        index: index + 1,
        startMs: startMs,
        endMs: endMs,
        originalText: text,
        translatedText: translateText(text, targetLanguage),
      );
    });
  }

  List<SubtitleLine> buildUploadedLines(
    List<SubtitleLine> lines,
    AppLanguage targetLanguage,
  ) {
    return lines
        .map(
          (line) => line.copyWith(
            translatedText: translateText(line.originalText, targetLanguage),
          ),
        )
        .toList(growable: false);
  }

  String translateText(String text, AppLanguage targetLanguage) {
    if (targetLanguage == AppLanguage.english) {
      return text;
    }

    final direct = _directTranslations[text]?[targetLanguage];
    if (direct != null) {
      return direct;
    }

    final opener = switch (targetLanguage) {
      AppLanguage.spanish => 'Version ${targetLanguage.label}: ',
      AppLanguage.persian => '\u0646\u0633\u062e\u0629 ${targetLanguage.label}: ',
      AppLanguage.arabic => 'نسخة ${targetLanguage.label}: ',
      AppLanguage.french => 'Version ${targetLanguage.label} : ',
      AppLanguage.german => '${targetLanguage.label}-Fassung: ',
      AppLanguage.portuguese => 'Versao ${targetLanguage.label}: ',
      AppLanguage.japanese => '${targetLanguage.nativeLabel}版: ',
      AppLanguage.chinese => '${targetLanguage.nativeLabel}\u7248\u672c: ',
      AppLanguage.korean => '${targetLanguage.nativeLabel} 버전: ',
      AppLanguage.hindi => '${targetLanguage.nativeLabel} संस्करण: ',
      AppLanguage.turkish => '${targetLanguage.label} surumu: ',
      AppLanguage.english => '',
    };

    return '$opener$text';
  }

  Duration estimateDuration(List<SubtitleLine> lines) {
    final maxEnd = lines.map((line) => line.endMs).fold<int>(0, max);
    return Duration(milliseconds: maxEnd);
  }
}
