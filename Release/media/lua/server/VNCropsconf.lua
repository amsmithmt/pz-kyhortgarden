require "Farming/farming_vegetableconf"

KYHortconf = {};

-- Pepper
-- Need 6 seeds
-- Water lvl over 65
-- Need 4 weeks to grow (112h per phase)
KYHortconf.growNewCrop = function(planting, nextGrowing, updateNbOfGrow)
	local nbOfGrow = planting.nbOfGrow;
	local water = farming_vegetableconf.calcWater(planting.waterNeeded, planting.waterLvl);
	local diseaseLvl = farming_vegetableconf.calcDisease(planting.mildewLvl);
	if(nbOfGrow <= 0) then -- young
		nbOfGrow = 0;
		planting.nbOfGrow = 0;

		planting = growNext(planting, farming_vegetableconf.getSpriteName(planting), farming_vegetableconf.getObjectName(planting), nextGrowing, farming_vegetableconf.props[planting.typeOfSeed].timeToGrow + water + diseaseLvl);

		planting.waterNeeded = 60;
	elseif (nbOfGrow <= 4) then -- young
		if(water >= 0 and diseaseLvl >= 0) then

			planting = growNext(planting, farming_vegetableconf.getSpriteName(planting), farming_vegetableconf.getObjectName(planting), nextGrowing, farming_vegetableconf.props[planting.typeOfSeed].timeToGrow + water + diseaseLvl);

			planting.waterNeeded = farming_vegetableconf.props[planting.typeOfSeed].waterLvl;
		else
			badPlant(water, nil, diseaseLvl, planting, nextGrowing, updateNbOfGrow);
		end
	elseif (nbOfGrow == 5) then -- mature
		if(water >= 0 and diseaseLvl >= 0) then
			planting.nextGrowing = calcNextGrowing(nextGrowing, farming_vegetableconf.props[planting.typeOfSeed].timeToGrow + water + diseaseLvl);
			planting:setObjectName(farming_vegetableconf.getObjectName(planting))
			planting:setSpriteName(farming_vegetableconf.getSpriteName(planting))
			planting.hasVegetable = true;
		else
			badPlant(water, nil, diseaseLvl, planting, nextGrowing, updateNbOfGrow);
		end
	elseif (nbOfGrow == 6) then -- mature with seed
		if(water >= 0 and diseaseLvl >= 0) then
			planting.nextGrowing = calcNextGrowing(nextGrowing, 168);
			planting:setObjectName(farming_vegetableconf.getObjectName(planting))
			planting:setSpriteName(farming_vegetableconf.getSpriteName(planting))
			planting.hasVegetable = true;
			planting.hasSeed = true;
		else
			badPlant(water, nil, diseaseLvl, planting, nextGrowing, updateNbOfGrow);
		end
	elseif (planting.state ~= "rotten") then -- rotten
		planting:rottenThis()
	end
	return planting;
end



--Icons
farming_vegetableconf.icons["GreenCrack"] = "media/textures/vegIcon/item_cannabisseed.png";
farming_vegetableconf.icons["PurpleKush"] = "media/textures/vegIcon/item_cannabisseed.png";
farming_vegetableconf.icons["NorthernLights"] = "media/textures/vegIcon/item_cannabisseed.png";
farming_vegetableconf.icons["PineappleExpress"] = "media/textures/vegIcon/item_cannabisseed.png";
farming_vegetableconf.icons["BruceBanner"] = "media/textures/vegIcon/item_cannabisseed.png";

-- Green Crack
if not farming_vegetableconf.props["GreenCrack"] then
	farming_vegetableconf.props["GreenCrack"] = {};
end
farming_vegetableconf.props["GreenCrack"].seedsRequired = 3;
farming_vegetableconf.props["GreenCrack"].texture = "VNWeed3_16";
farming_vegetableconf.props["GreenCrack"].waterLvl = 65;
farming_vegetableconf.props["GreenCrack"].timeToGrow = ZombRand(56, 62); -- 56, 62
farming_vegetableconf.props["GreenCrack"].vegetableName = "GreenCrack";
farming_vegetableconf.props["GreenCrack"].seedName = "GreenCrackSeed";
farming_vegetableconf.props["GreenCrack"].growCode = "KYHortconf.growNewCrop";
farming_vegetableconf.props["GreenCrack"].seedPerVeg = 1;
farming_vegetableconf.props["GreenCrack"].minVeg = 3;
farming_vegetableconf.props["GreenCrack"].maxVeg = 5;
farming_vegetableconf.props["GreenCrack"].minVegAutorized = 4;
farming_vegetableconf.props["GreenCrack"].maxVegAutorized = 4;

farming_vegetableconf.sprite["GreenCrack"] = {
	"VNWeed3_16",
	"VNWeed3_0",
	"VNWeed3_2",
	"VNWeed3_4",
	"VNWeed3_8",
	"VNWeed3_6",
	"VNWeed3_10",
	"VNWeed3_12"
}

-- PurpleKush
farming_vegetableconf.props["PurpleKush"] = {};
farming_vegetableconf.props["PurpleKush"].seedsRequired = 4;
farming_vegetableconf.props["PurpleKush"].texture = "VNWeed3_16";
farming_vegetableconf.props["PurpleKush"].waterLvl = 65;
farming_vegetableconf.props["PurpleKush"].timeToGrow = ZombRand(89, 103); --89, 103
farming_vegetableconf.props["PurpleKush"].vegetableName = "PurpleKush";
farming_vegetableconf.props["PurpleKush"].seedName = "PurpleKushSeed";
farming_vegetableconf.props["PurpleKush"].growCode = "KYHortconf.growNewCrop";
farming_vegetableconf.props["PurpleKush"].seedPerVeg = 2;
farming_vegetableconf.props["PurpleKush"].minVeg = 4;
farming_vegetableconf.props["PurpleKush"].maxVeg = 5;
farming_vegetableconf.props["PurpleKush"].minVegAutorized = 4;
farming_vegetableconf.props["PurpleKush"].maxVegAutorized = 4;

farming_vegetableconf.sprite["PurpleKush"] = {
	"VNWeed3_16",
	"VNWeed3_0",
	"VNWeed3_2",
	"VNWeed3_4",
	"VNWeed3_8",
	"VNWeed3_14",
	"VNWeed3_10",
	"VNWeed3_12"
}

-- NorthernLights
if not farming_vegetableconf.props["NorthernLights"] then
	farming_vegetableconf.props["NorthernLights"] = {};
end
farming_vegetableconf.props["NorthernLights"].seedsRequired = 5;
farming_vegetableconf.props["NorthernLights"].texture = "VNWeed3_16";
farming_vegetableconf.props["NorthernLights"].waterLvl = 55;
farming_vegetableconf.props["NorthernLights"].timeToGrow = ZombRand(89, 103); --89, 103
farming_vegetableconf.props["NorthernLights"].vegetableName = "NorthernLights";
farming_vegetableconf.props["NorthernLights"].seedName = "NorthernLightsSeed";
farming_vegetableconf.props["NorthernLights"].growCode = "KYHortconf.growNewCrop";
farming_vegetableconf.props["NorthernLights"].seedPerVeg = 3;
farming_vegetableconf.props["NorthernLights"].minVeg = 4;
farming_vegetableconf.props["NorthernLights"].maxVeg = 5;
farming_vegetableconf.props["NorthernLights"].minVegAutorized = 4;
farming_vegetableconf.props["NorthernLights"].maxVegAutorized = 4;

farming_vegetableconf.sprite["NorthernLights"] = {
	"VNWeed3_16",
	"VNWeed3_0",
	"VNWeed3_2",
	"VNWeed3_4",
	"VNWeed3_8",
	"VNWeed3_22",
	"VNWeed3_10",
	"VNWeed3_12"
}

-- PineappleExpress
if not farming_vegetableconf.props["PineappleExpress"] then
	farming_vegetableconf.props["PineappleExpress"] = {};
end
farming_vegetableconf.props["PineappleExpress"].seedsRequired = 4;
farming_vegetableconf.props["PineappleExpress"].texture = "VNWeed3_16";
farming_vegetableconf.props["PineappleExpress"].waterLvl = 55;
farming_vegetableconf.props["PineappleExpress"].timeToGrow = ZombRand(89, 103); --89, 103
farming_vegetableconf.props["PineappleExpress"].vegetableName = "PineappleExpress";
farming_vegetableconf.props["PineappleExpress"].seedName = "PineappleExpressSeed";
farming_vegetableconf.props["PineappleExpress"].growCode = "KYHortconf.growNewCrop";
farming_vegetableconf.props["PineappleExpress"].seedPerVeg = 2;
farming_vegetableconf.props["PineappleExpress"].minVeg = 4;
farming_vegetableconf.props["PineappleExpress"].maxVeg = 5;
farming_vegetableconf.props["PineappleExpress"].minVegAutorized = 4;
farming_vegetableconf.props["PineappleExpress"].maxVegAutorized = 4;

farming_vegetableconf.sprite["PineappleExpress"] = {
	"VNWeed3_16",
	"VNWeed3_0",
	"VNWeed3_2",
	"VNWeed3_4",
	"VNWeed3_8",
	"VNWeed3_20",
	"VNWeed3_10",
	"VNWeed3_12"
}

-- BruceBanner
if not farming_vegetableconf.props["BruceBanner"] then
	farming_vegetableconf.props["BruceBanner"] = {};
end
farming_vegetableconf.props["BruceBanner"].seedsRequired = 4;
farming_vegetableconf.props["BruceBanner"].texture = "VNWeed3_16";
farming_vegetableconf.props["BruceBanner"].waterLvl = 35;
farming_vegetableconf.props["BruceBanner"].timeToGrow = ZombRand(35, 45); --89, 103
farming_vegetableconf.props["BruceBanner"].vegetableName = "BruceBanner";
farming_vegetableconf.props["BruceBanner"].seedName = "BruceBannerSeed";
farming_vegetableconf.props["BruceBanner"].growCode = "KYHortconf.growNewCrop";
farming_vegetableconf.props["BruceBanner"].seedPerVeg = 2;
farming_vegetableconf.props["BruceBanner"].minVeg = 3;
farming_vegetableconf.props["BruceBanner"].maxVeg = 4;
farming_vegetableconf.props["BruceBanner"].minVegAutorized = 4;
farming_vegetableconf.props["BruceBanner"].maxVegAutorized = 4;

farming_vegetableconf.sprite["BruceBanner"] = {
	"VNWeed3_16",
	"VNWeed3_0",
	"VNWeed3_2",
	"VNWeed3_4",
	"VNWeed3_8",
	"VNWeed3_18",
	"VNWeed3_10",
	"VNWeed3_12"
}

if ProceduralDistributions then
	farming_vegetableconf.props["GreenCrack"].waterLvlMax = 100;
	farming_vegetableconf.props["PurpleKush"].waterLvlMax = 100;
	farming_vegetableconf.props["NorthernLights"].waterLvlMax = 100;
	farming_vegetableconf.props["PineappleExpress"].waterLvlMax = 100;
	farming_vegetableconf.props["BruceBanner"].waterLvlMax = 65;

end