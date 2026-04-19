package("bloom")
    set_homepage("https://github.com/wirespider87/bloom")
    set_description("Immediate-mode GUI library for Windows overlays, tools, and internal apps")
    set_license("0BSD")

    add_urls("https://github.com/wirespider87/bloom/archive/refs/tags/v$(version).tar.gz")
    add_urls("https://github.com/wirespider87/bloom.git", {alias = "github", submodules = false})

    add_versions("1.0.2", "d8bbdcc533d4926d02892507e19daeec9c87c2534de41e45ddc89ff12d516179")
    add_versions("1.0.3", "dd5dc536c350947612a338bc1b5d76965c26b9515934a3646dfa0849052eacff")
    add_versions("1.0.4", "4bbff9a7e1f90320fcbb4d14e7cd2fe8136dcf95603d80d62e74304fdf80bf2e")
    add_versions("1.0.5", "850906224eba089d33ff83ed36bfa95706021e742cf1c74907573124aa2c5002")
    add_versions("1.0.6", "d3c5b27f2d85bbd04456ace03d61aa076e1a71060e742d19cc61effa309042f0")
    add_versions("1.0.7", "a17aa9913bd653a8d33c1b786091442eb563f2cf3f58adc5816a1d4c85342ffb")
    add_versions("1.0.6", "d3c5b27f2d85bbd04456ace03d61aa076e1a71060e742d19cc61effa309042f0")
    add_versions("1.0.7", "a17aa9913bd653a8d33c1b786091442eb563f2cf3f58adc5816a1d4c85342ffb")

    add_versions("github:1.0.2", "v1.0.2")
    add_versions("github:1.0.3", "v1.0.3")
    add_versions("github:1.0.4", "v1.0.4")
    add_versions("github:1.0.5", "v1.0.5")
    add_versions("github:1.0.6", "v1.0.6")
    add_versions("github:1.0.7", "v1.0.7")

    add_configs("shared", {description = "Build shared library.", default = false, type = "boolean"})
    add_configs("opengl", {description = "Build OpenGL backend.", default = true, type = "boolean"})
    add_configs("d3d11", {description = "Build Direct3D 11 backend.", default = false, type = "boolean"})

    on_load("windows", function (package)
        package:add("syslinks", "opengl32", "user32", "gdi32", "dwmapi", "shell32")
        if package:config("d3d11") then
            package:add("syslinks", "d3d11", "dxgi", "d3dcompiler")
        end
        if package:config("opengl") then
            package:add("defines", "BLOOM_OPENGL_BACKEND")
        end
        if package:config("d3d11") then
            package:add("defines", "BLOOM_D3D11_BACKEND")
        end
    end)

    on_install("windows", function (package)
        local configs = {
            shared = package:config("shared") and "y" or "n",
            opengl = package:config("opengl") and "y" or "n",
            d3d11 = package:config("d3d11") and "y" or "n",
            examples = "n"
        }
        import("package.tools.xmake").install(package, configs)
    end)

    on_test(function (package)
        assert(package:check_csnippets({test = [[
            #include <bloom.h>
            void test(void) {
                const bloom_api *api = bloom;
                bloom_context *ctx = api->create_context();
                api->destroy_context(ctx);
            }
        ]]}, {configs = {languages = "c11"}}))
    end)
