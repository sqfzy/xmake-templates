add_rules("mode.debug", "mode.release")
add_rules("plugin.compile_commands.autoupdate", {outputdir = "build"})
set_languages("c++23")


if is_mode("release") then
	set_optimize("fastest")
end

target("foo")
    set_kind("binary")
    add_files("src/*.cpp")
	if is_mode("debug") then 
		set_policy("build.sanitizer.address", true)
		set_policy("build.sanitizer.undefined", true)
		set_policy("build.sanitizer.thread", true)
		set_policy("build.sanitizer.memory", true)
		set_policy("build.sanitizer.undefined", true)
	end
    -- 相当于 -Wall -Wextra
    set_warnings("all", "extra")
    -- 针对 Linux (GCC/Clang) 的额外强化警告
    if is_plat("linux") then
        add_cxxflags(
            "-Wshadow",             -- 警告变量遮蔽
            "-Wconversion",         -- 警告可能丢失数据的隐式转换
            "-Wpedantic",           -- 严格遵守 ISO C++ 标准
            "-Wlogical-op",         -- 警告可疑的逻辑操作
            {force = true}
        )
    end
