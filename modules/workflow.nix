# this module sets up toplevel workflow related stuff,
# including aerospace, sketchybar, ghostty, and brave.
# (my two daily drivers are terminal and browser, so they are included.)

{ pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    brave
  ];

  # use nix to manage homebrew
  homebrew = {
    taps = [
      "felixkratz/formulae"  # for sketchybar and borders
      "moritzsternemann/apple-fonts"
      "nikitabobko/tap"  # for aerospace
      "homebrew/services"  # for `brew services` which manages sketchybar
    ];
    brews = [
      "borders"  # using the jankyborder nix package doesn't seem to work...
      "jq"  # sketchybar relies on a jq visible when brew services is run
      "lua" # sketchybar relies on a lua visible when brew services is run
      "sketchybar"
    ];
    casks = [
      "aerospace"
      # NOTE: ghostty is currently broken for Darwin in nixpkgs
      "ghostty"
      "font-sf-pro"
      "font-symbols-only-nerd-font"
      "sf-symbols"
    ];
  };
}
