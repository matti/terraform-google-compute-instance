output "addresses" {
  value = "${join(",", google_compute_address.instances.*.address)}"
}
