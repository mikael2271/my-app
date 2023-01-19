enum RulesValidationError {
  empty,
  invalid,
} //rules from input

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
} // states used in bloc to handle requests to api
