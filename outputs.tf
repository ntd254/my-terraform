output "region" {
  description = "AWS Region"
  value       = data.aws_region.current.name
}
