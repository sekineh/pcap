# This script takes care of testing your crate

set -ex

# TODO This is the "test phase", tweak it as you see fit
main() {
    cargo build --target $TARGET
    cargo build --target $TARGET --features full
    cargo build --target $TARGET --release
    cargo build --target $TARGET --release --features full

    cargo build --target $TARGET --example listenlocalhost
    cargo build --target $TARGET --example getdevices
    cargo build --target $TARGET --example easylisten
    cargo build --target $TARGET --example savefile
    cargo build --target $TARGET --example getstatistics
    cargo build --target $TARGET --example streamlisten --features tokio

    if [ ! -z $DISABLE_TESTS ]; then
        return
    fi

    cargo test --target $TARGET
    cargo test --target $TARGET --features full
    cargo test --target $TARGET --release
    cargo test --target $TARGET --release --features full
}

# we don't run the "test phase" when doing deploys
if [ -z $TRAVIS_TAG ]; then
    main
fi
