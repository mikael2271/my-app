enum RulesValidationError {
  empty,
  invalid,
} //usado nas regras dos inputs

enum SubmissionState {
  empty,
  pure,
  valid,
  invalid,
  custom,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
  submissionServerError
} // usado no handler quando é feito um pedido à api