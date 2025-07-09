resource "aws_sns_topic_subscription" "sub_worker_input_queue" {
  topic_arn = aws_sns_topic.input_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.worker_input_queue.arn

  depends_on = [
    aws_sns_topic.input_topic,
    aws_sqs_queue.worker_input_queue,
  ]
}

resource "aws_sns_topic_subscription" "sub_worker_output_queue" {
  topic_arn = aws_sns_topic.output_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.worker_output_queue.arn

  depends_on = [
    aws_sns_topic.output_topic,
    aws_sqs_queue.worker_output_queue,
  ]
}

resource "aws_sns_topic_subscription" "sub_api_input_queue" {
  topic_arn = aws_sns_topic.input_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.api_input_queue.arn

  depends_on = [
    aws_sns_topic.input_topic,
    aws_sqs_queue.api_input_queue,
  ]
}

resource "aws_sns_topic_subscription" "sub_api_output_queue" {
  topic_arn = aws_sns_topic.output_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.api_output_queue.arn

  depends_on = [
    aws_sns_topic.output_topic,
    aws_sqs_queue.api_output_queue,
  ]
}