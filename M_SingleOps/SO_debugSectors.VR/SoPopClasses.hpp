class CfgSoPop {

	class Units {

		class Infantry {

			class Sentry {
				cost = 2;
				tags[] = {"defense","basic"};
				class Opfor {
					tags[] = {"EAST","arid"};
					randomGrunts = 0;
					leader = "";
					units[] = {
						"O_Soldier_GL_F",
						"O_Soldier_F"
					};
				};
				class OpforT {
					tags[] = {"EAST","tropical"};
					randomGrunts = 0;
					leader = "";
					units[] = {
						"O_T_Soldier_GL_F",
						"O_T_Soldier_F"
					};
				};
				class Blufor {
					tags[] = {"WEST","arid"};
					randomGrunts = 0;
					leader = "";
					units[] = {
						"B_Soldier_GL_F",
						"B_Soldier_F"
					};
				};
				class BluforT {
					tags[] = {"WEST","tropical"};
					randomGrunts = 0;
					leader = "";
					units[] = {
						"B_T_Soldier_GL_F",
						"B_T_Soldier_F"
					};
				};
				class Independent {
					tags[] = {"GUER","AAF"};
					randomGrunts = 0;
					leader = "";
					units[] = {
						"I_Soldier_GL_F",
						"I_Soldier_F"
					};
				};
			};
			//todo
			class FullSquad {
				cost = 6;
				tags[] = {"defense","attack","basic"};
				class Opfor {
					tags[] = {"EAST","arid"};
					randomGrunts = 0;
					leader = "O_Soldier_SL_F";
					units[] = {
						"O_medic_F",
						"O_Soldier_M_F",
						"O_Soldier_TL_F",
						"O_Soldier_A_F",
						"O_Soldier_GL_F",
						"O_Soldier_LAT_F",
						"O_HeavyGunner_F"
					};
				};
				class OpforT {
					tags[] = {"EAST","tropical"};
					randomGrunts = 0;
					leader = "O_T_Soldier_SL_F";
					units[] = {
						"O_T_medic_F",
						"O_T_Soldier_M_F",
						"O_T_Soldier_TL_F",
						"O_T_Soldier_A_F",
						"O_T_Soldier_GL_F",
						"O_T_Soldier_LAT_F",
						"O_T_HeavyGunner_F"
					};
				};
				class Blufor {
					tags[] = {"WEST","arid"};
					randomGrunts = 0;
					leader = "B_Soldier_SL_F";
					units[] = {
						"B_medic_F",
						"B_Soldier_M_F",
						"B_Soldier_TL_F",
						"B_Soldier_A_F",
						"B_Soldier_GL_F",
						"B_Soldier_LAT_F",
						"B_HeavyGunner_F"
					};
				};
				class BluforT {
					tags[] = {"WEST","tropical"};
					randomGrunts = 0;
					leader = "B_T_Soldier_SL_F";
					units[] = {
						"B_T_medic_F",
						"B_T_Soldier_M_F",
						"B_T_Soldier_TL_F",
						"B_T_Soldier_A_F",
						"B_T_Soldier_GL_F",
						"B_T_Soldier_LAT_F",
						"B_T_HeavyGunner_F"
					};
				};
				class Independent {
					tags[] = {"GUER","AAF"};
					randomGrunts = 1;
					leader = "I_Soldier_SL_F";
					units[] = {
						"I_medic_F",
						"I_Soldier_M_F",
						"I_Soldier_TL_F",
						"I_Soldier_A_F",
						"I_Soldier_LAT_F",
						"I_Soldier_GL_F"
					};
				};
			};

			class GruntSquad {
				cost = 6;
				tags[] = {"defense","attack","basic"};
				class Opfor {
					tags[] = {"EAST","arid"};
					randomGrunts = 7;
					leader = "O_Soldier_SL_F";
				};
				class OpforT {
					tags[] = {"EAST","tropical"};
					randomGrunts = 7;
					leader = "O_T_Soldier_SL_F";
				};
				class Blufor {
					tags[] = {"WEST","arid"};
					randomGrunts = 7;
					leader = "B_Soldier_SL_F";
				};
				class BluforT {
					tags[] = {"WEST","tropical"};
					randomGrunts = 7;
					leader = "B_T_Soldier_SL_F";
				};
				class Independent {
					tags[] = {"GUER","AAF"};
					randomGrunts = 7;
					leader = "I_Soldier_SL_F";
				};
			};

			class ATTeam {
				cost = 5;
				tags[] = {"defense","attack","team"};
				class Opfor {
					tags[] = {"EAST","arid"};
					randomGrunts = 0;
					leader = "O_Soldier_TL_F";
					units[] = {
						"O_Soldier_AT_F",
						"O_Soldier_AAT_F", // assist missile specialist
						"O_Soldier_HAT_F"
					};
					//code, give assistant one less titan of each, and one more vorona HEAT
				};
				class OpforT {
					tags[] = {"EAST","tropical"};
					randomGrunts = 0;
					leader = "O_T_Soldier_TL_F";
					units[] = {
						"O_T_Soldier_AT_F",
						"O_T_Soldier_AAT_F", // assist missile specialist
						"O_T_Soldier_HAT_F"
					};
				};
				class Blufor {
					tags[] = {"WEST","arid"};
					randomGrunts = 0;
					leader = "B_Soldier_TL_F";
					units[] = {
						"B_soldier_AT_F",
						"B_soldier_AT_F",
						"B_soldier_AAT_F"	// assist missile specialist
					};
				};
				class BluforT {
					tags[] = {"WEST","tropical"};
					randomGrunts = 1;
					leader = "B_T_Soldier_TL_F";
					units[] = {
						"B_T_soldier_AT_F",
						"B_T_soldier_AT_F",
						"B_T_soldier_AAT_F"	// assist missile specialist
					};
				};
				class Independent {
					tags[] = {"GUER","AAF"};
					randomGrunts = 1;
					leader = "I_Soldier_TL_F";
					units[] = {
						"I_soldier_AT_F",
						"I_soldier_AT_F",
						"I_soldier_AAT_F"	// assist missile specialist
					};
				};
			};

			class OfficerRetinue {
				cost = 4;
				tags[] = {"defense","attack","officer"};
				class Opfor {
					tags[] = {"EAST","arid"};
					randomGrunts = 1;
					leader = "O_officer_F";
					units[] = {
						"O_Soldier_lite_F",
						"O_soldier_M_F"
					};
					code = "fnc_OfficerRetinue";
				};
				class OpforT {
					tags[] = {"EAST","tropical"};
					randomGrunts = 1;
					leader = "O_T_officer_F";
					units[] = {
						"O_T_Soldier_F",
						"O_T_soldier_M_F"
					};
					code = "fnc_OfficerRetinue";
				};
				class Blufor {
					tags[] = {"WEST","arid"};
					randomGrunts = 1;
					leader = "B_officer_F";
					units[] = {
						"B_Soldier_lite_F",
						"B_soldier_M_F"
					};
					code = "fnc_OfficerRetinue";
				};
				class BluforT {
					tags[] = {"WEST","tropical"};
					randomGrunts = 1;
					leader = "B_T_officer_F";
					units[] = {
						"B_T_Soldier_F",
						"B_T_soldier_M_F"
					};
					code = "fnc_OfficerRetinue";
				};
				class Independent {
					tags[] = {"GUER","AAF"};
					randomGrunts = 1;
					leader = "I_officer_F";
					units[] = {
						"I_Soldier_lite_F",
						"I_Soldier_M_F"
					};
					code = "fnc_OfficerRetinue";
				};
			};
		};

		//todo
		class Vehicles {
			class CarUnarmed {
				cost = 5;
				tags[] = {"defense","attack","unarmed","car"};

				class OpforLsvUnarmed {
					tags[] = {"EAST","arid","open"};
					vehicle = "O_LSV_02_unarmed_F";
					randomGrunts = 5;
					gruntTags[] = {"EAST","arid"};
				};
				class OpforLsvUnarmedT {
					tags[] = {"EAST","tropical","open"};
					vehicle = "O_T_LSV_02_unarmed_F";
					randomGrunts = 5;
					gruntTags[] = {"EAST","tropical"};
				};
				class OpforMrapUnarmed {
					tags[] = {"EAST","arid","armored"};
					vehicle = "O_MRAP_02_F";
					randomGrunts = 3;
					gruntTags[] = {"EAST","arid"};
				};
				class OpforMrapUnarmedT {
					tags[] = {"EAST","tropical","armored"};
					vehicle = "O_T_MRAP_02_ghex_F";
					randomGrunts = 3;
					gruntTags[] = {"EAST","tropical"};					
				};

				class BlueforLsvUnarmed {
					tags[] = {"WEST","arid","open"};
					vehicle = "B_LSV_01_unarmed_F";
					randomGrunts = 5;
					gruntTags[] = {"WEST","arid"};
				};
				class BlueforLsvUnarmedT {
					tags[] = {"WEST","tropical","open"};
					vehicle = "B_T_LSV_01_unarmed_F";
					randomGrunts = 5;
					gruntTags[] = {"WEST","tropical"};
				};
				class BlueforMrapUnarmed {
					tags[] = {"WEST","arid","armored"};
					vehicle = "B_MRAP_01_F";
					randomGrunts = 3;
					gruntTags[] = {"WEST","arid"};
				};
				class BlueforMrapUnarmedT {
					tags[] = {"WEST","tropical","armored"};
					vehicle = "B_T_MRAP_01_F";
					randomGrunts = 3;
					gruntTags[] = {"WEST","tropical"};					
				};
				class AAFMrapUnarmed {
					tags[] = {"GUER","arid","armored"};
					vehicle = "I_MRAP_03_F";
					randomGrunts = 3;
					gruntTags[] = {"GUER","AAF"};
				};
			};

			class CarArmed {
				cost = 8;
				tags[] = {"defense","attack","armed","car"};

				class OpforLsvArmed {
					tags[] = {"EAST","arid","machinegun","open"};
					vehicle = "O_LSV_02_armed_F";
					randomGrunts = 2;
					gruntTags[] = {"EAST","arid"};
				};
				class OpforLsvArmedT {
					tags[] = {"EAST","tropical","machinegun","open"};
					vehicle = "O_T_LSV_02_armed_F";
					randomGrunts = 2;
					gruntTags[] = {"EAST","tropical"};					
				};
				class OpforMrapGmg {
					tags[] = {"EAST","arid","grenadelauncher","armored"};
					vehicle = "O_MRAP_02_gmg_F";
					randomGrunts = 1;
					gruntTags[] = {"EAST","arid"};
				};
				class OpforMrapGmgT {
					tags[] = {"EAST","tropical","grenadelauncher","armored"};
					vehicle = "O_T_MRAP_02_gmg_ghex_F";
					randomGrunts = 1;
					gruntTags[] = {"EAST","tropical"};
				};
				class OpforMrapHmg {
					tags[] = {"EAST","arid","machinegun","armored"};
					vehicle = "O_MRAP_02_hmg_F";
					randomGrunts = 1;
					gruntTags[] = {"EAST","arid"};
				};
				class OpforMrapHmgT {
					tags[] = {"EAST","tropical","machinegun","armored"};
					vehicle = "O_T_MRAP_02_hmg_ghex_F";
					randomGrunts = 1;
					gruntTags[] = {"EAST","tropical"};
				};
				class OpforLsvAt {
					tags[] = {"EAST","arid","antitank","open"};
					vehicle = "O_LSV_02_AT_F";
					randomGrunts = 1;
					gruntTags[] = {"EAST","arid"};
				};
				class OpforLsvAtT {
					tags[] = {"EAST","tropical","antitank","open"};
					vehicle = "O_T_LSV_02_AT_F";
					randomGrunts = 1;
					gruntTags[] = {"EAST","tropical"};
				};

				class BluforLsvArmed {
					tags[] = {"WEST","arid","machinegun","open"};
					vehicle = "B_LSV_01_armed_F";
					randomGrunts = 2;
					gruntTags[] = {"WEST","arid"};
				};
				class BluforLsvArmedT {
					tags[] = {"WEST","tropical","machinegun","open"};
					vehicle = "B_T_LSV_01_armed_F";
					randomGrunts = 2;
					gruntTags[] = {"WEST","tropical"};					
				};
				class BluforMrapGmg {
					tags[] = {"WEST","arid","grenadelauncher","armored"};
					vehicle = "B_MRAP_01_gmg_F";
					randomGrunts = 1;
					gruntTags[] = {"WEST","arid"};
				};
				class BluforMrapGmgT {
					tags[] = {"WEST","tropical","grenadelauncher","armored"};
					vehicle = "B_T_MRAP_01_gmg_F";
					randomGrunts = 1;
					gruntTags[] = {"WEST","tropical"};
				};
				class BluforMrapHmg {
					tags[] = {"WEST","arid","machinegun","armored"};
					vehicle = "B_MRAP_01_hmg_F";
					randomGrunts = 1;
					gruntTags[] = {"WEST","arid"};
				};
				class BluforMrapHmgT {
					tags[] = {"WEST","tropical","machinegun","armored"};
					vehicle = "B_T_MRAP_01_hmg_F";
					randomGrunts = 1;
					gruntTags[] = {"WEST","tropical"};
				};
				class BluforLsvAt {
					tags[] = {"WEST","arid","antitank","open"};
					vehicle = "B_LSV_01_AT_F";
					randomGrunts = 1;
					gruntTags[] = {"WEST","arid"};
				};
				class BluforLsvAtT {
					tags[] = {"WEST","tropical","antitank","open"};
					vehicle = "B_T_LSV_01_AT_F";
					randomGrunts = 1;
					gruntTags[] = {"WEST","tropical"};
				};
				class AAFMrapGmg {
					tags[] = {"GUER","AAF","grenadelauncher","armored"};
					vehicle = "I_MRAP_03_gmg_F";
					randomGrunts = 1;
					gruntTags[] = {"GUER","AAF"};
				};
				class AAFMrapHmg {
					tags[] = {"GUER","AAF","machinegun","armored"};
					vehicle = "I_MRAP_03_hmg_F";
					randomGrunts = 1;
					gruntTags[] = {"GUER","AAF"};
				};
			};
		};
	};

	class RandomUnitArrays {
		class InfantryLists {
			Opfor[] = {
				"O_Soldier_F", 7,
				"O_Soldier_GL_F", 4,
				"O_Soldier_AR_F", 4,
				"O_medic_F", 4,
				"O_Soldier_A_F", 3, //ammobearer
				"O_HeavyGunner_F", 3,
				"O_soldier_M_F", 2, //marksman
				"O_Soldier_lite_F", 3,
				"O_Soldier_TL_F", 3,
				"O_engineer_F", 1,
				"O_Soldier_AA_F", 1,
				"O_Soldier_LAT_F", 4, // rpg
				"O_Soldier_HAT_F", 3,	// metis
				"O_Soldier_AT_F", 2	// atgm
			};
			OpforT[] = {
				"O_T_Soldier_F", 7,
				"O_T_Soldier_GL_F", 4,
				"O_T_Soldier_AR_F", 4,
				"O_T_medic_F", 4,
				"O_T_Soldier_A_F", 3, //ammobearer
				"O_T_HeavyGunner_F", 3,
				"O_T_soldier_M_F", 2, //marksman
				//"O_T_Soldier_lite_F", 3, // doesn't exist for tropics
				"O_T_Soldier_TL_F", 3,
				"O_T_engineer_F", 1,
				"O_T_Soldier_AA_F", 1,
				"O_T_Soldier_LAT_F", 4, // rpg
				"O_T_Soldier_HAT_F", 3,	// metis
				"O_T_Soldier_AT_F", 2	// atgm
			};
			Blufor[] = {
				"B_Soldier_F", 6,
				"B_Soldier_GL_F", 4,
				"B_Soldier_AR_F", 4,
				"B_medic_F", 4,
				"B_Soldier_A_F", 3, //ammobearer
				"B_HeavyGunner_F", 3,
				"B_soldier_M_F", 2, //marksman
				"B_Soldier_lite_F", 3,
				"B_Soldier_TL_F", 3,
				"B_engineer_F", 1,
				"B_Soldier_AA_F", 1,
				"B_Soldier_LAT_F", 4, // nlaw
				"B_Soldier_LAT2_F", 4,	// maaws
				"B_Soldier_AT_F", 2		// atgm
			};
			BluforT[] = {
				"B_T_Soldier_F", 6,
				"B_T_Soldier_GL_F", 4,
				"B_T_Soldier_AR_F", 4,
				"B_T_medic_F", 4,
				"B_T_Soldier_A_F", 3, //ammobearer
				"B_T_HeavyGunner_F", 3,
				"B_T_soldier_M_F", 2, //marksman
				"B_T_Soldier_lite_F", 3,
				"B_T_Soldier_TL_F", 3,
				"B_T_engineer_F", 1,
				"B_T_Soldier_AA_F", 1,
				"B_T_Soldier_LAT_F", 4, // nlaw
				"B_T_Soldier_LAT2_F", 4,	// maaws
				"B_T_Soldier_AT_F", 2		// atgm
			};
			Independent[] = {
				"I_soldier_F", 7,
				"I_Soldier_GL_F", 4,
				"I_Soldier_AR_F", 4,
				"I_medic_F", 4,
				"I_Soldier_A_F", 3, //ammobearer
				"I_Soldier_M_F", 2, //marksman
				"I_Soldier_lite_F", 3,
				"I_Soldier_TL_F", 3,
				"I_engineer_F", 1,
				"I_Soldier_AA_F", 1,
				"I_Soldier_LAT_F", 4, // nlaw
				"I_Soldier_LAT2_F", 4,	// maaws
				"I_Soldier_AT_F", 2		// atgm
			};
		};

		class Grunts {
			class Opfor {
				tags[] = {"EAST","arid"};
				weightArray[] = {
					"O_Soldier_F", 8,
					"O_Soldier_GL_F", 3,
					"O_Soldier_AR_F", 1,
					"O_Soldier_LAT_F", 1,
					"O_Soldier_lite_F", 2
				};
			};
			class OpforT {
				tags[] = {"EAST","tropical"};
				weightArray[] = {
					"O_T_Soldier_F", 8,
					"O_T_Soldier_GL_F", 3,
					"O_T_Soldier_AR_F", 1,
					"O_T_Soldier_LAT_F", 1,
					"O_T_Soldier_F", 2
				};
			};
			class Blufor {
				tags[] = {"WEST","arid"};
				weightArray[] = {
					"B_Soldier_F", 8,
					"B_Soldier_GL_F", 3,
					"B_Soldier_AR_F", 1,
					"B_Soldier_LAT2_F", 1,
					"B_Soldier_lite_F", 2
				};
			};
			class BluforT {
				tags[] = {"WEST","tropical"};
				weightArray[] = {
					"B_T_Soldier_F", 8,
					"B_T_Soldier_GL_F", 3,
					"B_T_Soldier_AR_F", 1,
					"B_T_Soldier_LAT2_F", 1,
					"B_T_Soldier_lite_F", 2
				};
			};
			class Independent {
				tags[] = {"GUER","AAF"};
				weightArray[] = {
					"I_Soldier_F", 8,
					"I_Soldier_GL_F", 3,
					"I_Soldier_AR_F", 1,
					"I_Soldier_LAT2_F", 1,
					"I_Soldier_lite_F", 2
				};
			};

		};
	};
};