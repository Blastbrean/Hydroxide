local LocalScript = {}

function LocalScript.new(instance, scriptClosure, scriptEnv)
    local localScript = {}

    localScript.Instance = instance
    localScript.Environment = scriptEnv
    localScript.Constants = getConstants(scriptClosure)
    localScript.Protos = getProtos(scriptClosure)

    return localScript
end

return LocalScript