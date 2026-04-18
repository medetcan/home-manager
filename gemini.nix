{ config, pkgs, ... }:

{
  programs.gemini-cli.enable = true;
  programs.gemini-cli.defaultModel = "gemini-3.1-pro-preview";

  programs.gemini-cli.context = {
    GEMINI = ''
      # Global Context
      - Be brief and factual and non-speculative.

      # Tools
      - Use nix package manager and nix flakes for packages.
      - Use home-manager for user configurations.
    '';
  };

  programs.gemini-cli.policies = {
    "default" = {
      rule = [
        {
          toolName = "read_file";
          decision = "allow";
          priority = 100;
        }
        {
          toolName = "read_many_files";
          decision = "allow";
          priority = 100;
        }
        {
          toolName = "web_fetch";
          decision = "allow";
          priority = 100;
        }
        {
          toolName = "google_web_search";
          decision = "allow";
          priority = 100;
        }
      ];
    };
  };

  programs.gemini-cli.settings = {
    security.auth.selectedType = "oauth-personal";
    ide.hasSeenNudge = true;
    general = {
      preferredEditor = "nvim";
      vimMode = true;
      sessionRetention = {
        enabled = true;
        maxAge = "30d";
        warningAcknowledged = true;
      };
      defaultApprovalMode = "default";
      enableAutoUpdate = true;
      enableNotifications = true;
      plan = {
        modelRouting = true;
        directory = "";
      };
    };
    ui = {
      inlineThinkingMode = "full";
      showCitations = true;
      showModelInfoInChat = true;
      loadingPhrases = "all";
      theme = "Atom One";
    };
    model = {
      disableLoopDetection = true;
      name = "gemini-3.1-pro-preview";
    };
    context.fileName = [
      "AGENTS.md"
      "CONTEXT.md"
      "GEMINI.md"
    ];
  };
}
