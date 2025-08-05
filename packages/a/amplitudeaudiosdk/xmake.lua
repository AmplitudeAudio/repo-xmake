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
  set_kind("library")
  set_homepage("https://amplitudeaudiosdk.com/")
  set_description("A cross-platform audio engine designed with the needs of games in mind.")

  set_urls("https://github.com/AmplitudeAudio/sdk.git", { excludes = { "*/samples/*", "*/test/*" } })

  add_configs("shared", { description = "Build shared library.", default = true, type = "boolean" })

  add_versions("1.0.0", "feat/xmake")

  on_install(function(package)
    import("package.tools.xmake").install(package, { kind = package:config("shared") and "shared" or "static" })
  end)
package_end()
