class CfgSoPop {

	class Units {

		class InfantrySquads {

			class Sentry {
				cost = 2;
				tags[] = {"defense"};
				class Opfor {
					tags[] = {"east","arid"};
					randomGruntAmount = 0;
					units[] = {
						"O_Soldier_GL_F",
						"O_Soldier_F"
					};
				};
				class OpforT {
					tags[] = {"east","tropical"};
					randomGruntAmount = 0;
					units[] = {
						"O_T_Soldier_GL_F",
						"O_T_Soldier_F"
					};
				};
				class Blufor {
					tags[] = {"west","arid"};
					randomGruntAmount = 0;
					units[] = {
						"B_Soldier_GL_F",
						"B_Soldier_F"
					};
				};
				class BluforT {
					tags[] = {"west","tropical"};
					randomGruntAmount = 0;
					units[] = {
						"B_T_Soldier_GL_F",
						"B_T_Soldier_F"
					};
				};
				class Independent {
					tags[] = {"independent","AAF"};
					randomGruntAmount = 0;
					units[] = {
						"I_Soldier_GL_F",
						"I_Soldier_F"
					};
				};
			};

			class FullSquad {
				cost = 6;
				tags[] = {"defense","attack"};
				class Opfor {
					tags[] = {"east","arid"};
					randomGruntAmount = 6;
					units[] = {
						"O_Soldier_SL_F"
					};
				};
				class OpforT {
					tags[] = {"east","tropical"};
					randomGruntAmount = 6;
					units[] = {
						"O_T_Soldier_SL_F"
					};
				};
				class Blufor {
					tags[] = {"west","arid"};
					randomGruntAmount = 6;
					units[] = {
						"B_Soldier_SL_F"
					};
				};
				class BluforT {
					tags[] = {"west","tropical"};
					randomGruntAmount = 6;
					units[] = {
						"B_T_Soldier_SL_F"
					};
				};
				class Independent {
					tags[] = {"independent","AAF"};
					randomGruntAmount = 6;
					units[] = {
						"I_Soldier_SL_F"
					};
				};
			};
		};

		class Vehicles {
			class MRAP {
				desc = "empty";
			};
		};
	};

	class RandomUnitArrays {
		class Infantry {
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
				"O_T_Soldier_lite_F", 3,
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
				tags[] = {"east","arid"};
				weightArray[] = {
					"O_Soldier_F", 7,
					"O_Soldier_GL_F", 2,
					"O_Soldier_AR_F", 1,
					"O_Soldier_lite_F", 2
				};
			};

			class OpforT {
				tags[] = {"east","tropical"};
				weightArray[] = {
					"O_T_Soldier_F", 7,
					"O_T_Soldier_GL_F", 2,
					"O_T_Soldier_AR_F", 1,
					"O_T_Soldier_lite_F", 2
				};
			};
			class Blufor {
				tags[] = {"west","arid"};
				weightArray[] = {
					"B_Soldier_F", 7,
					"B_Soldier_GL_F", 2,
					"B_Soldier_AR_F", 1,
					"B_Soldier_lite_F", 2
				};
			};
			class BluforT {
				tags[] = {"west","tropical"};
				weightArray[] = {
					"B_T_Soldier_F", 7,
					"B_T_Soldier_GL_F", 2,
					"B_T_Soldier_AR_F", 1,
					"B_T_Soldier_lite_F", 2
				};
			};
			class Independent {
				tags[] = {"independent","AAF"};
				weightArray[] = {
					"I_Soldier_F", 7,
					"I_Soldier_GL_F", 2,
					"I_Soldier_AR_F", 1,
					"I_Soldier_lite_F", 2
				};
			};

		};
	};
};