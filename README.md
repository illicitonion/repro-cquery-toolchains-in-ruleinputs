# repro-cquery-toolchains-in-ruleinputs

In this repo, `//dir:rule` depends on `//dir:echo_hello_to_argv0.sh` via a toolchain dependency on `//dir:my_toolchain`.

That dep can be seen in a `deps` query:

```console
% bazel cquery 'deps(//dir:rule)' 2>/dev/null
//dir:rule (f4755fd)
//dir:my_toolchain (f4755fd)
@local_config_platform//:host (f4755fd)
//dir:toolchain_type (f4755fd)
@platforms//cpu:aarch64 (f4755fd)
@platforms//os:osx (f4755fd)
//dir:echo_hello_to_argv0.sh (null)
@platforms//cpu:arm64 (f4755fd)
@platforms//os:os (f4755fd)
@platforms//cpu:cpu (f4755fd)
```

However, neither `//dir:my_toolchain` nor `//dir:echo_hello_to_argv0.sh` show up in the `rule_inputs` field of `//dir:rule`'s proto:

```console
% bazel cquery --output=jsonproto '//dir:rule' 2>/dev/null
{
  "results": [{
    "target": {
      "type": "RULE",
      "rule": {
        "name": "//dir:rule",
        "ruleClass": "rule_using_toolchain",
        "location": "/Volumes/Source/github.com/illicitonion/repro-cquery-toolchains-in-ruleinputs/dir/BUILD.bazel:19:21",
        "attribute": [{
          "name": "$config_dependencies",
          "type": "LABEL_LIST",
          "explicitlySpecified": false,
          "nodep": false
        }, {
          "name": ":action_listener",
          "type": "LABEL_LIST",
          "explicitlySpecified": false,
          "nodep": false
        }, {
          "name": "applicable_licenses",
          "type": "LABEL_LIST",
          "explicitlySpecified": false,
          "nodep": false
        }, {
          "name": "aspect_hints",
          "type": "LABEL_LIST",
          "explicitlySpecified": false,
          "nodep": false
        }, {
          "name": "compatible_with",
          "type": "LABEL_LIST",
          "explicitlySpecified": false,
          "nodep": false
        }, {
          "name": "deprecation",
          "type": "STRING",
          "explicitlySpecified": false,
          "nodep": false
        }, {
          "name": "exec_compatible_with",
          "type": "LABEL_LIST",
          "explicitlySpecified": false,
          "nodep": false
        }, {
          "name": "exec_properties",
          "type": "STRING_DICT",
          "explicitlySpecified": false
        }, {
          "name": "expect_failure",
          "type": "STRING",
          "stringValue": "",
          "explicitlySpecified": false,
          "nodep": false
        }, {
          "name": "features",
          "type": "STRING_LIST",
          "explicitlySpecified": false,
          "nodep": false
        }, {
          "name": "generator_function",
          "type": "STRING",
          "stringValue": "",
          "explicitlySpecified": false,
          "nodep": false
        }, {
          "name": "generator_location",
          "type": "STRING",
          "stringValue": "",
          "explicitlySpecified": false,
          "nodep": false
        }, {
          "name": "generator_name",
          "type": "STRING",
          "stringValue": "",
          "explicitlySpecified": false,
          "nodep": false
        }, {
          "name": "name",
          "type": "STRING",
          "stringValue": "rule",
          "explicitlySpecified": true,
          "nodep": false
        }, {
          "name": "restricted_to",
          "type": "LABEL_LIST",
          "explicitlySpecified": false,
          "nodep": false
        }, {
          "name": "tags",
          "type": "STRING_LIST",
          "explicitlySpecified": false,
          "nodep": false
        }, {
          "name": "target_compatible_with",
          "type": "LABEL_LIST",
          "explicitlySpecified": false,
          "nodep": false
        }, {
          "name": "testonly",
          "type": "BOOLEAN",
          "intValue": 0,
          "stringValue": "false",
          "explicitlySpecified": false,
          "booleanValue": false
        }, {
          "name": "toolchains",
          "type": "LABEL_LIST",
          "explicitlySpecified": false,
          "nodep": false
        }, {
          "name": "transitive_configs",
          "type": "STRING_LIST",
          "explicitlySpecified": false,
          "nodep": true
        }, {
          "name": "visibility",
          "type": "STRING_LIST",
          "explicitlySpecified": false,
          "nodep": true
        }, {
          "name": "$rule_implementation_hash",
          "type": "STRING",
          "stringValue": "fc3a1a127aea7d42f500255d807f8bf1998c65acde8e8cdac734e298831e535e"
        }]
      }
    },
    "configuration": {
      "checksum": "f4755fdba2a9adc4be1938f00075ca430c17dfc1e57b306638d8379237e33b52"
    },
    "configurationId": 1
  }],
  "configurations": [{
    "id": 1,
    "mnemonic": "darwin_arm64-fastbuild",
    "platformName": "darwin_arm64",
    "checksum": "f4755fdba2a9adc4be1938f00075ca430c17dfc1e57b306638d8379237e33b52"
  }]
}
```

However, if you query with transitions enabled, `configured_rule_inputs` gets a dependency on the toolchain, but `rule_inputs` does not:

```console
{
  "target": {
    "type": "RULE",
    "rule": {
      "name": "//dir:rule",
      "ruleClass": "rule_using_toolchain",
      "location": "/Volumes/Source/github.com/illicitonion/repro-cquery-toolchains-in-ruleinputs/dir/BUILD.bazel:19:21",
      "attribute": [
        {
          "name": "$config_dependencies",
          "type": "LABEL_LIST",
          "explicitlySpecified": false,
          "nodep": false
        },
        {
          "name": ":action_listener",
          "type": "LABEL_LIST",
          "explicitlySpecified": false,
          "nodep": false
        },
        {
          "name": "applicable_licenses",
          "type": "LABEL_LIST",
          "explicitlySpecified": false,
          "nodep": false
        },
        {
          "name": "aspect_hints",
          "type": "LABEL_LIST",
          "explicitlySpecified": false,
          "nodep": false
        },
        {
          "name": "compatible_with",
          "type": "LABEL_LIST",
          "explicitlySpecified": false,
          "nodep": false
        },
        {
          "name": "deprecation",
          "type": "STRING",
          "explicitlySpecified": false,
          "nodep": false
        },
        {
          "name": "exec_compatible_with",
          "type": "LABEL_LIST",
          "explicitlySpecified": false,
          "nodep": false
        },
        {
          "name": "exec_properties",
          "type": "STRING_DICT",
          "explicitlySpecified": false
        },
        {
          "name": "expect_failure",
          "type": "STRING",
          "stringValue": "",
          "explicitlySpecified": false,
          "nodep": false
        },
        {
          "name": "features",
          "type": "STRING_LIST",
          "explicitlySpecified": false,
          "nodep": false
        },
        {
          "name": "generator_function",
          "type": "STRING",
          "stringValue": "",
          "explicitlySpecified": false,
          "nodep": false
        },
        {
          "name": "generator_location",
          "type": "STRING",
          "stringValue": "",
          "explicitlySpecified": false,
          "nodep": false
        },
        {
          "name": "generator_name",
          "type": "STRING",
          "stringValue": "",
          "explicitlySpecified": false,
          "nodep": false
        },
        {
          "name": "name",
          "type": "STRING",
          "stringValue": "rule",
          "explicitlySpecified": true,
          "nodep": false
        },
        {
          "name": "restricted_to",
          "type": "LABEL_LIST",
          "explicitlySpecified": false,
          "nodep": false
        },
        {
          "name": "tags",
          "type": "STRING_LIST",
          "explicitlySpecified": false,
          "nodep": false
        },
        {
          "name": "target_compatible_with",
          "type": "LABEL_LIST",
          "explicitlySpecified": false,
          "nodep": false
        },
        {
          "name": "testonly",
          "type": "BOOLEAN",
          "intValue": 0,
          "stringValue": "false",
          "explicitlySpecified": false,
          "booleanValue": false
        },
        {
          "name": "toolchains",
          "type": "LABEL_LIST",
          "explicitlySpecified": false,
          "nodep": false
        },
        {
          "name": "transitive_configs",
          "type": "STRING_LIST",
          "explicitlySpecified": false,
          "nodep": true
        },
        {
          "name": "visibility",
          "type": "STRING_LIST",
          "explicitlySpecified": false,
          "nodep": true
        },
        {
          "name": "$rule_implementation_hash",
          "type": "STRING",
          "stringValue": "fc3a1a127aea7d42f500255d807f8bf1998c65acde8e8cdac734e298831e535e"
        }
      ],
      "configuredRuleInput": [
        {
          "label": "//dir:my_toolchain",
          "configurationChecksum": "f4755fdba2a9adc4be1938f00075ca430c17dfc1e57b306638d8379237e33b52",
          "configurationId": 1
        }
      ]
    }
  },
  "configuration": {
    "checksum": "f4755fdba2a9adc4be1938f00075ca430c17dfc1e57b306638d8379237e33b52"
  },
  "configurationId": 1
}
```
