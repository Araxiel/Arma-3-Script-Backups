class CfgGradBuymenu {
    playersLoseMoneyOnDeath = 0;
    vehicleMarkers = 1;
    tracking = 1;
    trackingTag = "myMission";

    //buyables set:
    class AmericanStuff {

        //category:  
        class Weapons {
            kindOf = "Weapons";
            displayName = "Weapons";

            //items of this category:
            class arifle_MX_SW_F {
                //displayName = "MX SW";
                //description = "The M240 is a belt-fed, gas-operated general purpose machine gun firing the 7.62x51mm NATO cartridge.";
                price = 2500;
                stock = 5;
                opticsItem = "optic_Aco";
            };
        };
		
        class Vehicles {
            displayName = "Vehicles";
            kindOf = "Vehicles";

            class B_MRAP_01_hmg_F {
                displayName = "MRAP HMG";
                description = "This thing is quick";
                price = 4000;
                stock = 10;
                picture = "\A3\Soft_F\MRAP_01\Data\UI\MRAP_01_Base_ca.paa";  //this item uses a custom picture
                code = "(_this select 2) setFuel 0.5";  //this car will spawn with half a tank of gas                
                spawnEmpty = true;
                vehicleInit = "['Orange',false]";
            };
        };

        class Units {
            displayname = "Units";
            kindOf = "Units";
            tracking = 0;

            class B_Soldier_SL_F {
                displayName = "NATO Squadleader (x3)";
                description = "This is a team of NATO squad leaders.";
                price = 3000;
                amount = 3;
                stock = 5;
                code = "{_x removeWeaponGlobal (primaryWeapon _x);[_x] join player;} forEach units (_this select 2)";
            };
        };
    };

    //a different set of buyables
    class RussianStuff {        
        class Vehicles {
            displayName = "Vehicles";
            kindOf = "Vehicles";

            class C_Hatchback_01_sport_F {
                displayName = "Hatchback (Sport)";
                description = "This thing is quick";
                price = 4000;
                stock = 10;
                picture = "myPictureFolder\sportscar.paa";  //this item uses a custom picture
                code = "(_this select 2) setFuel 0.5";  //this car will spawn with half a tank of gas                
                spawnEmpty = true;
                vehicleInit = "['Orange',false]";
            };
        };

        class Items {
            displayName = "Items";
            kindOf = "Items";

            class ACE_fieldDressing {
                displayName = "Bandages (x10)";
                description = "10 simple bandages in sterile packaging.";
                amount = 10;
                price = 100;
                stock = 40;     //note that a total of 400 bandages can be bought (in sets of 10)
            };
        };
    };
    
};