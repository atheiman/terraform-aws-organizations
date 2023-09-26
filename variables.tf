variable "feature_set" {
  description = "Enable all features (\"ALL\") or only consolidated billing (\"CONSOLIDATED_BILLING\")."
  type        = string
  default     = "ALL"
}

variable "enabled_policy_types" {
  description = "Policy types to enable in the organization root. See Organizations `EnablePolicyType` api."
  type        = list(string)
  default     = ["AISERVICES_OPT_OUT_POLICY", "BACKUP_POLICY", "SERVICE_CONTROL_POLICY", "TAG_POLICY"]
}

variable "ous" {
  description = "List of organizational units specified as '/' delimited paths. Intermediate paths do not need to be declared individually. Example: [\"core\", \"workloads/nonprod\", \"workloads/prod\"]"
  type        = list(string)
  default     = []
}
