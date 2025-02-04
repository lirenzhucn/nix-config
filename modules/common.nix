# this module includes stuff I need everywhere.
# these include cli utilities, system utilities, and some programming languages.
# this module also includes common system settings.

{ pkgs, inputs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    fastfetch
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
    fd
    fzf
    cloc
    duf
    zig
    gnupg
  ];

  # use nix to manage homebrew
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    brews = [
      "go"
      "imagemagick"
      "pandoc"
    ];
  };

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

  # TODO: may need to split users into a separate module?
  users.users.lirenzhu = {
    name = "lirenzhu";
    home = "/Users/lirenzhu";
  };

  # the option speaks for itself...
  security.pam.enableSudoTouchIdAuth = true;
}

