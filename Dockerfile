# NOTE: lune can't create static binary
# FROM homebrew/brew:latest as build-image

# WORKDIR /work
# COPY ./ ./

# RUN brew install lune

# RUN lune build src/main.luau -o bootstrap
# RUN chmod +x bootstrap

FROM public.ecr.aws/lambda/provided:latest

WORKDIR /work/bin

RUN dnf update -y
RUN dnf install -y curl-minimal
RUN dnf install -y unzip
RUN dnf install -y glibc
RUN dnf install -y gcc
RUN dnf install -y gcc-c++
RUN dnf install -y libstdc++
RUN dnf install -y libstdc++-devel
RUN dnf clean all

ENV ZIP_URL=https://github.com/lune-org/lune/releases/download/v0.8.5/lune-0.8.5-linux-x86_64.zip
RUN curl -L $ZIP_URL -o /tmp/archive.zip
RUN unzip -q /tmp/archive.zip
RUN rm /tmp/archive.zip

ENV PATH="/work/bin:${PATH}"

WORKDIR /var/runtime/
COPY ./src ./

WORKDIR /var/runtime/
RUN lune build main.luau -o bootstrap
RUN chmod +x bootstrap

# COPY --from=build-image /work/bootstrap /var/runtime/

CMD ["dummyHandler"]