# ddnet-github-ci-docker
Dockerfiles reproducing the github CI workflow environment of ddnet

## my use case

Get libraries in the version the CI uses it to debug works on my machine scenarios.

```
podman build -t ubuntu20 -f ./workflows/build_ubuntu20_non_fancy.dockerfile
git clone --recursive git@github.com:ddnet/ddnet
podman run -ti --volume $(pwd)/ddnet:/ddnet localhost/ubuntu20:latest /bin/bash
```

Then in the container you can do ``cd /ddnet`` and run the CI commands there

