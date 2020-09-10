variable environment {}
variable location {}
variable resource_group_name {}

variable area1_common_tags {}
variable area2_common_tags {}

variable acr_reader_user_client_id {}
variable acr_reader_user_secret_key {}

variable auto_scaling_max_count {
  type        = map(number)
  description = "Max count for autoscaling"
  default = {
    dev = 1
    qa  = 1
    hlg = 1
    prd = 5
  }
}

variable auto_scaling_min_count {
  type        = map(number)
  description = "Min count for autoscaling"
  default = {
    dev = 1
    qa  = 1
    hlg = 1
    prd = 5
  }
}

variable auto_scaling_default_node_count {
  type        = map(number)
  description = "Default node count"
  default = {
    dev = 1
    qa  = 1
    hlg = 1
    prd = 3
  }
}