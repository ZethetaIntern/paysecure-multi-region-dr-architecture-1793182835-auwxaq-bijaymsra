#########################################
# General
#########################################

variable "name" {
  description = "VPC name"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

#########################################
# VPC
#########################################

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

#########################################
# Availability Zones
#########################################

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
}

#########################################
# Public Subnets
#########################################

variable "public_subnets" {
  description = "Public Subnets"
  type        = list(string)
}

#########################################
# Private Application Subnets
#########################################

variable "private_app_subnets" {
  description = "Private Application Subnets"
  type        = list(string)
}

#########################################
# Private Database Subnets
#########################################

variable "private_db_subnets" {
  description = "Private Database Subnets"
  type        = list(string)
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Tags"
  type        = map(string)
}
