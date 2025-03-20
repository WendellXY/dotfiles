{ pkgs, ... }:

{
	homebrew = {
		enable = true;
		brews = [
			"mas"
			"sourcery"
			"swiftgen"
			"tencent-mars-xlog-util"
			"xcode-build-server"
			"xcbeautify"
			"zsh-completions"
			"zsh-abbr"
			"zsh-autosuggestions-abbreviations-strategy"
		];
		casks = [
			"android-platform-tools"
			"arc"
			"iina"
			"imageoptim"
			"firefox"
			"figma"
			"aerospace"
			"wezterm"
			"gitbutler"
			"github"
			"github-copilot-for-xcode"
			# "ghostty"
			"ollama"
			"playcover-community"
			"sf-symbols"
			"stats"
		];
		taps = [
			"nikitabobko/tap"
			"olets/tap"
			"playcover/playcover"
			"0x1306a94/homebrew-tap"
		];
		masApps = {
			"Xcode" = 497799835;
			"Twitter" = 1482454543;
			"Developer" = 640199958;
			"Keynote" = 409183694;
			"WeChat" = 836500024;
			"Wallpaper Play" = 1638457121;
			"Raycast Companion" = 6738274497;
			"Microsoft Excel" = 462058435;
			"TestFlight" = 899247664;
			"Pages" = 409201541;
			"Telegram" = 747648890;
			"Numbers" = 409203825;
			"Noir" = 1592917505;
			"LocalSend" = 1661733229;
		};
		onActivation.cleanup = "zap";
		onActivation.autoUpdate = true;
		onActivation.upgrade = true;
	};
}
