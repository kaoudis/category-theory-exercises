require "busted.runner"()

-- Exercise 4.4 from "Category Theory for Programmers"
-- 1. Construct the Kleisli category for partial functions (define composition
-- and identity)
-- 2. Implement the embellished function `safe_reciprocal` which returns a
-- valid reciprocal of its argument, if the argument is not equal to 0
-- 3. Compose the functions `safe_root` and safe_reciprocal to implement
-- safe_root_reciprocal that calculates sqrt(1/x) whenever possible

describe("Constructing the Kleisli category for partial functions: ", function()
    local Kleisli = require "Kleisli"
    local Option = require "Option"

    local function safe_root(x)
        assert(type(x) == "number", "safe_root: x must be a number")

        if (x >= 0) then
            return Option:apply(math.sqrt(x))
        else
            return Option:apply()
        end
    end

    it("safe_root is not defined at -1", function()
        local undefined = safe_root(-1)

        assert.is_false(undefined:is_valid())
        assert.falsy(undefined:value())
    end)

    it("safe_root has identity", function()
        local identity = safe_root(1)

        assert.is_true(identity:is_valid())
        assert.are.equal(identity:value(), 1)
    end)

    it("safe_root can be composed", function()
        local composed = Kleisli:compose(safe_root, safe_root, 1024)

        assert.is_true(composed:is_valid())
        assert.are.equal(composed:value(), math.sqrt(math.sqrt(1024)))
    end)

    local function safe_reciprocal(x)
        assert(type(x) == "number", "safe_reciprocal: x must be a number")

        if (x ~= 0) then
            return Option:apply(1/x)
        else
            return Option:apply()
        end
    end

    it("safe_reciprocal is not defined at 0", function()
        local undefined = safe_reciprocal(0)

        assert.is_false(undefined:is_valid())
        assert.falsy(undefined:value())
    end)

    it("safe_reciprocal has identity", function()
        local identity = safe_reciprocal(1)

        assert.is_true(identity:is_valid())
        assert.are.equal(identity:value(), 1)
    end)

    it("safe_reciprocal can be composed", function()
        local composed = Kleisli:compose(safe_reciprocal, safe_reciprocal, 2)
        assert.is_true(composed:is_valid())
        assert.are.equal(composed:value(), 2)
    end)

    local function safe_root_reciprocal(x)
        return Kleisli:compose(safe_reciprocal, safe_root, x)
    end

    it("safe_root and safe_reciprocal can be composed", function()
        local happy_path = safe_root_reciprocal(2)

        assert.is_true(happy_path:is_valid())
        assert.are.equal(happy_path:value(), math.sqrt(1/2))
    end)

    it("safe_root_reciprocal of something that does not work for safe_root is empty", function()
        local result = safe_root_reciprocal(-1)

        assert.is_false(result:is_valid())
        assert.falsy(result:value())
    end)

    it("safe_root_reciprocal of something that does not work for safe_reciprocal is empty", function()
        local result = safe_root_reciprocal(0)

        assert.is_false(result:is_valid())
        assert.falsy(result:value())
    end)
end)
