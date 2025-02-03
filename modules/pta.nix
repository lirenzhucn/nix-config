# this module only includes stuff used by PTA (plain text accounting) stuff.

{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # hledger related stuff
    hledger
    hledger-ui
    poppler_utils  # for `pdftotext` utility
  ];
  homebrew.brews = [
    "ghcup"
  ];
}
