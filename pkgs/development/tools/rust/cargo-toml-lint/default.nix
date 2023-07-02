{ lib
, rustPlatform
, fetchCrate
}:

rustPlatform.buildRustPackage rec {
  pname = "cargo-toml-lint";
  version = "0.1.1";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-U3y9gnFvkqJmyFqRAUQorJQY0iRzAE9UUXzFmgZIyaM=";
  };

  cargoSha256 = "sha256-ujdekIucqes2Wya4jwTMLstb8JMptbAlqYhgMxfp2gg=";

  meta = with lib; {
    description = "A simple linter for Cargo.toml manifests";
    homepage = "https://github.com/fuellabs/cargo-toml-lint";
    license = with licenses;[ mit asl20 ];
    maintainers = with maintainers; [ mitchmindtree ];
  };
}
