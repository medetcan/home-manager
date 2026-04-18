
{ config, pkgs, profile, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.email = profile.email;
      user.name = profile.username;
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      core.editor = "nvim";
      pull.rebase = true;
    };
    ignores = [
      ".devenv"
      ".direnv"
      "**/.claude/settings.local.json"
    ];
  };

}
