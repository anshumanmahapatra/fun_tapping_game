final String tablePlay = 'playStats';

class PlayFields {
  static final List<String> values = [
    id,
    totalGames,
    player1Wins,
    player2Wins,
    player1Streak,
    player2Streak,
    player1CurrentStreak,
    player2CurrentStreak,
  ];

  static final String id = '_id';
  static final String totalGames = 'totalGames';
  static final String player1Wins = 'player1Wins';
  static final String player2Wins = 'player2Wins';
  static final String player1Streak = 'player1Streak';
  static final String player2Streak = 'player2Streak';
  static final String player1CurrentStreak = 'player1CurrentStreak';
  static final String player2CurrentStreak = 'player2CurrentStreak';
}

class PlayModel {
  final int? id;
  final int totalGames;
  final int player1Wins;
  final int player2Wins;
  final int player1Streak;
  final int player2Streak;
  final int player1CurrentStreak;
  final int player2CurrentStreak;

  const PlayModel({
    this.id,
    required this.totalGames,
    required this.player1Wins,
    required this.player2Wins,
    required this.player1Streak,
    required this.player2Streak,
    required this.player1CurrentStreak,
    required this.player2CurrentStreak,
  });

  PlayModel copy({
    int? id,
    int? totalGames,
    int? player1Wins,
    int? player2Wins,
    int? player1Streak,
    int? player2Streak,
    int? player1CurrentStreak,
    int? player2CurrentStreak,
  }) =>
      PlayModel(
          id: id ?? this.id,
          totalGames: totalGames ?? this.totalGames,
          player1Wins: player1Wins ?? this.player1Wins,
          player2Wins: player2Wins ?? this.player2Wins,
          player1Streak: player1Streak ?? this.player1Streak,
          player2Streak: player2Streak ?? this.player2Streak,
          player1CurrentStreak:
              player1CurrentStreak ?? this.player1CurrentStreak,
          player2CurrentStreak:
              player2CurrentStreak ?? this.player2CurrentStreak);

  static PlayModel fromJson(Map<String, Object?> json) => PlayModel(
        id: json[PlayFields.id] as int?,
        totalGames: json[PlayFields.totalGames] as int,
        player1Wins: json[PlayFields.player1Wins] as int,
        player2Wins: json[PlayFields.player2Wins] as int,
        player1Streak: json[PlayFields.player1Streak] as int,
        player2Streak: json[PlayFields.player2Streak] as int,
        player1CurrentStreak: json[PlayFields.player1CurrentStreak] as int,
        player2CurrentStreak: json[PlayFields.player2CurrentStreak] as int,
      );

  Map<String, Object?> toJson() => {
        PlayFields.id: id,
        PlayFields.totalGames: totalGames,
        PlayFields.player1Wins: player1Wins,
        PlayFields.player2Wins: player2Wins,
        PlayFields.player1Streak: player1Streak,
        PlayFields.player2Streak: player2Streak,
        PlayFields.player1CurrentStreak: player1CurrentStreak,
        PlayFields.player2CurrentStreak: player2CurrentStreak,
      };
}
