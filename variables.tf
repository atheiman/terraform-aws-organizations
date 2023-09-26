variable "ous" {
  description = "List of organizational units specified as '/' delimited paths. Intermediate paths do not need to be declared individually. Example: [\"core\", \"workloads/nonprod\", \"workloads/prod\"]"
  type        = list(string)
  default     = []
}
