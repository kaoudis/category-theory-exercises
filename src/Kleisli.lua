Option = require "src.Option"

Kleisli = {}
Kleisli.__index = Kleisli

-- Compose two functions ("func") which both take a single argument
-- and produce Option boxed values
function Kleisli:compose(func1, func2, arg)
    local first_result = func1(arg)

    if first_result:is_valid() then
        return func2(first_result:value())
    else
        return first_result
    end
end

-- Abstract function composition including "embellishment"
-- where embellishment is an endofunctor in our Kleisli category.
function Kleisli:apply(func1, func2, embellishment, func_arg)
    return embellishment(compose(func1, func2, func_arg))
end

return Kleisli
