resource "aws_ecr_repository" "appointment_service" {
  name = "appointment-service"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "appointment-service-ecr"
    Environment = "dev"
  }
}
