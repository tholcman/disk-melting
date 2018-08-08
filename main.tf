variable "scylla_repo_url" {
  description = "should look like http://repositories.scylladb.com/scylla/repo/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/ubuntu/scylladb-2.1-xenial.list"
}

variable "project" {
  description = ""
}

module "west1-1" {
  source = "./instance"

  project    = "${var.project}"
  region     = "europe-west1"
  zone       = "b"
  hostnumber = 1

  scylla_repo_url = "${var.scylla_repo_url}"
}

module "west2-1" {
  source = "./instance"

  project    = "${var.project}"
  region     = "europe-west2"
  zone       = "a"
  hostnumber = 1

  scylla_repo_url = "${var.scylla_repo_url}"
}

/*
module "west1-2" {
  source = "./instance"

  project    = "${var.project}"
  region     = "europe-west1"
  zone       = "b"
  hostnumber = 2

  scylla_repo_url = "${var.scylla_repo_url}"
}

module "west2-2" {
  source = "./instance"

  project    = "${var.project}"
  region     = "europe-west2"
  zone       = "b"
  hostnumber = 2

  scylla_repo_url = "${var.scylla_repo_url}"
}
*/
