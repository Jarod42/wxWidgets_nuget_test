newoption {
	trigger = 'wxWidgetsVersion',
	value = 'version',
	description = 'Version of wxWidgets',
}

if _ACTION == nil then
	return
end

if _OPTIONS['wxWidgetsVersion'] == nil then
	print('You should provide wxWidgetsVersion...')
	return
end

local LocationDir = 'solution/%{_ACTION}'

workspace 'Project'
	location(LocationDir)
	configurations { 'Debug', 'Release' }
	platforms { 'x32', 'x64' }

	objdir(path.join(LocationDir, 'obj')) -- premake adds $(configName)/$(AppName)
	targetdir(path.join(LocationDir, 'bin/%{cfg.buildcfg}'))
	startproject 'app'

	filter 'platforms:x32'
		architecture 'x32'
	filter 'platforms:x64'
		architecture 'x64'
	filter { 'action:vs*' }
		nuget {
			'wxWidgets:' .. _OPTIONS['wxWidgetsVersion'],
			--'native:0.0'
		}
	filter {}

project 'app'
	kind 'ConsoleApp'
	targetname 'app'

	files { 'src/main.cpp' }
