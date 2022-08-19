self: super:
{
    rofi-calc = super.rofi-calc.overrideAttrs (old: rec {
      name = "rofi-calc";
      buildInputs = [
            super.rofi-wayland-unwrapped
            super.libqalculate
            super.glib
            super.cairo
      ];
    });
    rofi-file-browser = super.rofi-file-browser.overrideAttrs (old: rec {
      name = "rofi-file-browser";
      buildInputs = [
            super.rofi-wayland
            super.gtk3
      ];
        prePatch = ''
            substituteInPlace ./CMakeLists.txt \
                  --replace ' ''${ROFI_PLUGINS_DIR}' " $out/lib/rofi" \
                  --replace "/usr/share/" "$out/share/"
        '';
    });
  }
