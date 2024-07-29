variable "common_tags" {
    default = {
        environment = "dev"
        project = "roboshop"
        terraform = "true"
    }
}
variable "project_name" {
    default = "roboshop"
}
variable "environment" {
    default = "dev"
}
variable "tags" {
    default = {
        Component = "catalogue"
    }
}
variable "zone_name" {
    default = "sowjanyaaws.online"
}
variable "app_version" {
    
}