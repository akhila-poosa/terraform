variable "instances" {
    default = {
        mongodb = "t3.micro"
        redis = "t3.micro"
    } 
}

variable "zone_id" {
    default = "Z08544841KFKOJ4HN9E5S"
}

variable "domain_name" {
    default = "zealful.space"
}