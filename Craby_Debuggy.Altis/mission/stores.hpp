class CfgGradBuymenu {
    playersLoseMoneyOnDeath = 0;
    vehicleMarkers = 1;
    tracking = 0;
    trackingTag = "myMission";

    class AirportStore {
		
        class airportfixedwing {
            displayName = "Fixed-Wing Aircraft";
            kindOf = "Vehicles";

            class B_Plane_Fighter_01_F {
                description = "A carrier-based, multi-role/air-superiority fighter jet.";
                price = 2500;
                stock = 2;
                code = "(_this select 2) setVehicleReceiveRemoteTargets true;";
                previewScale = 0.8;
                condition = "601670 in (getDLCs 1)";
                vehicleInit = "['DarkGreyCamo',['wing_fold_l',1]]";
            };
            class B_UAV_02_dynamicLoadout_F {
                description = "A fixed-wing recon UCAV.";
                price = 1200;
                stock = 2;
                code = "createVehicleCrew (_this select 2); (_this select 2) setVehicleReceiveRemoteTargets true; (_this select 2) setVehicleReportRemoteTargets true; (_this select 2) setVehicleReportOwnPosition true";
                previewScale = 0.8;
            };
        };

        class airportchoppa {
            displayName = "Helicopters";
            kindOf = "Vehicles";

            // Pawnee
            class B_Heli_Light_01_dynamicLoadout_F {
                description = "A light attack helicopter.";
                price = 600;
                stock = 4;
            };
            // Apache
            class B_Heli_Attack_01_dynamicLoadout_F {
                description = "A reconnaissance attack helicopter.";
                price = 1000;
                stock = 3;
                code = "(_this select 2) setVehicleReceiveRemoteTargets true; (_this select 2) setVehicleReportRemoteTargets true; (_this select 2) setVehicleReportOwnPosition true";
                condition = "395180 in (getDLCs 1)";
            };
            class B_T_UAV_03_dynamicLoadout_F {
                description = "The MQ-12 is a rotary-wing Unmanned Combat Aerial Vehicle.";
                price = 1000;
                stock = 3;
                code = "(_this select 0) addItem 'B_UavTerminal'; (_this select 0) assignItem 'B_UavTerminal'; createVehicleCrew (_this select 2); (_this select 2) setVehicleReceiveRemoteTargets true; (_this select 2) setVehicleReportRemoteTargets true;(_this select 2) setVehicleReportOwnPosition true";  //add AI crew, give UAV controls, activate data links  
                previewScale = 0.75;
            };
        };

        class airportcrew {
            displayname = "Crew";
            kindOf = "Units";

            class B_helicrew_F {
                description = "A crewmate.";
                price = 10;
                amount = 1;
                stock = 40;
                code = "{[_x] join player; [_x, 0, ['ACE_MainActions'], action_dismiss_unit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this select 2)";
            };
        };

    };

    // default example: buyables set:
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

    // default example: a different set of buyables
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