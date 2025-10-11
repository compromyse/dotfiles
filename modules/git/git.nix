{ lib, ... }:

{
  environment.etc."gitconfig".text = "
    [safe]
    directory = *
  ";
}

