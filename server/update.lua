local function checkVersion(err, githubContent, headers)
    local resourceName = GetCurrentResourceName()
    local installedVersion = GetResourceMetadata(resourceName, "version", 0)
	local githubVersion = '0.0.0'
	
    if err == 200 and githubContent then
        for line in githubContent:gmatch("[^\r\n]+") do
            if line:find("version") and not line:find("fx_version") then
                githubVersion = line:match("version%s+'([^']+)'")
                break
            end
        end

        if installedVersion == githubVersion then
            print("^2[VERSION] ^7" .. resourceName .. " is up to date!")
        else
            print("^1[VERSION] ^7" .. resourceName .. " is outdated! Installed: " .. installedVersion .. ", GitHub: " .. githubVersion)
			print("https://github.com/tr1ggerderler/td-moneywash")
        end
    else
        print("^3[VERSION] ^7Failed to fetch fxmanifest.lua from GitHub for resource: " .. resourceName)
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        Wait(3000)
        local githubManifestURL = "https://raw.githubusercontent.com/tr1ggerderler/td-moneywash/master/fxmanifest.lua"
        PerformHttpRequest(githubManifestURL, checkVersion, "GET")
    end
end)
