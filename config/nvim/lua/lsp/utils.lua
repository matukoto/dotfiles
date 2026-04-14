--j
local o = {}

-- js, ts の設定を共通化
o.tsAndJsInlayHints = {
  parameterNames = {
    enabled = 'all', -- 'none' | 'literals' | 'all'
    suppressWhenArgumentMatchesName = true,
  },
  parameterTypes = { enabled = true },
  variableTypes = { enabled = false },
  propertyDeclarationTypes = { enabled = true },
  functionLikeReturnTypes = { enabled = false },
  enumMemberValues = { enabled = true },
}

return o
