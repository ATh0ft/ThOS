{ config, lib, ... }:

{
  age.secrets.zerotier-network-id = {
    file = ../secrets/zerotier.age;
    owner = "root";
  };
}

