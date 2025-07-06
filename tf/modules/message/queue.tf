resource "aws_sqs_queue" "worker_input_queue" {
  name                       = "WorkerInputQueue"
  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400
  delay_seconds              = 1
  receive_wait_time_seconds  = 0

  depends_on = [
    aws_sns_topic.input_topic
  ]
}

resource "aws_sqs_queue" "worker_output_queue" {
  name                       = "WorkerOutputQueue"
  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400
  delay_seconds              = 1
  receive_wait_time_seconds  = 0

  depends_on = [
    aws_sns_topic.output_topic
  ]
}

resource "aws_sqs_queue" "api_input_queue" {
  name                       = "ApiInputQueue"
  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400
  delay_seconds              = 1
  receive_wait_time_seconds  = 0

  depends_on = [
    aws_sns_topic.input_topic
  ]
}

resource "aws_sqs_queue" "api_output_queue" {
  name                       = "ApiOutputQueue"
  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400
  delay_seconds              = 1
  receive_wait_time_seconds  = 0

  depends_on = [
    aws_sns_topic.output_topic
  ]
}
