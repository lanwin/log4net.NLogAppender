properties {
	$location = (get-location)
	$outdir = join-path $location "Build"
	$bindir = join-path $outdir "Bin"
}

task default -depends NuGet

task Clean { 
	[void](remove-item Build -force -recurse -ea SilentlyContinue)
}

task Rebuild -depends Clean {
	exec { msbuild /nologo /t:rebuild /p:"Configuration=Release;OutDir=$bindir/" "Source/log4net.NLogAppender/log4net.NLogAppender.csproj" }
}

task NuGet -depends Rebuild {
	copy "$location\*.nuspec" Build
	
	push-location Build

	$spec = [xml](get-content log4net.NLogAppender.nuspec);
    $spec.package.metadata.version = ([System.Diagnostics.FileVersionInfo]::GetVersionInfo("$bindir/log4net.NLogAppender.dll").productVersion -replace ".\d+$");
	
    set-content log4net.NLogAppender.nuspec $spec.outerXml;
	
	..\Packages\NuGet\NuGet.exe pack log4net.NLogAppender.nuspec
	pop-location
}

task Deploy -depends NuGet {
	$apikey = get-content ($env:HOMEPATH+"\.nuget_apikey")
	$nupkg = dir "$outdir\*.nupkg"
	.\Packages\NuGet\NuGet.exe push "$nupkg" $apikey
}

task ? -Description "Helper to display task info" {
	Write-Documentation
}

