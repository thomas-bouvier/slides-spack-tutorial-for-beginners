with import <nixpkgs> { };
mkShell {
  packages = [
    # (nodejs.override { enableNpm = false; })
    nodejs
    corepack
    playwright-driver.browsers
  ];

  env = {
    PLAYWRIGHT_BROWSERS_PATH = pkgs.playwright-driver.browsers;
    PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "true";
  };
}
