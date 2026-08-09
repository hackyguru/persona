{
  description = "Persona UI — Bedrock + LEZ, QML frontend for the persona_core module";

  inputs = {
    logos-module-builder.url = "github:logos-co/logos-module-builder";
    # Core module — the sibling `core/` in this same repo. Pinned to GitHub
    # so this flake builds standalone (the catalog release needs no sibling
    # checkout). For local dev against the sibling dir:
    #   nix build --override-input logos_wallet path:../core '.#lgx-portable'
    logos_wallet.url = "github:hackyguru/persona?dir=core";
    # Bundled with Basecamp; declared as a DIRECT dep so the host spawns it
    # (dependencies are not resolved transitively). Listed first so its
    # registry is up before logos_wallet queries it.
    logos_execution_zone.url = "github:logos-blockchain/logos-execution-zone-module";
  };

  outputs = inputs@{ logos-module-builder, ... }:
    logos-module-builder.lib.mkLogosQmlModule {
      src = ./.;
      configFile = ./metadata.json;
      flakeInputs = inputs;
    };
}
