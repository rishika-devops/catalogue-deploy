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
variable "iam_instance_profile" {
    default = "admin-role"
}
variable "zone_name" {
    default = "sowjanyaaws.online"
}
variable "app_version" {

}