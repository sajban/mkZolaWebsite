{
  description = "Make zola website";

  outputs = { self }: {
    type = "worldFunction";

    function = { zola, stdenv, kynvyrt }:

      { name ? "unnamedWebsite", src }:
      let
        zolaConfig = {
          base_url = "https://example.com";
          compile_sass = true;
          build_search_index = true;
          markdown =
            { highlight_code = true; };
        };

        zolaConfigTomlFile = kynvyrt {
          neim = "config";
          valiu = zolaConfig;
          format = "toml";
        };

      in
      stdenv.mkDerivation {
        inherit name;
        version = src.shortRev or "unversioned";
        src = self;

        nativeBuildInputs = [ zola ];

        buildPhase = ''
          ln -s ${zolaConfigTomlFile} ./config.toml
          ln -s ${src} ./content
          zola build
        '';

        installPhase = ''
          mkdir -p $out
          cp -r public/* $out
        '';
      };

  };
}
