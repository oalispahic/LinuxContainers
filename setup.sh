#!/usr/bin/env bash
cd "$(dirname "$0")"
set -e

if ! command -v docker >/dev/null 2>&1; then
    echo "Docker is not installed."
    echo "Install Docker Desktop first, then run this script again."
    exit 1
fi

echo "Installing dev environment..."

# build linux image
docker build -t fastlinux ./fast_linux

# create persistent home
mkdir -p ~/linuxhome

# install shell helpers
cat >> ~/.zshrc <<'EOF'

pc () {
    if docker container inspect superlinux >/dev/null 2>&1; then
        docker start superlinux >/dev/null
        docker exec -it superlinux bash -l
    else
        docker run -it \
        --name superlinux \
        --hostname minilinux \
        -v ~/linuxhome:/home/dev \
        fastlinux
    fi
}

lin () {
    name=$(basename "$PWD")
    docker run -it --rm \
    --hostname "$name" \
    -v "$PWD":/workspace \
    -w /workspace \
    fastlinux
}

lab () {
    docker run -it --rm ubuntu:22.04 bash
}
EOF

echo "Done. Restart terminal."
