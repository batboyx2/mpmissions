// ========================================================
// BLUFOR  Loadout Handling
switch (bsmrk_param_bluforFactionP) do {
	1: {#include "bsmrk_ADscripts\customFactions\BLUFOR\NATO\bluefor_standard.hpp"};
	2: {#include "bsmrk_ADscripts\customFactions\BLUFOR\CTRG\bluefor_standard.hpp"};
	3: {#include "bsmrk_ADscripts\customFactions\BLUFOR\FIA\bluefor_standard.hpp"};
	4: {#include "bsmrk_ADscripts\customFactions\BLUFOR\CDF\bluefor_standard.hpp"};
	5: {#include "bsmrk_ADscripts\customFactions\BLUFOR\USA (Army 2014)\UCP\bluefor_standard.hpp"};
	6: {#include "bsmrk_ADscripts\customFactions\BLUFOR\USA (Army 2014)\OCP\bluefor_standard.hpp"};
	7: {#include "bsmrk_ADscripts\customFactions\BLUFOR\USA (USMC 2014)\Desert\bluefor_standard.hpp"};
	8: {#include "bsmrk_ADscripts\customFactions\BLUFOR\USA (USMC 2014)\Woodland\bluefor_standard.hpp"};
};

// ========================================================
// OPFOR  Loadout Handling
switch (bsmrk_param_opforFactionP) do {
	1: {#include "bsmrk_ADscripts\customFactions\OPFOR\CSAT\opfor_standard.hpp"};
	2: {#include "bsmrk_ADscripts\customFactions\OPFOR\Russia (VDV)\EMR\opfor_standard.hpp"};
	3: {#include "bsmrk_ADscripts\customFactions\OPFOR\Russia (VDV)\Flora\opfor_standard.hpp"};
	4: {#include "bsmrk_ADscripts\customFactions\OPFOR\Russia (VDV)\Mountain Flora\opfor_standard.hpp"};
	5: {#include "bsmrk_ADscripts\customFactions\OPFOR\SLA\opfor_standard.hpp"};
};

// ========================================================
// INDFOR  Loadout Handling
switch (bsmrk_param_indFactionP) do {
	1: {#include "bsmrk_ADscripts\customFactions\INDEPENDENT\AAF\indfor_standard.hpp"};
	2: {#include "bsmrk_ADscripts\customFactions\INDEPENDENT\Afghan Militia\indfor_standard.hpp"};
	3: {#include "bsmrk_ADscripts\customFactions\INDEPENDENT\African Militia\indfor_standard.hpp"};
	4: {#include "bsmrk_ADscripts\customFactions\INDEPENDENT\Contractors\indfor_standard.hpp"};
	5: {#include "bsmrk_ADscripts\customFactions\INDEPENDENT\Insurgents\indfor_standard.hpp"};
	6: {#include "bsmrk_ADscripts\customFactions\INDEPENDENT\People's Liberation Army (Modern)\indfor_standard.hpp"};
};