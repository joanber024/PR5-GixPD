terraform {
  required_providers {
    opennebula = {
      source = "OpenNebula/opennebula"
      version = "~> 1.3"
    }
  }
}

provider "opennebula" {
  endpoint = "http://nebulacaos.uab.cat:2633/RPC2"
  username = "gixpd-1"
  password = "8dInj8eqithF"
}
