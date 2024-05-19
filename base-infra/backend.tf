terraform {
  cloud {
    organization = "kns-personal"

    workspaces {
      name = "carro-infra"
    }
  }
}
