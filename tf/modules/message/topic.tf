resource "aws_sns_topic" "input_topic" {
  name = "InputTopic"
}

resource "aws_sns_topic" "output_topic" {
  name = "OutputTopic"
}