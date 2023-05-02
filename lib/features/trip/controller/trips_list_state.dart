// import 'package:flutter/material.dart';

// @immutable
// class TripsListState {
//   final String selectedAnswer;
//   final List<QuizQuestion> correct;
//   final List<QuizQuestion> incorrect;
//   final QuizStatus status;

//   bool get answered =>
//       status == QuizStatus.incorrect || status == QuizStatus.correct;

//   const TripsListState({
//     required this.selectedAnswer,
//     required this.correct,
//     required this.incorrect,
//     required this.status,
//   });

//   factory TripsListState.initial() {
//     return const TripsListState(
//       selectedAnswer: '',
//       correct: [],
//       incorrect: [],
//       status: QuizStatus.initial,
//     );
//   }

//   TripsListState copyWith({
//     String? selectedAnswer,
//     List<QuizQuestion>? correct,
//     List<QuizQuestion>? incorrect,
//     QuizStatus? status,
//   }) {
//     return TripsListState(
//       selectedAnswer: selectedAnswer ?? this.selectedAnswer,
//       correct: correct ?? this.correct,
//       incorrect: incorrect ?? this.incorrect,
//       status: status ?? this.status,
//     );
//   }
// }