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

resource "aws_sqs_queue_policy" "worker_input_queue_policy" {
  queue_url = aws_sqs_queue.worker_input_queue.url

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = "*",
      Action    = "sqs:SendMessage",
      Resource  = aws_sqs_queue.worker_input_queue.arn,
      Condition = {
        ArnEquals = {
          "aws:SourceArn" = aws_sns_topic.input_topic.arn
        }
      }
    }]
  })

  depends_on = [
    aws_sns_topic.input_topic,
    aws_sqs_queue.worker_input_queue
  ]
}

resource "aws_sqs_queue_policy" "worker_output_queue_policy" {
  queue_url = aws_sqs_queue.worker_output_queue.url

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = "*",
      Action    = "sqs:SendMessage",
      Resource  = aws_sqs_queue.worker_output_queue.arn,
      Condition = {
        ArnEquals = {
          "aws:SourceArn" = aws_sns_topic.output_topic.arn
        }
      }
    }]
  })

  depends_on = [
    aws_sns_topic.output_topic,
    aws_sqs_queue.worker_input_queue
  ]
}

resource "aws_sqs_queue_policy" "api_input_queue_policy" {
  queue_url = aws_sqs_queue.api_input_queue.url

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = "*",
      Action    = "sqs:SendMessage",
      Resource  = aws_sqs_queue.api_input_queue.arn,
      Condition = {
        ArnEquals = {
          "aws:SourceArn" = aws_sns_topic.input_topic.arn
        }
      }
    }]
  })

  depends_on = [
    aws_sns_topic.input_topic,
    aws_sqs_queue.worker_input_queue
  ]
}

resource "aws_sqs_queue_policy" "api_output_queue_policy" {
  queue_url = aws_sqs_queue.api_output_queue.url

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = "*",
      Action    = "sqs:SendMessage",
      Resource  = aws_sqs_queue.api_output_queue.arn,
      Condition = {
        ArnEquals = {
          "aws:SourceArn" = aws_sns_topic.output_topic.arn
        }
      }
    }]
  })

  depends_on = [
    aws_sns_topic.output_topic,
    aws_sqs_queue.api_input_queue
  ]
}