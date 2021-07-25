resource "aws_instance" "example" {
    ami = "ami-0c8ad4b0ff2d20c79"
    instance_type = "t2.micro"
}