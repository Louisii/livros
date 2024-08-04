import 'package:equatable/equatable.dart';

// Base class for form status
abstract class FormStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

// Form is in progress
class FormSubmitting extends FormStatus {}

// Form submission succeeded
class FormSubmissionSuccess extends FormStatus {}

// Form submission failed
class FormSubmissionFailed extends FormStatus {
  final String error;

  FormSubmissionFailed(this.error);

  @override
  List<Object?> get props => [error];
}

// Form validation error
class FormValidationError extends FormStatus {
  final String error;

  FormValidationError(this.error);

  @override
  List<Object?> get props => [error];
}
