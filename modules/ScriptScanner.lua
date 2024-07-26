local ScriptScanner = {}
local LocalScript = import("objects/LocalScript")

local requiredMethods = {
	["getGc"] = true,
	["getSenv"] = true,
	["getProtos"] = true,
	["getConstants"] = true,
	["getScriptClosure"] = true,
	["isXClosure"] = true,
}

local function scan(query)
	local scripts = {}
	query = query or ""

	for _i, v in pairs(getGc()) do
		if type(v) == "function" and not isXClosure(v) then
			local script = rawget(getfenv(v), "script")
			local closureSuccess, scriptClosure = pcall(getScriptClosure, script)
			local scriptEnvSuccess, scriptEnv = pcall(getsenv, script)

			if
				typeof(script) == "Instance"
				and not scripts[script]
				and script:IsA("LocalScript")
				and script.Name:lower():find(query)
				and closureSuccess
				and scriptEnvSuccess
			then
				scripts[script] = LocalScript.new(script, scriptClosure, scriptEnv)
			end
		end
	end

	return scripts
end

ScriptScanner.RequiredMethods = requiredMethods
ScriptScanner.Scan = scan
return ScriptScanner
