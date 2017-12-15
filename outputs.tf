output "instance_ips" {
  value = "${join(",", google_compute_address.instances.*.address)}"
}
