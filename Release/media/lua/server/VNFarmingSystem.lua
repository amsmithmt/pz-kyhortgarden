
    if ProceduralDistributions ~= nil then
        if isClient() then return end
    end

    require "Farming/SFarmingSystem"
    require "Farming/SPlantGlobalObject"
    require "Map/CGlobalObject"

    if (getActivatedMods():contains("Hydrocraft")) then
        require "Farming/HCFarmingSystem"
    end

    -- grow the plant
    function SFarmingSystem:growPlant(luaObject, nextGrowing, updateNbOfGrow)
        if(luaObject.state == "seeded") then
            local new = luaObject.nbOfGrow <= 0

            if (getActivatedMods():contains("FarmingNeverRot")) then
                --NeverRot is this if statement.
                if (luaObject.nbOfGrow >6) then
                    luaObject.nbOfGrow = 6
                end
            end

            if(luaObject.typeOfSeed == "Carrots") then
                luaObject = farming_vegetableconf.growCarrots(luaObject, nextGrowing, updateNbOfGrow)
            elseif(luaObject.typeOfSeed == "Broccoli") then
                luaObject = farming_vegetableconf.growBroccoli(luaObject, nextGrowing, updateNbOfGrow)
            elseif(luaObject.typeOfSeed == "Strawberry plant") then
                luaObject = farming_vegetableconf.growStrewberries(luaObject, nextGrowing, updateNbOfGrow)
            elseif(luaObject.typeOfSeed == "Radishes") then
                luaObject = farming_vegetableconf.growRedRadish(luaObject, nextGrowing, updateNbOfGrow)
            elseif(luaObject.typeOfSeed == "Tomato") then
                luaObject = farming_vegetableconf.growTomato(luaObject, nextGrowing, updateNbOfGrow)
            elseif(luaObject.typeOfSeed == "Potatoes") then
                luaObject = farming_vegetableconf.growPotato(luaObject, nextGrowing, updateNbOfGrow)
            elseif(luaObject.typeOfSeed == "Cabbages") then
                luaObject = farming_vegetableconf.growCabbage(luaObject, nextGrowing, updateNbOfGrow)
            elseif luaObject.typeOfSeed then
                if farming_vegetableconf.props[luaObject.typeOfSeed].growCode ~= nil then
                    local growCode = farming_vegetableconf.props[luaObject.typeOfSeed].growCode
                    luaObject = assert(loadstring('return '..growCode..'(...)'))(luaObject, nextGrowing, updateNbOfGrow)
                end
                if (getActivatedMods():contains("Hydrocraft")) then
                    luaObject = farming_vegetableconf.HCgrowAllPlants(luaObject, nextGrowing, updateNbOfGrow)
                end
            end
            -- maybe this plant gonna be disease
            if not new and luaObject.nbOfGrow > 0 then
                self:diseaseThis(luaObject, true)
            end
            luaObject.nbOfGrow = luaObject.nbOfGrow + 1
        end
    end

    function SPlantGlobalObject:rottenThis()
        local texture = nil
        if self.typeOfSeed == "Carrots" then
            texture = "vegetation_farming_01_13"
        elseif self.typeOfSeed == "Broccoli" then
            texture = "vegetation_farming_01_23"
        elseif self.typeOfSeed == "Strawberry plant" then
            texture = "vegetation_farming_01_63"
        elseif self.typeOfSeed == "Radishes" then
            texture = "vegetation_farming_01_39"
        elseif self.typeOfSeed == "Tomato" then
            texture = "vegetation_farming_01_71"
        elseif self.typeOfSeed == "Potatoes" then
            texture = "vegetation_farming_01_47"
        elseif self.typeOfSeed == "Cabbages" then
            texture = "vegetation_farming_01_31"
        elseif self.typeOfSeed then
            if farming_vegetableconf.sprite[self.typeOfSeed][8] ~= nil then
                texture = farming_vegetableconf.sprite[self.typeOfSeed][8]
            else
                print("jigga says; WARNING: Texture for rotten farming object, '" .. self.typeOfSeed .. ",' was not found! Rotten farming object is now invisible!");
            end
        end
        if texture ~= nil then
            self:setSpriteName(texture)
        end
        self.state = "rotten"
        self:setObjectName(farming_vegetableconf.getObjectName(self))
        self:deadPlant()
    end