# this module defines stuff that I need for work at Proscia

{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # python stuff
    uv
    # node stuff
    nodejs
    nodePackages.typescript
    #
    jira-cli-go
    awscli2
    ssm-session-manager-plugin
    kubectl
    k9s
    fluxcd
    #
    emscripten
    cmake
    ninja
  ];
}
