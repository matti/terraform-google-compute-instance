data "google_compute_zones" "available" {
  region = "${var.region}"
  status = "UP"
}

resource "google_compute_address" "instances" {
  count = "${var.amount}"
  name  = "${var.name}-${count.index}"
}

resource "google_compute_disk" "instances" {
  count = "${var.amount}"

  name = "${var.name}-${count.index+1}"
  type = "${var.disk_type}"
  size = "${var.disk_size}"
  zone = "${data.google_compute_zones.available.names[count.index % length(data.google_compute_zones.available.names)]}"

  image = "${var.disk_image}"

  provisioner "local-exec" {
    command    = "${var.disk_create_local_exec_command_or_fail}"
    on_failure = "fail"
  }

  provisioner "local-exec" {
    command    = "${var.disk_create_local_exec_command_and_continue}"
    on_failure = "continue"
  }

  provisioner "local-exec" {
    when       = "destroy"
    command    = "${var.disk_destroy_local_exec_command_or_fail}"
    on_failure = "fail"
  }

  provisioner "local-exec" {
    when       = "destroy"
    command    = "${var.disk_destroy_local_exec_command_and_continue}"
    on_failure = "continue"
  }
}

resource "google_compute_instance" "instances" {
  count = "${var.amount}"

  name         = "${var.name}-${count.index+1}"
  zone         = "${data.google_compute_zones.available.names[count.index % length(data.google_compute_zones.available.names)]}"
  machine_type = "${var.machine_type}"

  boot_disk = {
    source      = "${google_compute_disk.instances.*.name[count.index]}"
    auto_delete = false
  }

  metadata {
    user-data = "${var.user_data}"
  }

  network_interface = {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.instances.*.address[count.index]}"
    }
  }

  scheduling {
    on_host_maintenance = "MIGRATE"
    automatic_restart   = "true"
  }
}
