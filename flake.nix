{
  description = "Liren's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.fastfetch
          pkgs.tree
          pkgs.stow
          pkgs.wget
          pkgs.zoxide
          pkgs.git
          pkgs.neovim
          pkgs.ripgrep
          pkgs.lazygit
          pkgs.tmux
          pkgs.btop
          pkgs.ffmpeg
          pkgs.ffmpegthumbnailer
          pkgs.yazi
          pkgs.zig
          pkgs.fd
          pkgs.fzf
          pkgs.lua
          pkgs.jq
          pkgs.cloc
          pkgs.duf
          # hledger related stuff
          pkgs.hledger
          pkgs.hledger-ui
          pkgs.poppler_utils  # for `pdftotext` utility
          # GUI apps
          pkgs.brave
        ];
      # services.aerospace.enable = true;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

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
          "felixkratz/formulae"
          "moritzsternemann/apple-fonts"
          "nikitabobko/tap"
          "homebrew/services"
        ];
        brews = [
          "borders"
          "ghcup"
          "gnupg"
          "go"
          "imagemagick"
          "node"
          "pandoc"
          "pipx"
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
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Lirens-MacBook-Pro
    darwinConfigurations."Lirens-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
