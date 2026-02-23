-- Copyright (c) 2025-present Sparky Studios. All rights reserved.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

package("amplitudeaudiosdk")
  set_homepage("https://amplitudeaudiosdk.com/")
  set_description("A cross-platform audio engine designed with the needs of games in mind.")
  set_license("Apache-2.0")

  set_urls("https://github.com/AmplitudeAudio/sdk.git")

  add_configs("shared", { description = "Build shared library.", default = true, type = "boolean" })

  add_versions("1.0.0", "develop")

  on_install(function(package)
    import("xmake.cpu", { rootdir = path.join(package:cachedir(), "source", "amplitudeaudiosdk") })
    import("xmake.platform", { rootdir = path.join(package:cachedir(), "source", "amplitudeaudiosdk") })

    local archs = cpu.am_get_supported_archs()

    for _, arch in ipairs(archs) do
      local _, defines, _ = cpu.am_get_arch_info(arch)

      for _, define in ipairs(defines) do
        package:add("defines", define)
      end
    end

    platform.am_apply_detected_platform_defines(package)

    if package:config("shared") then
      package:add("defines", "AM_BUILDSYSTEM_SHARED")
    else
      package:add("defines", "AM_BUILDSYSTEM_STATIC")
    end

    import("package.tools.xmake").install(package,
      { kind = package:config("shared") and "shared" or "static", as_package = true })
  end)
package_end()
