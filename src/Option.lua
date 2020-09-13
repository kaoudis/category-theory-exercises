Option = {}

function Option:apply(v)
    self.__index = self

    v = v or nil

    if v == nil then
        is_valid = false
    else
        is_valid = true
    end

    local option = {_is_valid = is_valid, _value = v}

    return setmetatable(option, self)
end

function Option:is_valid()
    return self._is_valid
end

function Option:value()
    return self._value
end

return Option
