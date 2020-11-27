output "cw-output" {
  value = <<OUTPUT

  #############
  ## OUTPUTS ##
  #############

  ## SSH ##
  ssh ubuntu@${aws_eip.cw-eip-1.public_ip}

  ## WebUI ##
  https://${aws_eip.cw-eip-1.public_ip}/guacamole/

  ## Update Git ##
  mv aws.tfvars pvars.tfvars
  git pull
  diff pvars.tfvars aws.tfvars
  mv pvars.tfvars aws.tfvars
  terraform apply -var-file="cw.tfvars"

  ## Ansible Playbook Rerun ##
  ~/.local/bin/aws ssm start-associations-once --region ${var.aws_region} --association-ids ${aws_ssm_association.cw-ssm-assoc.association_id}
  OUTPUT
}
