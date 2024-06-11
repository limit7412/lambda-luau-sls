FROM virtuslab/scala-cli:latest as build-image

WORKDIR /work
COPY ./ ./

RUN lune build src/main.luau -o bootstrap
RUN chmod +x bootstrap

FROM public.ecr.aws/lambda/provided:al2

COPY --from=build-image /work/bootstrap /var/runtime/

CMD ["dummyHandler"]