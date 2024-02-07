source "amazon-ebs" "kubernetes-base" {
  region        = var.region
  instance_type = var.instance_type
  ssh_username  = "ec2-user"
  ami_name      = "kubernetes-base-${var.environment}-${formatdate("YYYYMMDDHHmmss", timestamp())}"

  vpc_id = var.vpc_id

  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-gp2"
      "virtualization-type" = "hvm"
    }
    owners      = ["amazon"]
    most_recent = true
  }

  tags = {
    Name = "kubernetes-base-${var.environment}-${formatdate("YYYYMMDDHHmmss", timestamp())}"
    Environment = var.environment
    Owner = "Packer"
    BaseAMI = "Amazon Linux 2"
    Instance = var.instance_type
  }
}

build {
  sources = [
    "source.amazon-ebs.kubernetes-base"
  ]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",

      # docker
      "sudo yum install -y docker",
      "sudo systemctl enable docker",
      "sudo systemctl start docker",
      "sudo usermod -a -G docker ec2-user",
    
      # kubernetes
      "sudo yum install -y amazon-ssm-agent",
      "sudo systemctl enable amazon-ssm-agent",
      "sudo systemctl start amazon-ssm-agent",
      
      "sudo yum install -y kubectl",
      "sudo systemctl enable kubelet",
    ]
  }
}
