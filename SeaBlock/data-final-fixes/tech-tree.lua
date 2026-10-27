-- ScienceCostTweakerM moves its sct-*-science-pack techs onto the base names in data-final-fixes,
-- so point prerequisites added in data-updates at the new names
if mods["ScienceCostTweakerM"] then
  for tech_name, tech in pairs(data.raw.technology) do
    if tech.prerequisites then
      local prerequisites = {}
      local seen = {}
      for _, prerequisite in pairs(tech.prerequisites) do
        if not data.raw.technology[prerequisite] and prerequisite:sub(1, 4) == "sct-" then
          local renamed = prerequisite:sub(5)
          if data.raw.technology[renamed] then
            prerequisite = renamed
          end
        end
        if prerequisite ~= tech_name and not seen[prerequisite] then
          seen[prerequisite] = true
          table.insert(prerequisites, prerequisite)
        end
      end
      tech.prerequisites = prerequisites
    end
  end
end

-- A disabled prerequisite can never be researched, which locks out everything after it.
-- Angel's 2.1 disables Bob's zinc and cobalt processing, so use Angel's smelting instead,
-- and otherwise fall back to the disabled tech's own prerequisites.
do
  local stand_ins = {
    ["bob-zinc-processing"] = "angels-zinc-smelting-1",
    ["bob-cobalt-processing"] = "angels-cobalt-smelting-1",
  }
  local function is_disabled(name)
    local tech = data.raw.technology[name]
    return tech and tech.enabled == false
  end
  local function resolve(name, out, seen)
    if seen[name] then
      return
    end
    seen[name] = true
    if not is_disabled(name) then
      table.insert(out, name)
      return
    end
    local stand_in = stand_ins[name]
    if stand_in and data.raw.technology[stand_in] and not is_disabled(stand_in) then
      table.insert(out, stand_in)
      return
    end
    for _, prerequisite in pairs(data.raw.technology[name].prerequisites or {}) do
      resolve(prerequisite, out, seen)
    end
  end
  for tech_name, tech in pairs(data.raw.technology) do
    if tech.enabled ~= false and tech.prerequisites then
      local needs_fix = false
      for _, prerequisite in pairs(tech.prerequisites) do
        if is_disabled(prerequisite) then
          needs_fix = true
        end
      end
      if needs_fix then
        local resolved = {}
        local seen = { [tech_name] = true }
        for _, prerequisite in pairs(tech.prerequisites) do
          resolve(prerequisite, resolved, seen)
        end
        tech.prerequisites = resolved
      end
    end
  end
end

-- Remove empty bob's techs
bobmods.lib.tech.remove_prerequisite("bob-cobalt-processing", "bob-chemical-processing-1")
bobmods.lib.tech.remove_prerequisite("bob-grinding", "bob-chemical-processing-1")
bobmods.lib.tech.remove_prerequisite("bob-lithium-processing", "bob-chemical-processing-1")

bobmods.lib.tech.remove_prerequisite("bob-cobalt-processing", "bob-chemical-processing-2")
bobmods.lib.tech.remove_prerequisite("bob-silicon-processing", "bob-chemical-processing-2")
bobmods.lib.tech.remove_prerequisite("advanced-circuit", "bob-chemical-processing-2")
bobmods.lib.tech.remove_prerequisite("bob-titanium-processing", "bob-chemical-processing-2")
bobmods.lib.tech.remove_prerequisite("bob-tungsten-processing", "bob-chemical-processing-2")

seablock.lib.hide_technology("bob-electrolysis-1")
seablock.lib.hide_technology("bob-electrolysis-2")
seablock.lib.hide_technology("bob-chemical-processing-1")
seablock.lib.hide_technology("bob-chemical-processing-2")

bobmods.lib.tech.remove_prerequisite("circuit-network", "angels-bio-wood-processing-2")
bobmods.lib.tech.add_prerequisite("circuit-network", "angels-bio-paper-1")
bobmods.lib.tech.remove_prerequisite("angels-rubbers", "circuit-network")

-- Unhide solid fuel from hydrogen
seablock.lib.unhide("recipe", "bob-solid-fuel-from-hydrogen")
seablock.lib.add_recipe_unlock("flammables", "bob-solid-fuel-from-hydrogen", 4)

bobmods.lib.tech.replace_prerequisite(
  "bob-lithium-processing",
  "angels-chlorine-processing-4",
  "angels-chlorine-processing-2"
)
