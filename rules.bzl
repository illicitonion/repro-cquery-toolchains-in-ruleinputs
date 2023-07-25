def _rule_using_toolchain_impl(ctx):
    output_file = ctx.actions.declare_file("output_file")

    bin = ctx.toolchains["//dir:toolchain_type"].bin

    args = ctx.actions.args()
    args.add(output_file.path)

    ctx.actions.run(
        outputs = [output_file],
        executable = bin.path,
        arguments = [output_file.path],
        tools = [bin],
        use_default_shell_env = True,
    )

    return [
        DefaultInfo(
            files = depset([output_file]),
        ),
    ]

rule_using_toolchain = rule(
    implementation = _rule_using_toolchain_impl,
    toolchains = ["//dir:toolchain_type"],
)

def _toolchain_impl(ctx):
    return [
        platform_common.ToolchainInfo(
            bin = ctx.file.bin,
        ),
    ]

my_toolchain = rule(
    implementation = _toolchain_impl,
    attrs = {
        "bin": attr.label(
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
    },
)
