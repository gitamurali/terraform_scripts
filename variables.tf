# variable.tf 

# No default value
variable "instance_type" {
   type = string
   description = "t2.micro"
}

# No default value
variable "tag" {
   type = string
   description = "The tag for the EC2 instance"
}

# default value for the variable location
variable "location" {
   type = string
   description = "The project region"
   default = "us-east-1"
}
