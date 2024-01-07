resource "aws_instance" "web" {
  ami           = "ami-03265a0778a880afb"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.roboshop-all.id]

  tags = {
    Name = "Provisioners"
  }

  provisioner "local-exec" {
      command = "echo The server's IP address is ${self.private_ip}"
  }

  connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "echo 'this is from remote exec' > /temp/remote.txt",
      "sudo yum install nginx -y",
      "sudo systemctl start nginx ",
    ]
  }

}

resource "aws_security_group" "roboshop-all" { 
    name        = "provisionars"
    description = "provisionars"
   

    ingress {
        description      = "Allow All port 22"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        
    }

    ingress {
        description      = "Allow All port 80"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        #ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "provisionars"
    }
}