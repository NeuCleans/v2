package(default_visibility = ["//visibility:public"])

load("//tools:build_rules/go.bzl", "go_binary")
load("@io_bazel_rules_docker//docker:docker.bzl", "docker_build")

go_binary(
    name = "superpowers",
    srcs = [
        "main.go",
    ],
    deps = [
        "//account",
        "//auth",
        "//environments",
        "//errorpages",
        "//healthcheck",
        "//middlewares",
        "@go_gorilla_mux//:mux",
        "@go_grpc//:grpc",
        "@go_grpc//:metadata",
        "@go_logrus//:logrus",
        "@go_negroni//:negroni",
    ],
)

docker_build(
    name = "docker",
    base = "//docker:ubuntu-trusty",
    cmd = "./superpowers",
    files = [
        ":superpowers",
    ],
    visibility = ["//visibility:public"],
)
