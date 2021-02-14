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
                price = 1000;
                stock = 10;
                code = "(_this select 2) setVehicleReceiveRemoteTargets true;";
                previewScale = 0.8;
                condition = "601670 in (getDLCs 1)";
                vehicleInit = "['DarkGreyCamo',['wing_fold_l',1]]";
            };
            class B_Plane_CAS_01_dynamicLoadout_F {
                description = "A ground attack and Close Air Support jet.";
                price = 800;
                stock = 10;
                code = "(_this select 2) setVehicleReceiveRemoteTargets true;";
                previewScale = 0.8;
                condition = "601670 in (getDLCs 1)";
                vehicleInit = "['DarkGreyCamo',['wing_fold_l',1]]";
            };
            class B_UAV_02_dynamicLoadout_F {
                description = "A fixed-wing recon UCAV.";
                price = 800;
                stock = 10;
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
                price = 250;
                stock = 10;
            };
            // Apache
            class B_Heli_Attack_01_dynamicLoadout_F {
                description = "A reconnaissance attack helicopter.";
                price = 450;
                stock = 10;
                code = "(_this select 2) setVehicleReceiveRemoteTargets true; (_this select 2) setVehicleReportRemoteTargets true; (_this select 2) setVehicleReportOwnPosition true";
            };
            // Chinook
            class B_Heli_Transport_03_F {
                description = "A heavy transport helicopter.";
                price = 300;
                stock = 10;
                code = "(_this select 2) setVehicleReportOwnPosition true";
                condition = "395180 in (getDLCs 1)";
            };
            // Ghost Hawk
            class B_Heli_Transport_01_F {
                description = "A medium-lift utility helicopter.";
                price = 250;
                stock = 10;
                code = "(_this select 2) setVehicleReportOwnPosition true";
                vehicleInit = "['Green',true]";
            };
            // Little Bird
            class B_Heli_Light_01_F {
                description = "A light observation and transport helicopter.";
                price = 100;
                stock = 10;
                code = "(_this select 2) setVehicleReportOwnPosition true";
                vehicleInit = "[['AddTread',1],['AddTread_Short',0]]";
            };
            // Falcon
            class B_T_UAV_03_dynamicLoadout_F {
                description = "The MQ-12 is a rotary-wing Unmanned Combat Aerial Vehicle.";
                price = 550;
                stock = 10;
                code = "createVehicleCrew (_this select 2); (_this select 2) setVehicleReceiveRemoteTargets true; (_this select 2) setVehicleReportRemoteTargets true;(_this select 2) setVehicleReportOwnPosition true";  //add AI crew, give UAV controls, activate data links  
                previewScale = 0.75;
                condition = "395180 in (getDLCs 1)";
            };
        };

        class airportcrew {
            displayname = "Crew";
            kindOf = "Units";

            class B_helicrew_F {
                description = "A crewmate.";
                price = 8;
                amount = 1;
                stock = 10;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this select 2)";
            };
        };

    };

    class MainStuff {
		
        class mainStuffSoldiers {
            displayName = "Soldiers";
            kindOf = "Units";

            class B_Soldier_F {
                description = "A rifleman.";
                price = 10;
                amount = 1;
                stock = 30;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this #2)";
            };
            class B_soldier_AR_F {
                description = "A rifleman with an LMG.";
                price = 11;
                amount = 1;
                stock = 30;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this #2)";
            };
            class B_Soldier_GL_F {
                description = "A rifleman with an underbarrel grenade launcher.";
                price = 11;
                amount = 1;
                stock = 30;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this #2)";
            };
            class B_HeavyGunner_F {
                description = "A soldier with a MG.";
                price = 13;
                amount = 1;
                stock = 30;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this #2)";
            };
            class B_soldier_M_F {
                description = "A soldier with a marksman rifle.";
                price = 15;
                amount = 1;
                stock = 30;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this #2)";
            };
            class B_Sharpshooter_F {
                description = "A soldier with a sniper rifle.";
                price = 16;
                amount = 1;
                stock = 30;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this #2)";
            };
            class B_Soldier_TL_F {
                description = "A soldier with the tools to command a fireteam.";
                price = 13;
                amount = 1;
                stock = 30;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this #2)";
            };
            class B_medic_F {
                description = "A medic.";
                price = 12;
                amount = 1;
                stock = 30;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this #2)";
            };

            class B_soldier_LAT2_F {
                description = "An anti-tank soldier carrying a light anti-tank recoilles rifle.";
                price = 13;
                amount = 1;
                stock = 30;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this #2)";
            };
            class B_soldier_LAT_F {
                description = "An anti-tank soldier carrying an anti-tank rocket launcher.";
                price = 14;
                amount = 1;
                stock = 30;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this #2)";
            };
            class B_soldier_AT_F {
                description = "An anti-tank soldier with a ATGM.";
                price = 16;
                amount = 1;
                stock = 30;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this #2)";
            };
            class B_soldier_AA_F {
                description = "An anti-tank soldier with a light SAM.";
                price = 13;
                amount = 1;
                stock = 30;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this #2)";
            };

            class B_engineer_F {
                description = "A combat engineer.";
                price = 13;
                amount = 1;
                stock = 30;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this #2)";
            };
            class B_soldier_exp_F {
                description = "A explosive weapons specialist that can plant and disarm ordinance.";
                price = 13;
                amount = 1;
                stock = 30;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this #2)";
            };
            class B_Soldier_A_F {
                description = "An ammo bearer.";
                price = 11;
                amount = 1;
                stock = 30;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this #2)";
            };
            class B_spotter_F {
                description = "A spotter.";
                price = 15;
                amount = 1;
                stock = 10;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this #2)";
            };
            class B_ghillie_ard_F {
                description = "Sniper.";
                price = 20;
                amount = 1;
                stock = 10;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this #2)";
            };
            class B_soldier_UAV_F {
                description = "An UAV operator carrying a darter.";
                price = 25;
                amount = 1;
                stock = 10;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this #2)";
            };
            class B_crew_F {
                description = "A crewman.";
                price = 8;
                amount = 1;
                stock = 40;
                code = "{[_x] join _this #0; [_x, 0, ['ACE_MainActions'], action_dismissUnit] call ace_interact_menu_fnc_addActionToObject;} forEach units (_this #2)";
            };
        };

        class mainStuffCars {
            displayName = "Cars";
            kindOf = "Vehicles";

            class B_Quadbike_01_F {
                description = "A very small ATV for two.";
                price = 15;
                stock = 20;
            };
            class B_Truck_01_covered_F {
                description = "A heavy tactical truck. Has space for 17 passengers, excluding the driver.";
                price = 50;
                stock = 20;
            };
            class B_LSV_01_unarmed_F {
                description = "A light strike vehicle. Has space for 7 people, including the driver.";
                price = 50;
                stock = 20;
                condition = "395180 in (getDLCs 1)";
            };
            class B_LSV_01_armed_F {
                description = "An armed light strike vehicle. Has space for 5 people, include the driver and gunners.";
                price = 75;
                stock = 10;
                condition = "395180 in (getDLCs 1)";
            };
            class B_LSV_01_AT_F {
                description = "An armed light strike vehicle, equipped with an ATGM. Has space for 5 people, include the driver and gunners.";
                price = 75;
                stock = 10;
                condition = "395180 in (getDLCs 1)";
                previewScale = 0.8;
            };
            class B_MRAP_01_F {
                description = "A lightly armored MRAP. Has space for 4 passengers, including the driver.";
                price = 65;
                stock = 20;
            };
            class B_MRAP_01_hmg_F {
                description = "A lightly armored MRAP, armed with a remote MG. Has space for 4 people, include the driver and gunner.";
                price = 80;
                stock = 8;
            };
            class B_MRAP_01_gmg_F {
                description = "A lightly armored MRAP, armed with a remote grenade launcher. Has space for 4 people, include the driver and gunner.";
                price = 100;
                stock = 8;
            };

            class B_UGV_01_F {
                description = "An unmanned ground vehicle. Along with a full suite of sensors, it can transport 1 passenger.";
                price = 85;
                stock = 3;
                code = "createVehicleCrew (_this select 2); (_this select 2) setVehicleReceiveRemoteTargets true; (_this select 2) setVehicleReportRemoteTargets true;(_this select 2) setVehicleReportOwnPosition true";  //add AI crew, give UAV controls, activate data links  
            };
            class B_UGV_01_rcws_F {
                description = "An unmanned ground combat vehicle. Armed with an HMG and a GMG, it can also carry 1 passenger.";
                price = 120;
                stock = 2;
                code = "createVehicleCrew (_this select 2); (_this select 2) setVehicleReceiveRemoteTargets true; (_this select 2) setVehicleReportRemoteTargets true;(_this select 2) setVehicleReportOwnPosition true";  //add AI crew, give UAV controls, activate data links  
            };
        };

        class mainStuffArmored {
            displayName = "Armored Vehicles";
            kindOf = "Vehicles";

            class B_APC_Wheeled_01_cannon_F {
                description = "An up-armored, wheeled Infantry Fighting Vehicle, armed with an autocannon. Has space for 8 passengers, excluding the driver, gunner and commander.";
                price = 130;
                stock = 6;
                vehicleInit = "[['showBags',1],['showSLATHull',1],['showSLATTurret',1]]";
                previewScale = 0.8;
            };
            class I_APC_Wheeled_03_cannon_F {
                description = "A wheeled Infantry Fighting Vehicle, armed with an 30mm autocannon and ATGMs. Has space for 8 passengers, excluding the driver, gunner and commander.";
                price = 145;
                stock = 6;
                vehicleInit = "['showCamonetHull',0,'showBags',1,'showBags2',1,'showTools',1,'showSLATHull',1]";
                previewScale = 0.8;
            };
            class B_APC_Tracked_01_rcws_F {
                description = "A heavily armored tracked Armoured Personnel Carrier. Has space for 8 passengers, excluding the driver, gunner and commander.";
                price = 135;
                stock = 6;
                vehicleInit = "[['showBags',true]]";
                previewScale = 0.8;
            };

            class B_AFV_Wheeled_01_cannon_F {
                description = "A wheeled tank destroyer, armed with a powerful 120 mm and ATGMs.";
                price = 180;
                stock = 4;
                vehicleInit = "[ ['showCamonetHull',true], ['showCamonetTurret',true] ]";
                condition = "798390 in (getDLCs 1)";
                previewScale = 0.8;
            };
            class B_AFV_Wheeled_01_up_cannon_F {
                description = "An up-armored and up-gunned wheeled tank destroyer, armed with a powerful 120 mm and ATGMs.";
                price = 200;
                stock = 2;
                vehicleInit = "[ ['showSLATHull',true] ]";
                condition = "798390 in (getDLCs 1)";
                previewScale = 0.8;
            };

            class B_MBT_01_cannon_F {
                description = "A heavily armored MBT. Can transport 6 Passengers in the back.";
                price = 250;
                stock = 3;
                vehicleInit = "[ ['showBags',true] ]";
                previewScale = 0.8;
            };
            class B_MBT_01_TUSK_F {
                description = "A command variant of the MBT, with additional armor and armament. Can transport 6 Passengers in the back.";
                price = 280;
                stock = 1;
                vehicleInit = "[ ['showCamonetTurret',true], ['showCamonetHull',true] ]";
                previewScale = 0.8;
            };

            class I_LT_01_scout_F {
                description = "A multi-purpose Light Tank. This is the unarmed command variant, equipped with improved optics, radar and comms.";
                price = 120;
                stock = 2;
                vehicleInit = "[['Indep_Olive',true], ['showCamonetHull',true] ]";
                condition = "798390 in (getDLCs 1)";
            };
            class I_LT_01_cannon_F {
                description = "A multi-purpose Light Tank. This is the canon variant, equipped with a 20 mm autocannon.";
                price = 140;
                stock = 3;
                vehicleInit = "[['Indep_Olive',true], ['showTools',true], ['showBags',true], ['showSLATHull',true] ]";
                condition = "798390 in (getDLCs 1)";
            };
            class I_LT_01_AT_F {
                description = "A multi-purpose Light Tank. This is the AT variant, equipped with a 12.7 mm heavy machine gun and ATGMs.";
                price = 160;
                stock = 3;
                vehicleInit = "[['Indep_Olive',true], ['showTools', true], ['showBags'true ]";
                condition = "798390 in (getDLCs 1)";
            };
            class I_LT_01_AA_F {
                description = "A multi-purpose Light Tank. This is the AA variant, equipped with a 12.7 mm heavy machine gun and SAMs.";
                price = 150;
                stock = 2;
                vehicleInit = "[['Indep_Olive',true], ['showCamonetHull', true ]";
                condition = "798390 in (getDLCs 1)";
            };

        };

        class mainStuffLogistics {
            displayName = "Logistics";
            kindOf = "Vehicles";

            class B_Truck_01_medical_F {
                description = "Medical support/transport variant of the heavy tactical truck. Allows better treatment of those transported. Has space for 15 passengers, excluding the driver.";
                price = 25;
                stock = 5;
            };
            class B_Truck_01_Repair_F {
                description = "A repair variant with spare parts, tools, and components of the heavy tactical truck. Allows much better repairs of other vehicles.";
                price = 25;
                stock = 5;
            };
            class B_Truck_01_fuel_F {
                description = "A large fuel tanker variant of the heavy tactical truck.";
                price = 25;
                stock = 5;
            };
            class B_Truck_01_ammo_F {
                description = "An ammunition supply variant of the heavy tactical truck, with a large semi-hexagon shaped, tarpaulin-covered container. Helps with the rearming of vehicles.";
                price = 30;
                stock = 5;
            };
        };

        class mainStuffEquipment {
            displayName = "Special Equipment";
            kindOf = "Wearables";

            class NVGogglesB_gry_F {
                description = "Advanced night-vision goggles, that include thermal vision.";
                amount = 1;
                price = 5;
                stock = 24;
            };
            class H_HelmetO_ViperSP_hex_F {
                description = "Highly advanced special helmet.";
                amount = 1;
                price = 7;
                stock = 12;
            };

            class B_UAV_01_backpack_F {
                description = "A small recon drone.";
                amount = 1;
                price = 20;
                stock = 6;
            };
            class B_UAV_06_backpack_F {
                description = "A small utility drone, able to deliver some small equipment.";
                amount = 1;
                price = 20;
                stock = 6;
                condition = "571710 in (getDLCs 1)";
            };

            class B_HMG_01_high_weapon_F {
                description = "The upper part of an HMG.";
                amount = 1;
                price = 8;
                stock = 10;
            };
            class B_AT_01_weapon_F {
                description = "The upper part of an ATGM.";
                amount = 1;
                price = 12;
                stock = 8;
            };
            class B_AA_01_weapon_F {
                description = "The upper part of an SAM.";
                amount = 1;
                price = 10;
                stock = 8;
            };
            class B_HMG_01_support_high_F {
                description = "The support tripod for the HMG, the ATGM and the SAM.";
                amount = 1;
                price = 4;
                stock = 20;
            };
            class B_GMG_01_weapon_F {
                description = "The upper part of an GMG.";
                amount = 1;
                price = 10;
                stock = 8;
            };
            class B_GMG_01_A_weapon_F {
                description = "The upper part of an Autonomous GMG.";
                amount = 1;
                price = 17;
                stock = 8;
            };
            class B_HMG_01_A_weapon_F {
                description = "The upper part of an Autonomous HMG.";
                amount = 1;
                price = 14;
                stock = 8;
            };
            class B_HMG_01_support_F {
                description = "The low support of Autonomous weapons and the GMG.";
                amount = 1;
                price = 10;
                stock = 20;
            };
            class B_Mortar_01_support_F {
                description = "A mortar bipod.";
                amount = 1;
                price = 70;
                stock = 2;
            };
            class B_Mortar_01_weapon_F {
                description = "A mortar tube.";
                amount = 1;
                price = 50;
                stock = 2;
            };

            class B_Respawn_TentDome_F {
                description = "Allows to set up a camp, which is can be used as a forward respawn point.";
                amount = 1;
                price = 200;
                stock = 2;
            };

        };

    };

};