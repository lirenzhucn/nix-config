{ pkgs, inputs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs;
    [ fastfetch
      tree
      stow
      wget
      zoxide
      git
      neovim
      ripgrep
      lazygit
      tmux
      btop
      ffmpeg
      ffmpegthumbnailer
      yazi
      zig
      fd
      fzf
      cloc
      duf
      # python stuff
      uv
      # node stuff
      nodejs
      nodePackages.typescript
      # hledger related stuff
      hledger
      hledger-ui
      poppler_utils  # for `pdftotext` utility
      # GUI apps
      brave
    ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.lirenzhu = {
    name = "lirenzhu";
    home = "/Users/lirenzhu";
  };

  # the option speaks for itself...
  security.pam.enableSudoTouchIdAuth = true;

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    taps = [
      "felixkratz/formulae"  # for sketchybar and borders
      "moritzsternemann/apple-fonts"
      "nikitabobko/tap"  # for aerospace
      "homebrew/services"  # for `brew services` which manages sketchybar
    ];
    brews = [
      "ghcup"
      "gnupg"
      "go"
      "imagemagick"
      "pandoc"
      "pipx"
      "borders"  # using the jankyborder nix package doesn't seem to work...
      "jq"  # sketchybar relies on a jq visible when brew services is run
      "lua" # sketchybar relies on a lua visible when brew services is run
      "sketchybar"
    ];
    casks = [
      "aerospace"
      "ghostty"
      "font-sf-pro"
      "font-symbols-only-nerd-font"
      "sf-symbols"
    ];
  };
}
