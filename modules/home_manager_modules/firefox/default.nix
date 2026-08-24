{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
let
  cfg = config.firefox;
  profile_name = "a";
  work_name = "AGCO";

  dependencies = [ ];

  extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
    ublock-origin
    zotero-connector
    # qwant-search-firefox
  ];
  bookmarks = [
    {
      name = "toolbar bookmarks";
      toolbar = true;
      bookmarks = [
        {
          name = "mail";
          tags = [ "mail" ];
          url = "https://mail.google.com/mail/u/1/#inbox";
        }

      ];
    }
  ];

  search_engines = {
    "google" = {
      urls = [ { template = "https://www.google.com/search?q={searchTerms}"; } ];
      definedAliases = [ "@g" ];
      metaData = {
        hidden = false;
      };
    };
  };
  profiles = {
    "${profile_name}" = {
      id = 0;
      name = "${profile_name}";
      extensions.packages = extensions;
      search = {
        force = true;
        default = "google";
        engines = search_engines;
        order = [
          "google"
        ];
      };
      settings = default_settings;
      bookmarks = {
        force = true;
        settings = bookmarks;
      };
    };
    "${work_name}" = {
      id = 1;
      name = "${work_name}";
      extensions.packages = extensions;
      search = {
        force = true;
        default = "google";
        engines = search_engines;
        order = [
          "google"
        ];
      };
      settings = default_settings;
      bookmarks = {
        force = true;
        settings = bookmarks;
      };
    };
  };
  adjusted_profiles = lib.mapAttrs (
    name: profile:
    profile
    // {
      isDefault = (name == cfg.defaultProfile);
    }
  ) profiles;

  default_settings = {
    # Disable irritating first-run stuff
    "browser.disableResetPrompt" = true;
    "browser.download.panel.shown" = true;
    "browser.feeds.showFirstRunUI" = false;
    "browser.messaging-system.whatsNewPanel.enabled" = false;
    "browser.rights.3.shown" = true;
    "browser.shell.checkDefaultBrowser" = false;
    "browser.shell.defaultBrowserCheckCount" = 1;
    "browser.startup.homepage_override.mstone" = "ignore";
    "browser.uitour.enabled" = false;
    "startup.homepage_override_url" = "";
    "trailhead.firstrun.didSeeAboutWelcome" = true;
    "browser.bookmarks.restore_default_bookmarks" = false;
    "browser.bookmarks.addedImportButton" = false;

    # Credit Card Settings
    "extensions.formautofill.creditCards.enabled" = false;
    "services.sync.engine.creditcards.available" = true;

    # UI Options
    "browser.compactmode.show" = true;
    "browser.uidensity" = 1;
    "browser.tabs.tabmanager.enabled" = false;
    "browser.fullscreen.autohide" = false;
    "browser.toolbars.bookmarks.visibility" = "always";
    "sidebar.position_start" = false;

    # Prevent window from closing when last tab is closed
    "browser.tabs.closeWindowWithLastTab" = false;

    # Remove unwanted features
    "extensions.pocket.enabled" = false; # pocket
    "identity.fxaccounts.enabled" = false; # firefox sync
    "signon.rememberSignons" = true; # asking to save passwords

    # Auto-enable extensions
    "extensions.autoDisableScopes" = 0;
    "extensions.enabledScopes" = 15;

    # Miscellaneous options
    "general.autoScroll" = true; # Enable autoscrolling
    "browser.aboutConfig.showWarning" = false; # Prevent about:config warning
    # "browser.profiles.enabled" = true;
    # "browser.profiles.profile-name.updated" = true;
    # "browser.profiles.forceEnableRefresh" = true;
    "browser.ml.enable" = false;

  };

in
{
  imports = [
    # Ensure Firefox module is imported only once
    # inputs.textfox.homeManagerModules.default
  ];

  options = {
    firefox.enable = lib.mkEnableOption "enables firefox";
    firefox.defaultProfile = lib.mkOption {
      type = lib.types.str;
      default = "${profile_name}";
      description = "name of the default profile";
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        home = {
          packages = dependencies;
        };
        programs.firefox = {
          enable = true;
          # profiles = adjusted_profiles;

        };
        xdg = {
          enable = true;
          mimeApps.enable = true;
          mimeApps.defaultApplications = {
            "text/html" = [ "firefox.desktop" ];
            "text/xml" = [ "firefox.desktop" ];
            "x-scheme-handler/http" = [ "firefox.desktop" ];
            "x-scheme-handler/https" = [ "firefox.desktop" ];
          };
        };
      }
    ]
  );
}
