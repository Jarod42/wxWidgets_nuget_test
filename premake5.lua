newoption {
	trigger = 'wxWidgetsVersion',
	value = 'version',
	description = 'Version of wxWidgets',
}

newoption {
	trigger = 'nugetsource',
	value = '',
	description = 'url of nuget package source',
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
	platforms { 'Win32', 'x64' }

	objdir(path.join(LocationDir, 'obj')) -- premake adds $(configName)/$(AppName)
	targetdir(path.join(LocationDir, 'bin/%{cfg.platform}/%{cfg.buildcfg}'))
	startproject 'app'

	filter 'platforms:Win32'
		architecture 'x86'
		
	filter 'platforms:x64'
		architecture 'x64'
		
	filter { 'action:vs*' }
if _OPTIONS['nugetsource'] ~= nil then
		nugetsource(_OPTIONS['nugetsource'])
end
		nuget {
			'wxWidgets:' .. _OPTIONS['wxWidgetsVersion']
		}
	filter {}

project 'app'
	kind 'ConsoleApp'
	targetname 'app'

	files { 'src/main.cpp' }
