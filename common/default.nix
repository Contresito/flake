let
  # List all files in the specified subdirectory
  dirEntries = builtins.readDir ./.;

  # Filter and import all Nix files from the subdirectory, excluding default.nix
  fileImports = map (file: import (./. + "/${file}")) (
    builtins.filter (file: builtins.match ".*\\.nix" file != null && file != "default.nix") (
      builtins.attrNames dirEntries
    )
  );

  # Import all folders that have a default.nix inside
  folderImports = map (folder: import (./. + "/${folder}")) (
    builtins.filter (
      child: dirEntries.${child} == "directory" && builtins.pathExists (./. + "/${child}/default.nix")
    ) (builtins.attrNames dirEntries)
  );
in
{
  imports = fileImports ++ folderImports;
}
