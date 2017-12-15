# terraform-google-compute-instance

Separated disk and static ip for better manageability

## Usage:

Creates 3 instances and IP addresses with names `test-1`, `test-2` and `test-3`. Machine type can be changed without destroying the boot disk.

```
module "gci_test" {
  source = "github.com/matti/terraform-google-compute-instance"

  amount       = 3
  region       = "us-east1"
  name         = "test"
  machine_type = "custom-2-2048"
  disk_size    = "32"
  disk_image   = "coreos-stable-1520-5-0-v20171011"
}
```
