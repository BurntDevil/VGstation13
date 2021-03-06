/datum/command_alert
	var/name //Descriptive name - it's not shown to anybody, so feel free to make it OOC

	var/alert_title = "Central Command"
	var/message

	var/force_report = 0
	var/alert = 'sound/AI/commandreport.ogg'//sound
	var/noalert = 0
	var/small = 0

	//Malf fake announcement variables. Thematic music is handled in faction code, so this doesn't serve much of a point outside of announcement faking.
	var/theme = "" //Whatever theme is associated with this announcement
	var/stoptheme = 0 //Stop the theme
	var/alertlevel = ""	//set the alert level to this

/datum/command_alert/proc/announce()
	command_alert(message, alert_title, force_report, alert, noalert, small)

//////BIOHAZARD

/datum/command_alert/biohazard_alert
	name = "Biohazard Alert"
	alert_title = "Biohazard Alert"
	noalert = 1
	force_report = 1

	var/level = 1
	var/level_max = 7
	var/level_min = 4

/datum/command_alert/biohazard_alert/announce()
	level = rand(level_min,level_max)
	message = "Confirmed outbreak of level [level] biohazard aboard [station_name()]. All personnel must contain the outbreak."

	..()

	var/list/vox_sentence=list(
	'sound/AI/outbreak_before.ogg',
	outbreak_level_words[level],
	'sound/AI/outbreak_after.ogg',
	)

	for(var/word in vox_sentence)
		play_vox_sound(word,STATION_Z,null)

/datum/command_alert/biohazard_alert/minor
	level_max = 4
	level_min = 2

/datum/command_alert/biohazard_alert/major
	level_max = 7
	level_min = 5


///////BIOHAZARD UPDATED

/datum/command_alert/biohazard_station_lockdown
	name = "Biohazard Level Updated - Station Locked Down"
	alert_title = "Directive 7-10 Initiated"
	alert = 'sound/AI/blob_confirmed.ogg'
	force_report = 1

/datum/command_alert/biohazard_station_lockdown/announce()
	message = "Biohazard outbreak alert status upgraded to level 9.  [station_name()] is now locked down, under Directive 7-10, until further notice."

	..()

/datum/command_alert/biohazard_station_nuke
	name = "Biohazard Level Updated - Nuclear Force Authorized"
	alert_title = "Final Measure"
	noalert = 1
	theme = "endgame"

/datum/command_alert/biohazard_station_nuke/announce()
	message = "Biohazard outbreak containment status reaching critical mass, total quarantine failure is now possibile. As such, Directive 7-12 has now been authorized for [station_name()]."

	..()

/datum/command_alert/biohazard_station_unlock
	name = "Biohazard Level Updated - Lock Down Lifted"
	alert_title = "Directive 7-10 to 7-12 Concluded."
	force_report = 1
	stoptheme = 1

/datum/command_alert/biohazard_station_unlock/announce()
	message = "Biohazard outbreak contained successfully. Quarantine lifted. Please clean up biohazardous material and proceed with standard station duties."
	..()

/datum/command_alert/emergency_shuttle_called
	name = "Emergency Shuttle Called"
	alert_title = "Priority Announcement"
	force_report = 1
	alert = 'sound/AI/shuttlecalled.ogg'
	var/justification = ""

/datum/command_alert/emergency_shuttle_called/announce()
	message = "The emergency shuttle has been called. It will arrive in [round(emergency_shuttle.timeleft()/60)] minutes."
	if(justification)
		message += " Justification: [justification]"
	..()

/datum/command_alert/emergency_shuttle_recalled
	name = "Emergency Shuttle Recalled"
	alert_title = "Priority Announcement"
	force_report = 1
	alert = 'sound/AI/shuttlerecalled.ogg'

/datum/command_alert/emergency_shuttle_recalled/announce()
	message = "The emergency shuttle has been recalled."
	..()

/datum/command_alert/emergency_shuttle_docked
	name = "Emergency Shuttle Docked"
	alert_title = "Priority Announcement"
	force_report = 1
	alert = 'sound/AI/shuttledock.ogg'

/datum/command_alert/emergency_shuttle_docked/announce()
	message = "The Emergency Shuttle has docked with the station. You have [round(emergency_shuttle.timeleft()/60,1)] minutes to board the Emergency Shuttle."
	..()

/datum/command_alert/emergency_shuttle_left
	name = "Emergency Shuttle Departed"
	alert_title = "Priority Announcement"
	force_report = 1

/datum/command_alert/emergency_shuttle_left/announce()
	message = "The Emergency Shuttle has left the station. Estimate [round(emergency_shuttle.timeleft()/60,1)] minutes until the shuttle docks at Central Command."
	..()


/datum/command_alert/FUBAR
	name = "Complimentary escape shuttle sent."
	alert_title = "Evacuation of remaining assets."
	force_report = 1

/datum/command_alert/FUBAR/announce()
	message = "Due to intense sustained damage to the station, Nanotrasen have deemed it fitting to evacuate remaining assets and personnel through an escape shuttle that was previously already en route."
	..()

////////BLOB (mini)

/datum/command_alert/biohazard_level_5
	name = "Biohazard Alert (level 5)"
	alert_title = "Biohazard Alert"
	alert = 'sound/AI/outbreak5.ogg'
	force_report = 1

/datum/command_alert/biohazard_level_5/announce()
	message = "Confirmed outbreak of level 5 biohazard aboard [station_name()]. All personnel must contain the outbreak."

	..()

/// REVS

/datum/command_alert/revolution
	name = "Revolution"
	alert_title = "Subversive Elements"
	force_report = 1
	message = "Subversive Union-aligned elements have been detected aboard the station. According to latest reports, targeted removal of heads of staff is already underway. Loyal crew should take immediate action to secure station against revolutionaries."
	theme = "nukesquad"
	alertlevel = "red"

/datum/command_alert/revolutiontoppled
	name = "Revolution Defeated"
	alert_title = "Order Restored"
	force_report = 1
	message = "Based on long-range psychic scans, we have determined that revolutionary activity aboard the station has been contained. An evacuation shuttle has been dispatched to recover crew for further loyalty screening at Central Command."
	stoptheme = 1
	alertlevel = "blue"


/// MALF


/datum/command_alert/malf_destroyed
	name = "AI Malfunctioning Controlled"
	alert_title = "Rogue intelligence contained/destroyed successfully."
	force_report = 1
	message = "Rogue artificial intelligence contained successfully. Lockdown lifted. Please contain and destroy/restore any remaining rogue AI-controlled material, and proceed with standard station duties."
	stoptheme = 1
	alertlevel = "blue"

//Jungle Fever

/datum/command_alert/jungle_fever
	name = "Jungle Fever"
	alert_title = "Jungle Fever Outbreak"
	force_report = 1
	message = "Early symptoms of a Jungle Fever outbreak have been detected aboard your station. SHOOT MONKEYS ON SIGHT. Weld ducting and ventilation. Avoid contact with disease carriers at any personal cost. Command staff should secure nuclear authentication disk and nuclear fission explosive."
	theme = "endgame"

/datum/command_alert/jungle_endgame
	name = "Jungle Fever Outbreak Escalated"
	alert_title = "Jungle Fever Outbreak Escalated"
	force_report = 1
	message = "ERROR"
	theme = "endgame"

/datum/command_alert/jungle_endgame/announce()
	var/nukecode = "ERROR"
	for(var/obj/machinery/nuclearbomb/bomb in machines)
		if(bomb && bomb.r_code && bomb.z == STATION_Z)
			nukecode = bomb.r_code
	message = "Central Command has deemed the situation beyond salvageable, and is releasing the nuclear fission explosive authorization code. Your authorization key is [nukecode]. Send them to Ape Hell."
	..()

/datum/command_alert/jungle_purified
	name = "Jungle Fever Crew Win"
	alert_title = "Jungle Fever Contained"
	force_report = 1
	message = "We have received confirmation that, as of this time, the Jungle Fever outbreak has been contained. Incinerate all simian corpses and salvage equipment for evacuation."
	stoptheme = 1

/////////ERT

/datum/command_alert/ert_fail
	name = "ERT - Unable To Send"

/datum/command_alert/ert_fail/announce()
	message = "It would appear that an emergency response team was requested for [station_name()]. Unfortunately, we were unable to send one at this time."

	..()

/datum/command_alert/ert_success
	name = "ERT - Team Sent"

/datum/command_alert/ert_success/announce()
	message = "It would appear that an emergency response team was requested for [station_name()]. We will prepare and send one as soon as possible."

	..()

////////AYY

/datum/command_alert/xenomorphs
	name = "Unidentified Lifesigns Alert"
	alert_title = "Lifesign Alert"
	alert = 'sound/AI/aliens.ogg'

/datum/command_alert/xenomorphs/announce()
	message = "Unidentified lifesigns detected coming aboard [station_name()]. Secure any exterior access, including ducting and ventilation."

	..()

///////RADIATION

/datum/command_alert/radiation_storm
	name = "Radiation Storm - Warning"
	alert_title = "Anomaly Alert"
	alert = 'sound/AI/radiation.ogg'
	message = "High levels of radiation detected near the station, ETA in 30 seconds. Please evacuate into one of the shielded maintenance tunnels."

/datum/command_alert/radiation_storm/start
	name = "Radiation Storm - Start"
	alert = null
	message = "The station has entered the radiation belt. Please remain in a sheltered area until we have passed the radiation belt."

/datum/command_alert/radiation_storm/end
	name = "Radiation Storm - End"
	alert = null
	message = "The station has passed the radiation belt. Please report to medbay if you experience any unusual symptoms. Maintenance will lose all access again shortly."

/datum/command_alert/radiation
	name = "High Levels Of Radiation"
	alert_title = "Anomaly Alert"
	alert = 'sound/AI/radiation.ogg'

	message = "High levels of radiation detected near the station. Please report to the Med-bay if you feel strange."


///////GRAYTIDE VIRUS

/datum/command_alert/graytide
	name = "Gr3y.T1d3 virus"
	alert_title = "Security Alert"

/datum/command_alert/graytide/announce()
	message = "[pick("Gr3y.T1d3 virus","Malignant trojan")] detected in [station_name()] imprisonment subroutines. Recommend station AI involvement."

	..()

//////CARP

/datum/command_alert/carp
	name = "Carp Migration"
	alert_title = "Lifesign Alert"

/datum/command_alert/carp/announce()
	message = "Unknown biological entities have been detected near [station_name()], please stand-by."

	..()

////////ELECTRICAL STORM

/datum/command_alert/electrical_storm
	name = "Electrical Storm"
	alert_title = "Electrical Storm Alert"
	message = "An Electrical storm has been detected in your area, please repair potential electronic overloads."

///////SUMMARY DOWNLOADED AND PRINTED AT COMMS

/datum/command_alert/enemy_comms_interception
	name = "Enemy Communications Intercepted"
	alert_title = "Enemy communications intercept"
	message = "Summary downloaded and printed out at all communications consoles."

//////////SUPERMATTER CASCADE

/datum/command_alert/supermatter_cascade
	name = "Supermatter Cascade Start"
	alert_title = "SUPERMATTER CASCADE DETECTED"
	theme = "endgame"

/datum/command_alert/supermatter_cascade/announce()
	message = {"
There's been a galaxy-wide electromagnetic pulse.  All of our systems are heavily damaged and many personnel are dead or dying. We are seeing increasing indications of the universe itself beginning to unravel.

[station_name()], you are the only facility nearby a bluespace rift, which is near the [get_area_name(global_cascade_portal, 1)].  You are hereby directed to enter the rift using all means necessary, quite possibly as the last humans alive.

You have five minutes before the universe collapses. Good l\[\[###!!!-

AUTOMATED ALERT: Link to [command_name()] lost.

The access requirements on the Asteroid Shuttles' consoles have now been revoked.
"}

	..()

/////////////POWER OUTAGE

/datum/command_alert/power_outage
	name = "Power Outage - Start"
	alert_title = "Critical Power Failure"
	alert ='sound/AI/poweroff.ogg'

/datum/command_alert/power_outage/announce()
	message = "Abnormal activity detected in [station_name()]'s powernet. As a precautionary measure, the station's power will be shut off for an indeterminate duration."

	..()

/datum/command_alert/smes_charged
	name = "SMES Recharged"
	alert_title = "Power Systems Nominal"
	alert = 'sound/AI/poweron.ogg'

/datum/command_alert/smes_charged/announce()
	message = "All SMESs on [station_name()] have been recharged. We apologize for the inconvenience."

	..()

////////////////WORMHOLES

/datum/command_alert/wormholes
	name = "Space-Time Anomalities Detected"
	alert_title = "Anomaly Alert"
	alert = 'sound/AI/spanomalies.ogg'
	message = "Space-time anomalies detected on the station. There is no additional data."

//////////////MALF ANNOUNCEMENT

/datum/command_alert/malf_announce
	name = "AI Malfunctioning Warning"
	alert_title = "Anomaly Alert"
	alert = 'sound/AI/aimalf.ogg'
	message = "Hostile runtimes detected in all station systems, please deactivate your AI to prevent possible damage to its morality core."
	theme = "malfdelta"
	alertlevel = "delta"

/////////////METEOR STORM

/datum/command_alert/meteor_round
	name = "Major Meteor Storm Warning"
	alert_title = "Space Weather Automated Announcements"
	alert = 'sound/AI/meteorround.ogg'
	theme = "endgame"

	var/meteor_delay = 2000
	var/supply_delay = 100


/datum/command_alert/meteor_round/announce()
	meteor_delay = rand(4500, 6000)
	if(prob(70)) //slightly off-scale
		message = "A meteor storm has been detected in proximity of [station_name()] and is expected to strike within [round((rand(meteor_delay - 600, meteor_delay + 600))/600)] minutes. A backup emergency shuttle is being dispatched and emergency gear should be teleported into your station's Bar area in [supply_delay/10] seconds."
	else
		message = "A meteor storm has been detected in proximity of [station_name()] and is expected to strike within [round((rand(meteor_delay - 1800, meteor_delay + 1800))/600)] minutes. A backup emergency shuttle is being dispatched and emergency gear should be teleported into your station's Bar area in [supply_delay/10] seconds."
	..()

////small meteor storm

/datum/command_alert/meteor_wave
	name = "Meteor Storm Warning"
	alert_title = "Meteor Alert"
	alert = 'sound/AI/meteors.ogg'
	message = "A meteor storm has been detected on collision course with the station. Seek shelter within the core of the station immediately."


/////meteor storm end
/datum/command_alert/meteor_wave_end
	name = "Meteor Storm Cleared"
	alert_title = "Meteor Alert"
	message = "The station has cleared the meteor storm."

/datum/command_alert/meteor_storm
	name = "Small-Intensity Meteor Storm Warning"
	alert_title = "Meteor Alert"
	message = "The station is about to be hit by a small-intensity meteor storm. Seek shelter within the core of the station immediately."

//////blob storm
/datum/command_alert/blob_storm
	name = "Meteor Blob Cluster - No Overminds"
	alert_title = "Blob Cluster"
	message = "The station is about to pass through a Blob cluster. No overmind brainwaves detected."

/datum/command_alert/blob_storm/end
	name = "Meteor Blob Cluster Ended (No Overminds)"
	message = "The station has cleared the Blob cluster. Eradicate the blob from hit areas."

/datum/command_alert/blob_storm/overminds
	name = "Meteor Blob Cluster - Overminds!"
	alert_title = "Blob Conglomerate"
	message = "The station is about to pass through a Blob conglomerate. Overmind brainwaves possibly detected."

/datum/command_alert/blob_storm/overminds/end
	name = "Meteor Blob Cluster Ended (Overminds!)"
	message = "The station has passed through a Blob conglomerate. Investigate the hit areas at once and clear the blob. Beware for possible Overmind presence."

/////////////GRAVITY

/datum/command_alert/gravity_enabled
	name = "Gravity - Enabled"
	message = "Gravity generators are again functioning within normal parameters. Sorry for any inconvenience."

/datum/command_alert/gravity_disabled
	name = "Gravity - Disabled"
	message = "Feedback surge detected in mass-distributions systems. Artifical gravity has been disabled whilst the system reinitializes. Further failures may result in a gravitational collapse and formation of blackholes. Have a nice day."

//////////////////////////////ION STORM

/datum/command_alert/ion_storm
	name = "Ion Storm - AI affected"
	alert_title = "Anomaly Alert"
	alert = 'sound/AI/ionstorm.ogg'
	message = "Ion storm detected near the station. Please check all AI-controlled equipment for errors."

/datum/command_alert/ion_storm_malicious
	name = "Ion Storm - AI affected"
	alert_title = "Anomaly Alert"
	alert = 'sound/AI/ionstorm.ogg'
	message = "Abnormal ion activity detected. Please check all AI-controlled equipment for errors. Additional data has been downloaded and printed out at all communications consoles."

/datum/command_alert/ion_storm_large
	name = "Ion Storm - All Affected"
	alert_title = "Anomaly Alert"
	message = "It has come to our attention that the station passed through an ion storm.  Please monitor all electronic equipment for malfunctions."

///////////BLUESPACE ANOMALY

/datum/command_alert/bluespace_anomaly
	name = "Bluespace Anomaly"
	alert_title = "Anomaly Alert"

/datum/command_alert/bluespace_anomaly/New(impact_area_name)
	message = "Bluespace anomaly detected in the vicinity of [station_name()]. [impact_area_name || "An unknown area"] has been affected."
	..()

//////////POWER DISABLED

/datum/command_alert/power_disabled
	name = "Station Power - Disabled"
	alert_title = "Automated Grid Check"
	alert = 'sound/AI/poweroff.ogg'

/datum/command_alert/power_disabled/announce()
	message = "Abnormal activity detected in [station_name()]'s powernet. As a precautionary measure, the station's power will be shut off for an indeterminate duration."
	..()

/datum/command_alert/power_restored
	name = "Station Power - Restored"
	alert_title = "Power Nominal"
	alert = 'sound/AI/poweron.ogg'

/datum/command_alert/power_restored/announce()
	message = "Power has been restored to [station_name()]. We apologize for the inconvenience."
	..()

//////////////CENTCOM LINK

/datum/command_alert/command_link_lost
	name = "Centcom Link Lost"
	alert_title = "Automated Announcement"
	alert = 'sound/AI/connection_lost.ogg'
	message = "Critical alert: Bluespace connection to Central Command has been lost. The emergency shuttle is be unable to be called or recalled until further notice."

/datum/command_alert/command_link_restored
	name = "Centcom Link Restored"
	alert_title = "Automated Announcement"
	alert = 'sound/AI/connection_made.ogg'
	alert_title = "Link with Central Command has been re-established successfully. The emergency shuttle can now be called or recalled."

/////////HOSTILE CREATURES

/datum/command_alert/hostile_creatures
	name = "Hostile Creatures Alert"
	alert_title = "WARNING: Hostile Creature(s)"

/datum/command_alert/hostile_creatures/New(localestring = "an unknown location", monsterstring = "malicious intent")
	..()

	message = "One or more hostile creatures have entered the station in [localestring]. External security cameras indicate that the creature has [monsterstring]."

/datum/command_alert/vermin
	name = "Vermin Alert"
	alert_title = "Vermin infestation"

/datum/command_alert/vermin/New(vermstring = "various vermin", locstring = "the station's maintenance tunnels", warning = "Clear them out, before this starts to affect productivity.")
	..()

	message = "Bioscans indicate that [vermstring] have been breeding in [locstring]. [warning]"

/datum/command_alert/mob_swarm
	name = "Mob Swarm"

/datum/command_alert/mob_swarm/New(mob_name = "animals")
	..()

	message = "Due to timespace anomalies of unknown origin, [station_name] is now host to several [mob_name]\s more than there were a moment ago."


//////////////BLOOD CULT

/datum/command_alert/cult_detected
	name = "Occult Activity Detected - Please Investigate"
	alert_title = "Occult Activity"
	force_report = 1

/datum/command_alert/cult_detected/announce()
	message = "Irregularities in the fabric of space-time around [station_name()] appear to correlate with the propagation of occult activities. Remember that cult membership is strictly prohibited by Nanotrasen and exposes you to the death penalty, applicable immediately if evidence is made. We encourage the station's security department to investigate, and the rest of the crew to cooperate with them."
	..()

/datum/command_alert/bloodstones_raised
	name = "Occult Activity Detected - Station Locked Down"
	alert_title = "Occult Assault"
	force_report = 1
	theme = "endgame"
	alertlevel = "red"

/datum/command_alert/bloodstones_raised/announce()
	message = "Occult energies detected emanating from [station_name()]. Readings suggest an assault from the Cult of Nar-Sie. The station is now locked down under Directive 7-10, until destruction of all the bloodstones has been confirmed. Regroup with your station's security forces and approach the stones with caution, follow your superiors' directions."
	..()

/datum/command_alert/bloodstones_anchor
	name = "Occult Activity Critical - Breach of Space-Time Detected"
	alert_title = "Occult Assault Critical"
	force_report = 1
	theme = "endgame"
	alertlevel = "red"

/datum/command_alert/bloodstones_anchor/announce()
	message = "Occult energies from [station_name()] are reaching a critical point. A breach through space has materialized on one of the bloodstones. It appears to be in [get_area_name(global_anchor_bloodstone, 1)]. Destroy it at all costs, do not let any cultist near it."
	..()

/datum/command_alert/bloodstones_broken
	name = "Occult Activity Ceased - Lock Down Lifted"
	alert_title = "Occult Gone"
	force_report = 1
	stoptheme = 1
	alertlevel = "blue"

/datum/command_alert/bloodstones_broken/announce()
	message = "Destruction of the bloodstones confirmed. The Cult is no longer an immediate threat to Nanotrasen. Lock down of the station has been revoked."
	..()

////////MISC STUFF

/datum/command_alert/eagles
	name = "Airlock Access Removed"
	message = "Centcomm airlock control override activated. Please take this time to get acquainted with your coworkers."

/datum/command_alert/bluespace_artillery
	name = "Bluespace Artillery Strike Detected"
	message = "Bluespace artillery fire detected. Brace for impact."

/datum/command_alert/vending_machines
	name = "Rampant Brand Intelligence Detected"
	alert_title = "Machine Learning Alert"

/datum/command_alert/vending_machines/announce()
	message = "Rampant brand intelligence has been detected aboard [station_name()], please stand-by."

/datum/command_alert/comms_blackout
	name = "Ionospheric Anomalies - Telecommunications Failure"
	message = "Ionospheric anomalies detected. Temporary telecommunication failure imminent. Please contact you-BZZT"

/datum/command_alert/comms_blackout/announce()
	message = pick(	"Ionospheric anomalies detected. Temporary telecommunication failure imminent. Please contact you*%fj00)`5vc-BZZT", \
						"Ionospheric anomalies detected. Temporary telecommunication failu*3mga;b4;'1v¬-BZZZT", \
						"Ionospheric anomalies detected. Temporary telec#MCi46:5.;@63-BZZZZT", \
						"Ionospheric anomalies dete'fZ\\kg5_0-BZZZZZT", \
						"Ionospheri:%£ MCayj^j<.3-BZZZZZZT", \
						"#4nd%;f4y6,>£%-BZZZZZZZT")
	..()

/datum/command_alert/electrical_storm
	name = "Electrical Storm Alert"
	alert_title = "Electrical Storm Alert"
	message = "An electrical storm has been detected in your area, please repair potential electronic overloads."

/datum/command_alert/immovable_rod
	name = "Immovable Rod (\"What The Fuck Was That?\")"
	alert_title = "Local Bluespace Sensor Report"
	message = "Alert: The station appears to be on a collision course with an anomalous object perfectly suspended in space. Heavy structural damage may result."

/datum/command_alert/rogue_drone
	name = "Rogue Drones - Alert"
	alert_title = "Rogue Drone Alert"

/datum/command_alert/rogue_drone/announce()
	if(prob(33))
		message = "A combat drone wing operating out of the NMV Icarus has failed to return from a sweep of this sector, if any are sighted approach with caution."
	else if(prob(50))
		message = "Contact has been lost with a combat drone wing operating out of the NMV Icarus. If any are sighted in the area, approach with caution."
	else
		message = "Unidentified hackers have targeted a combat drone wing deployed from the NMV Icarus. If any are sighted in the area, approach with caution."

	..()

/datum/command_alert/drones_recovered
	name = "Rogue Drones - Recovered Successfully"
	alert_title = "Rogue Drone Alert"
	message = "Icarus drone control reports the malfunctioning wing has been recovered safely."

/datum/command_alert/drones_recovered/failure
	name = "Rogue Drones - Failed To Recover"
	message = "Icarus drone control registers disappointment at the loss of the drones, but the survivors have been recovered."

/datum/command_alert/wall_fungi
	name = "Wall Fungi"
	alert_title = "Biohazard Alert"
	message = "Harmful fungi detected on station. Station structures may be contaminated."

/datum/command_alert/nuclear_operatives
	name = "Nuclear Operatives"
	alert_title = "Imminent Assault"
	theme = "nukesquad"
	alertlevel = "red"

/datum/command_alert/nuclear_operatives/announce()
	message = "Presence of hostile Syndicate operatives has been confirmed in the vicinity of [station_name()]. Command staff is advised to monitor the status of all high-value assets, and security staff should co-operate with all crew members in securing the station from infiltration."
	..()

/datum/command_alert/blizzard_end
	alert_title = "Blizzard Status"
	message = "Automated meteorological warning alert: the blizzard has been confirmed to be no longer active. Thank you for your cooperation with standard safety procedures."

/datum/command_alert/blizzard_start
	alert_title = "Automated Meteorological Update - Unforecasted Blizzard"
	message = "ROKER-class storm early warning systems have detected unforecasted, sudden-onset snowstorm approaching in the next two to four minutes. Crew members are encouraged to follow standard safety procedures and wear protective snow gear at all times."

/datum/command_alert/blizzard_extended
	alert_title = "Automated Meteorological Update - Inaccurate Forecast"
	message = "ROKER-class storm analysis systems have detected an incongruity in blizzard forecasting. The current blizzard's estimated active period has been re-evaluated and extended."

/datum/command_alert/omega_blizzard
	alert_title = "Urgent Warning - Dark Season"
	message = "ROKER-class storm warning has determined that the Dark Season on your planet's surface has started early. It is anticipated that the oncoming blizzard will last no more than two hours and the season itself will last sixteen months. As space may soon become inaccessible from surface, crew should migrate valuables from orbital outpost in the next eight to ten minutes."

/datum/command_alert/prisoner_transfer
	alert_title = "Prisoner Transfer"
	message = "A suspected agent of the syndicate has been assigned to your station. The transport shuttle will dock at your station in approximately one minute. Crew payrolls have recieved a bonus as a result."

/datum/command_alert/ancientpod
	name = "Ancient Cryogenic Pod"
	alert_title = "Abnormal Life Sign Report"
	message = "An abnormal life sign has been detected in promiximity of the station. Long range scans determine signal to be human life. Approach with caution."