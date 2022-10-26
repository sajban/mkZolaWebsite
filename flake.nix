{
  description = "Make zola website";

  outputs = { self }: {
    type = "worldFunction";

    function = { zola, stdenv }:
      ({ src }:
        stdenv.mkDerivation { };)
    };
  }
