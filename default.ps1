properties {
}

task default -depends NuGet

task Clean { 
	[void](remove-item Build -force -recurse -ea SilentlyContinue)
}

task Build -depends Clean {
	[void](mkdir Build\lib\2.0 -ea SilentlyContinue)
	exec { msbuild Source\log4net.NLogAppender\log4net.NLogAppender.csproj /p:Configuration=Release }
	copy -recurse Source\log4net.NLogAppender\Bin\Release\log4net.NLogAppender.* Build\lib\2.0
}

task NuGet -depends Build {
	copy -recurse NuGet\*.nuspec Build
	push-location Build
	..\Tools\NuGet\NuGet.exe pack log4net.NLogAppender.nuspec
	pop-location
}

task Deploy -depends NuGet {
}

task ? -Description "Helper to display task info" {
	Write-Documentation
}

