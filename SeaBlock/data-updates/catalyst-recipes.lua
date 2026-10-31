-- Update catalyst recipes
-- Angel's returns the catalyst a recipe uses, so swap it in the results too
local function replace_catalyst(recipe_name, old, new)
  bobmods.lib.recipe.replace_ingredient(recipe_name, old, new)
  local recipe = data.raw.recipe[recipe_name]
  for _, result in pairs(recipe and recipe.results or {}) do
    if result.name == old then
      result.name = new
    end
  end
end

bobmods.lib.tech.remove_recipe_unlock("angels-basic-chemistry-3", "angels-catalyst-metal-red")
seablock.lib.hide("item", "angels-catalyst-metal-red")
bobmods.lib.recipe.hide("angels-catalyst-metal-red")

bobmods.lib.recipe.set_ingredients("angels-catalyst-metal-green", {
  { type = "item", name = "angels-catalyst-metal-carrier", amount = 10 },
  { type = "item", name = "copper-ore", amount = 1 },
  { type = "item", name = "iron-ore", amount = 1 },
})
bobmods.lib.recipe.set_ingredients("angels-catalyst-metal-blue", {
  { type = "item", name = "angels-catalyst-metal-carrier", amount = 10 },
  { type = "item", name = "bob-bauxite-ore", amount = 1 },
  { type = "item", name = "bob-silver-ore", amount = 1 },
})
bobmods.lib.tech.add_recipe_unlock("angels-advanced-chemistry-4", "sb-catalyst-metal-purple")

replace_catalyst(
  "angels-liquid-acetic-acid-catalyst",
  "angels-catalyst-metal-red",
  "angels-catalyst-metal-green"
)
replace_catalyst("angels-gas-ammonia", "angels-catalyst-metal-red", "angels-catalyst-metal-green")
replace_catalyst(
  "angels-catalyst-steam-cracking-naphtha",
  "angels-catalyst-metal-red",
  "angels-catalyst-metal-green"
)

replace_catalyst(
  "angels-gas-synthesis-methanol",
  "angels-catalyst-metal-green",
  "angels-catalyst-metal-blue"
)
replace_catalyst(
  "angels-gas-acid-catalyst",
  "angels-catalyst-metal-green",
  "angels-catalyst-metal-blue"
)
replace_catalyst(
  "angels-liquid-styrene",
  "angels-catalyst-metal-green",
  "angels-catalyst-metal-blue"
)
replace_catalyst("angels-gas-benzene", "angels-catalyst-metal-green", "angels-catalyst-metal-blue")
replace_catalyst(
  "angels-liquid-propionic-acid",
  "angels-catalyst-metal-green",
  "angels-catalyst-metal-blue"
)
replace_catalyst(
  "angels-gas-butadiene",
  "angels-catalyst-metal-green",
  "angels-catalyst-metal-blue"
)

replace_catalyst(
  "angels-liquid-naphtha-catalyst",
  "angels-catalyst-metal-red",
  "sb-catalyst-metal-purple"
)
replace_catalyst(
  "angels-solid-sodium-cyanide",
  "angels-catalyst-metal-green",
  "sb-catalyst-metal-purple"
)
replace_catalyst(
  "angels-gas-synthesis-methanation",
  "angels-catalyst-metal-blue",
  "sb-catalyst-metal-purple"
)
replace_catalyst("angels-gas-hydrazine", "angels-catalyst-metal-blue", "sb-catalyst-metal-purple")
replace_catalyst(
  "angels-gas-synthesis-methanol",
  "angels-catalyst-metal-blue",
  "sb-catalyst-metal-purple"
)

replace_catalyst(
  "angels-cumene-process",
  "angels-catalyst-metal-blue",
  "angels-catalyst-metal-yellow"
)

bobmods.lib.recipe.add_new_ingredient(
  "angels-liquid-mineral-oil-catalyst",
  { type = "item", name = "sb-catalyst-metal-purple", amount = 1 }
)
if data.raw.recipe["angels-liquid-mineral-oil-catalyst"] then
  data.raw.recipe["angels-liquid-mineral-oil-catalyst"].main_product = "angels-liquid-mineral-oil"
  local results = data.raw.recipe["angels-liquid-mineral-oil-catalyst"].results
  table.insert(results, {
    type = "item",
    name = "sb-catalyst-metal-purple",
    amount = 1,
    ignored_by_productivity = 1,
    ignored_by_stats = 1,
    shared_probability = { min = 0, max = 0.9 },
  })
  table.insert(results, {
    type = "item",
    name = "angels-catalyst-metal-carrier",
    amount = 1,
    ignored_by_productivity = 1,
    shared_probability = { min = 0.9, max = 1 },
  })
end

bobmods.lib.tech.add_prerequisite("angels-bio-plastic-2", "angels-advanced-chemistry-2")
bobmods.lib.tech.add_prerequisite("angels-sodium-processing-2", "angels-advanced-chemistry-4")
bobmods.lib.tech.add_prerequisite("angels-advanced-chemistry-1", "angels-basic-chemistry-3")
bobmods.lib.tech.add_prerequisite("angels-advanced-chemistry-3", "angels-thermal-water-extraction-2")
bobmods.lib.tech.remove_prerequisite("angels-advanced-chemistry-1", "angels-ore-floatation")

bobmods.lib.tech.add_new_science_pack("angels-nitrogen-processing-3", "production-science-pack", 1)
bobmods.lib.tech.add_prerequisite("angels-nitrogen-processing-3", "angels-advanced-chemistry-4")
bobmods.lib.tech.replace_prerequisite("angels-resin-2", "angels-nitrogen-processing-3", "angels-advanced-chemistry-2")
seablock.lib.moveeffect("angels-air-filter-3", "angels-nitrogen-processing-3", "angels-advanced-chemistry-2", 4)
seablock.lib.moveeffect("angels-gas-melamine", "angels-nitrogen-processing-3", "angels-advanced-chemistry-2")

bobmods.lib.tech.add_new_science_pack("angels-gas-synthesis", "production-science-pack", 1)
bobmods.lib.tech.add_prerequisite("angels-gas-synthesis", "angels-advanced-chemistry-4")

seablock.lib.moveeffect(
  "angels-liquid-mineral-oil-catalyst",
  "angels-advanced-chemistry-3",
  "angels-advanced-chemistry-4"
)
seablock.lib.moveeffect("angels-catalyst-metal-carrier", "angels-basic-chemistry-3", "angels-advanced-chemistry-1", 5)
seablock.lib.moveeffect("angels-catalyst-metal-green", "angels-advanced-chemistry-1", "angels-advanced-chemistry-1", 6)
seablock.lib.moveeffect("angels-catalyst-metal-blue", "angels-advanced-chemistry-3", "angels-advanced-chemistry-2", 8)
seablock.lib.moveeffect("angels-catalyst-metal-yellow", "angels-advanced-chemistry-5", "angels-advanced-chemistry-5", 6)
