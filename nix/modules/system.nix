{ pkgs, lib, ... }:

{
  security.pam.enableSudoTouchIdAuth = true;

  system.stateVersion = 5;

  system.defaults = {
    NSGlobalDomain = {
      _HIHideMenuBar = false;
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 10;
      KeyRepeat = 2;
    };

    dock = {
      orientation = "right";
      autohide = true;
      showhidden = true;
      persistent-apps = [
        "/Applications/Nix Apps/Google Chrome.app"
        "/System/Applications/Messages.app"
        "/System/Applications/Mail.app"
        "/System/Applications/Music.app"
        "/System/Applications/System Settings.app"
        "/Applications/Ghostty.app"
      ];
    };

    finder = {
      FXEnableExtensionChangeWarning = false;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      ShowPathbar = true;
      FXPreferredViewStyle = "clmv";
      FXDefaultSearchScope = "SCcf";
    };

    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };

    ActivityMonitor = {
      SortColumn = "CPUUsage";
      SortDirection = 0;
    };

    CustomSystemPreferences = {
      NSGlobalDomain = {
        AppleAccentColor = 6;
        AppleScrollerPagingBehavior = true;
        AppleWindowTabbingMode = "always";
      };
    };

    CustomUserPreferences = {
      "com.apple.AdLib" = {
        forceLimitAdTracking = true;
        allowApplePersonalizedAdvertising = false;
        allowIdentifierForAdvertising = false;
      };

      "com.apple.finder" = {
        ShowHardDrivesOnDesktop = false;
        ShowRemovableMediaOnDesktop = false;
        ShowExternalHardDrivesOnDesktop = false;
        ShowMountedServersOnDesktop = false;
        _FXSortFoldersFirst = true;
        NewWindowTarget = "PfHm";
        NewWindowTargetPath = "file://$HOME/";
        QLEnableTextSelection = true;
      };

      "com.apple.dt.Xcode" = {
        IDESkipMacroFingerprintValidation = true;
        IDEPackageSupportUseBuiltinSCM = true;
      };
    };
  };
}
