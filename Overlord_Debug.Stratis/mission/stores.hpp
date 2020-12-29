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


    // -------- Actual -------------
    // set
    class CarrierStoreHelipad {
        vehicleMarkers = 0;
		
        // category
        class carrierfixedwing {
            displayName = "Fixed-Wing Aircraft";
            kindOf = "Vehicles";
            condition = "store_unlocked_carrierfixedwing == true";

            //item
            class B_Plane_Fighter_01_F {
                description = "A carrier-based, multi-role/air-superiority fighter jet.";
                price = 2500;
                stock = 2;
                //picture = "\A3\Soft_F\MRAP_01\Data\UI\MRAP_01_Base_ca.paa";  //this item uses a custom picture
                code = "(_this select 2) setPosASL [26228,28064,24]; (_this select 2) setVehicleReceiveRemoteTargets true;";  //teleports to carrier, activate data links               
                previewScale = 0.8;
                condition = "unit_unlocked_fighterjet == true";
                vehicleInit = "['DarkGreyCamo',['wing_fold_l',1]]";
            };
            class B_UAV_05_F {
                description = "The UCAV Sentinel is a carrier-based, fixed-wing Unmanned Combat Aerial Vehicle";
                price = 1700;
                stock = 2;
                //picture = "\A3\Soft_F\MRAP_01\Data\UI\MRAP_01_Base_ca.paa";  //this item uses a custom picture
                code = "(_this select 2) setPosASL [26228,28064,24]; createVehicleCrew (_this select 2); (_this select 2) setVehicleReceiveRemoteTargets true; (_this select 2) setVehicleReportRemoteTargets true;(_this select 2) setVehicleReportOwnPosition true";  //teleports to carrier, add AI crew, activate data links
                previewScale = 0.8;
                condition = "unit_unlocked_uavjet == true";
                vehicleInit = "['DarkGreyCamo',['wing_fold_l',1]]";
            };
            class B_Plane_CAS_01_dynamicLoadout_F {
                description = "A CAS aircraft. [Warning: Can't land on carrier!]";
                price = 1500;
                stock = 2;
                //picture = "\A3\Soft_F\MRAP_01\Data\UI\MRAP_01_Base_ca.paa";  //this item uses a custom picture
                code = "(_this select 2) setPosASL [26228,28064,24]; (_this select 2) setVehicleReceiveRemoteTargets true;";  //teleports to carrier, activate data links               
                previewScale = 0.8;
                condition = "unit_unlocked_casplane == true";
            };
            class B_UAV_02_dynamicLoadout_F {
                description = "A fixed-wing recon UCAV. [Warning: Can't land on carrier!]";
                price = 1200;
                stock = 2;
                //picture = "\A3\Soft_F\MRAP_01\Data\UI\MRAP_01_Base_ca.paa";  //this item uses a custom picture
                code = "(_this select 2) setPosASL [26228,28064,24]; createVehicleCrew (_this select 2); (_this select 2) setVehicleReceiveRemoteTargets true; (_this select 2) setVehicleReportRemoteTargets true;(_this select 2) setVehicleReportOwnPosition true";  //teleports to carrier, add AI crew, activate data links            
                previewScale = 0.8;
                condition = "unit_unlocked_ucav == true";
            };
        };
        // category
        class carrierchoppa {
            displayName = "Helicopters";
            kindOf = "Vehicles";
            condition = "store_unlocked_carrierchopper == true";

            //item
            class B_Heli_Light_01_dynamicLoadout_F {
                description = "A light attack helicopter.";
                price = 600;
                stock = 4;
                //picture = "\A3\Soft_F\MRAP_01\Data\UI\MRAP_01_Base_ca.paa";  //this item uses a custom picture
                code = "(_this select 2) setPosASL [26228,28064,24]";  //teleports to carrier               
                //vehicleInit = "['Orange',false]";
            };/* Bounces around?*/
            class B_T_UAV_03_dynamicLoadout_F {
                description = "The MQ-12 is a rotary-wing Unmanned Combat Aerial Vehicle.";
                price = 1000;
                stock = 3;
                //picture = "\A3\Soft_F\MRAP_01\Data\UI\MRAP_01_Base_ca.paa";  //this item uses a custom picture
                code = "(_this select 2) setPosASL [26228,28064,24.5]; (_this select 0) addItem 'B_UavTerminal'; (_this select 0) assignItem 'B_UavTerminal'; createVehicleCrew (_this select 2); (_this select 0) ; (_this select 2) setVehicleReceiveRemoteTargets true; (_this select 2) setVehicleReportRemoteTargets true;(_this select 2) setVehicleReportOwnPosition true";  //teleports to carrier, add AI crew, give UAV controls, activate data links  
                condition = "unit_unlocked_uavhelo == true";
                previewScale = 0.75;
            };
            class B_Heli_Attack_01_dynamicLoadout_F {
                description = "A reconnaissance attack helicopter.";
                price = 1000;
                stock = 3;
                //picture = "\A3\Soft_F\MRAP_01\Data\UI\MRAP_01_Base_ca.paa";  //this item uses a custom picture
                code = "(_this select 2) setPosASL [26228,28064,24]; setVehicleReceiveRemoteTargets true; (_this select 2) setVehicleReportRemoteTargets true;(_this select 2) setVehicleReportOwnPosition true";  //teleports to carrier and datalink
                condition = "unit_unlocked_attackhelo == true";              
            };
        };
        /* Bugged pathfinding
        // category
        class ChoppaCrew {
            displayname = "Crew";
            kindOf = "Units";
            tracking = 0;

            class B_helicrew_F {
                description = "A crewmate.";
                price = 10;
                amount = 1;
                stock = 40;
                code = "{[_x] join player; _x setPosASL [26218,28053,24]} forEach units (_this select 2)";
            };
        };
        */

        // category
        class UAVItems {
            displayName = "Carriable UAVs";
            kindOf = "Wearables";

            class B_UAV_01_backpack_F {
                description = "A small UAV carriable on your back.";
                price = 20;
                stock = 20;
                code = "(_this select 2) setPosASL [26218,28053,24]; (_this select 0) addItem 'B_UavTerminal'; (_this select 0) assignItem 'B_UavTerminal'";
            };
        };
    };
};