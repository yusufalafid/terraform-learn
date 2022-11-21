variable "project_name" {
    type = string
    default = "development-367406"
}

variable "region" {
    type = string
    default = "us-central1"
}

variable "zone" {
    type = string
    default = "us-central1-c"
}

variable "flavor" {
    type = string
    default = "e2-medium"
}

variable "osimage" {
    type = string
    default = "ubuntu-minimal-2004-lts"
}

variable "network_name" {
    type = string
    default = "bastion-network"
}

variable "vm_name" {
    type = string
    default = "bastion"
}