variable "instances" {
    default = [ "mongodb", "redis", "mysql", "rabbitmq" ]
}

variable "zone_id" {
    default = "Z08544841KFKOJ4HN9E5S"
}

variable "domain_name" {
    default = "zealful.space"
}