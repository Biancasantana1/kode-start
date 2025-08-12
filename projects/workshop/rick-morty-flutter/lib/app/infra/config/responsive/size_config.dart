import 'package:flutter/widgets.dart';

class SizeConfig {
  SizeConfig({
    required this.designScreenWidth,
    required this.designScreenHeight,
  });

  /// Valor de [largura] da tela do design
  int designScreenWidth;

  /// Valor de [altura] da tela do design
  int designScreenHeight;

  /// Largura da tela atual
  static double? _screenWidth;

  /// Altura da tela atual
  static double? _screenHeight;

  /// Valor de inicialização do tamanho de fonte
  static double? textMultiplier;

  /// Valor de inicialização do tamanho de imagem
  static double? imageSizeMultiplier;

  /// Valor de inicialização da altura
  static double? heightMultiplier;

  /// Valor de inicialização da largura
  static double? widthMultiplier;

  /// Verificar se está no modo retrato
  static bool isPortrait = true;

  /// Método para inicializar o SizeConfig com valores baseados no layout atual
  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
    }

    // Cálculos baseados nas proporções da tela em relação ao design original
    heightMultiplier = (_screenHeight! / designScreenHeight);
    widthMultiplier = (_screenWidth! / designScreenWidth);
    textMultiplier = widthMultiplier; // Ajuste de fontes
  }
}

extension Responsive on num {
  /// Para obter a altura proporcional ao design
  double get height => SizeConfig.heightMultiplier! * this;

  /// Para obter a largura proporcional ao design
  double get width => SizeConfig.widthMultiplier! * this;

  /// Para obter o tamanho de fonte proporcional ao design
  double get fontSize => SizeConfig.textMultiplier! * this;
}
