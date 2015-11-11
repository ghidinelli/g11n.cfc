<cfcomponent extends="mxunit.framework.TestCase">
	
	<cfprocessingdirective pageEncoding="utf-8" />
	
	<cffunction name="setup" output="false">
		<cfset variables.g11n = createObject("component", "model.g11n.g11n").init() />	
	</cffunction>


	<cffunction name="hasDayFirstFormatTest" access="public" returntype="void" output="false">
		<cfset assertTrue(NOT g11n.hasDayFirstFormat("en_US"), "en_US should be month first") />
		<cfset assertTrue(g11n.hasDayFirstFormat("en_GB"), "en_GB should be day first") />
		<cfset assertTrue(NOT g11n.hasDayFirstFormat("fr_CA"), "fr_CA should be month first") />
		<cfset assertTrue(g11n.hasDayFirstFormat("fr_FR"), "fr_FR should be day first") />
	</cffunction>


	<cffunction name="has24HourFormatTest" access="public" returntype="void" output="false">
		<cfset assertTrue(NOT g11n.hasDayFirstFormat("en_US"), "en_US should be 12 hour") />
		<cfset assertTrue(g11n.hasDayFirstFormat("en_GB"), "en_GB should be 24 hour") />
		<cfset assertTrue(NOT g11n.hasDayFirstFormat("fr_CA"), "fr_CA should be 12 hour") />
		<cfset assertTrue(g11n.hasDayFirstFormat("fr_FR"), "fr_FR should be 24 hour") />
	</cffunction>


	<cffunction name="hasDSTTest" access="public" returntype="void" output="false">
		<cfset assertTrue(g11n.hasDST("US/Pacific"), "US/Pacific should have DST") />
		<cfset assertTrue(g11n.hasDST("US/Eastern"), "US/Eastern should have DST") />
		<cfset assertTrue(g11n.hasDST("Europe/London"), "London should have DST") />
		<cfset assertTrue(g11n.hasDST("Europe/Paris"), "Paris should have DST") />
		<cfset assertTrue(NOT g11n.hasDST("US/Arizona"), "US/Arizona should NOT have DST") />
	</cffunction>


	<cffunction name="dateFormatPatternTest_en_US" output="false">
		<cfset var res = "" />
		
		<cfset g11n.setDefaultLocale("en_US") />
		<cfset res = g11n.getDateMask("short") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "M/d/yy", "en_US short datemask was: #res#") />

		<cfset res = g11n.getDateMask("medium") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "MMM d, yyyy", "en_US medium datemask was: #res#") />

		<cfset res = g11n.getDateMask("long") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "MMMM d, yyyy", "en_US long datemask was: #res#") />

		<cfset res = g11n.getDateMask("full") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "EEEE, MMMM d, yyyy", "en_US full datemask was: #res#") />
		
	</cffunction>


	<cffunction name="dateFormatPatternTest_en_CA" output="false">
		<cfset var res = "" />
		
		<cfset g11n.setDefaultLocale("en_CA") />
		<cfset res = g11n.getDateMask("short", "en_CA") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "dd/MM/yy", "en_CA short datemask was: #res#") />

		<cfset res = g11n.getDateMask("medium") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "d-MMM-yyyy", "en_CA medium datemask was: #res#") />

		<cfset res = g11n.getDateMask("long") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "MMMM d, yyyy", "en_CA long datemask was: #res#") />

		<cfset res = g11n.getDateMask("full") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "EEEE, MMMM d, yyyy", "en_CA full datemask was: #res#") />
		
	</cffunction>


	<cffunction name="dateFormatPatternTest_fr_CA" output="false">
		<cfset var res = "" />
		
		<cfset g11n.setDefaultLocale("fr_CA") />
		<cfset res = g11n.getDateMask("short") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "yy-MM-dd", "fr_CA short datemask was: #res#") />

		<cfset res = g11n.getDateMask("medium") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "yyyy-MM-dd", "fr_CA medium datemask was: #res#") />

		<cfset res = g11n.getDateMask("long") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "d MMMM yyyy", "fr_CA long datemask was: #res#") />

		<cfset res = g11n.getDateMask("full") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "EEEE d MMMM yyyy", "fr_CA full datemask was: #res#") />
		
	</cffunction>


	<cffunction name="dateFormatPatternTest_en_GB" output="false">
		<cfset var res = "" />
		
		<cfset g11n.setDefaultLocale("en_GB") />
		<cfset res = g11n.getDateMask("short") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "dd/MM/yy", "en_GB short datemask was: #res#") />

		<cfset res = g11n.getDateMask("medium") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "dd-MMM-yyyy", "en_GB medium datemask was: #res#") />

		<cfset res = g11n.getDateMask("long") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "dd MMMM yyyy", "en_GB long datemask was: #res#") />

		<cfset res = g11n.getDateMask("full") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "EEEE, d MMMM yyyy", "en_GB full datemask was: #res#") />
		
	</cffunction>


	<cffunction name="timeFormatPatternTest_en_US" output="false">
		<cfset var res = "" />
		
		<cfset g11n.setDefaultLocale("en_US") />
		<cfset res = g11n.getTimeMask("short") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "h:mm a", "en_US short timemask was: #res#") />

		<cfset res = g11n.getTimeMask("medium") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "h:mm:ss a", "en_US medium timemask was: #res#") />

		<cfset res = g11n.getTimeMask("long") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "h:mm:ss a z", "en_US long timemask was: #res#") />

		<cfset res = g11n.getTimeMask("full") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "h:mm:ss a z", "en_US full timemask was: #res#") />
		
	</cffunction>


	<cffunction name="timeFormatPatternTest_en_GB" output="false">
		<cfset var res = "" />
		
		<cfset g11n.setDefaultLocale("en_GB") />
		<cfset res = g11n.getTimeMask("short") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "HH:mm", "en_GB short timemask was: #res#") />

		<cfset res = g11n.getTimeMask("medium") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "HH:mm:ss", "en_GB medium timemask was: #res#") />

		<cfset res = g11n.getTimeMask("long") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "HH:mm:ss z", "en_GB long timemask was: #res#") />

		<cfset res = g11n.getTimeMask("full") />
		<cfset debug("#res# = #g11n.formatDateTime(now(), res)#") />
		<cfset assertTrue(res EQ "HH:mm:ss 'o''clock' z", "en_GB full timemask was: #res#") />
		
	</cffunction>


	<cffunction name="DateTimeFormatPatternTest_en_US" output="false">
		<cfset var dInUTC = createDateTime(2012, 12, 1, 8, 2, 3) /><!--- December 1st, 2012 at 8:02:03 AM in GMT/UTC --->

		<cfset g11n.setDefaultLocale("en_US") />
		<cfset g11n.setDefaultTimezone("US/Pacific") />
		
		<cfset assertTrue(g11n.getDateTimeMask("short") EQ "M/d/yy h:mm a", "en_US short timemask was: #g11n.getDateTimeMask("short")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "short") EQ "12/1/12 12:02 AM", "US/Pacific should be -8 in DST, was: #g11n.formatDateTime(dInUTC, "short")#") />

		<cfset assertTrue(g11n.getDateTimeMask("medium") EQ "MMM d, yyyy h:mm:ss a", "en_US medium timemask was: #g11n.getDateTimeMask("medium")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "medium") EQ "Dec 1, 2012 12:02:03 AM", "US/Pacific should be -8 in DST, was: #g11n.formatDateTime(dInUTC, "medium")#") />

		<cfset assertTrue(g11n.getDateTimeMask("long") EQ "MMMM d, yyyy h:mm:ss a z", "en_US long timemask was: #g11n.getDateTimeMask("long")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "long") EQ "December 1, 2012 12:02:03 AM PST", "US/Pacific should be -8 in DST, was: #g11n.formatDateTime(dInUTC, "long")#") />
		<cfset debug(g11n.formatDateTime(dInUTC, "long")) /><!--- looks like December 1, 2012 12:02:03 AM PST --->

		<cfset assertTrue(g11n.getDateTimeMask("full") EQ "EEEE, MMMM d, yyyy h:mm:ss a z", "en_US full timemask was: #g11n.getDateTimeMask("full")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "full") EQ "Saturday, December 1, 2012 12:02:03 AM PST", "US/Pacific should be -8 in DST, was: #g11n.formatDateTime(dInUTC, "full")#") />

		<!--- check arbitrary mask, watch use of HH vs. hh as a formatting difference --->
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "EEE, dd MMMM yyyy HH:mm:ss 'in' z") EQ "Sat, 01 December 2012 00:02:03 in PST", "US/Pacific should be -8 in DST, was: #g11n.formatDateTime(dInUTC, "EEE, dd MMMM yyyy HH:mm:ss 'in' z")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "EEE, dd MMMM yyyy hh:mm:ss 'in' z") EQ "Sat, 01 December 2012 12:02:03 in PST", "US/Pacific should be -8 in DST, was: #g11n.formatDateTime(dInUTC, "EEE, dd MMMM yyyy HH:mm:ss 'in' z")#") />


		<!--- times should be +3 hours now --->
		<cfset g11n.setDefaultTimezone("US/Eastern") />

		<cfset assertTrue(g11n.formatDateTime(dInUTC, "short") EQ "12/1/12 3:02 AM", "US/Eastern should be -5 in DST, was: #g11n.formatDateTime(dInUTC, "short")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "medium") EQ "Dec 1, 2012 3:02:03 AM", "US/Eastern should be -5 in DST, was: #g11n.formatDateTime(dInUTC, "medium")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "long") EQ "December 1, 2012 3:02:03 AM EST", "US/Eastern should be -5 in DST, was: #g11n.formatDateTime(dInUTC, "long")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "full") EQ "Saturday, December 1, 2012 3:02:03 AM EST", "US/Eastern should be -5 in DST, was: #g11n.formatDateTime(dInUTC, "full")#") />
		
		
		<!--- switch to a EDT date --->
		<cfset dInUTC = createDateTime(2012, 7, 1, 8, 2, 3) />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "short") EQ "7/1/12 4:02 A", "US/Eastern should be -4 in EDT, was: #g11n.formatDateTime(dInUTC, "short")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "medium") EQ "Jul 1, 2012 4:02:03 AM", "US/Eastern should be -4 in EDT, was: #g11n.formatDateTime(dInUTC, "medium")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "long") EQ "July 1, 2012 4:02:03 AM EDT", "US/Eastern should be -4 in EDT, was: #g11n.formatDateTime(dInUTC, "long")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "full") EQ "Sunday, July 1, 2012 4:02:03 AM EDT", "US/Eastern should be -4 in EDT, was: #g11n.formatDateTime(dInUTC, "full")#") />
		
		
		
	</cffunction>


	<cffunction name="DateTimeFormatPatternTest_en_GB" output="false">

		<cfset var dInUTC = createDateTime(2012, 12, 1, 8, 2, 3) /><!--- November 1st, 2012 at 8:02:03 AM in GMT/UTC --->

		<cfset g11n.setDefaultLocale("en_GB") />
		<cfset g11n.setDefaultTimezone("Europe/London") />
		
		<cfset assertTrue(g11n.getDateTimeMask("short") EQ "dd/MM/yy HH:mm", "en_GB short timemask was: #g11n.getDateTimeMask("short")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "short") EQ "01/12/12 8:02", "Europe/London should be +0, was: #g11n.formatDateTime(dInUTC, "short")#") />

		<cfset assertTrue(g11n.getDateTimeMask("medium") EQ "dd-MMM-yyyy HH:mm:ss", "en_GB medium timemask was: #g11n.getDateTimeMask("medium")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "medium") EQ "01-Dec-2012 8:02:03", "Europe/London should be +0, was: #g11n.formatDateTime(dInUTC, "medium")#") />

		<cfset assertTrue(g11n.getDateTimeMask("long") EQ "dd MMMM yyyy HH:mm:ss z", "en_GB long timemask was: #g11n.getDateTimeMask("long")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "long") EQ "01 December 2012 08:02:03 GMT", "Europe/London should be +0, was: #g11n.formatDateTime(dInUTC, "long")#") />

		<cfset assertTrue(g11n.getDateTimeMask("full") EQ "EEEE, d MMMM yyyy HH:mm:ss 'o''clock' z", "en_GB full timemask was: #g11n.getDateTimeMask("full")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "full") EQ "Saturday, 1 December 2012 08:02:03 o'clock GMT", "Europe/London should be +0, was: #g11n.formatDateTime(dInUTC, "full")#") />

		<!--- check arbitrary mask --->
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "EEE, dd MMMM yyyy HH:mm:ss 'in' z") EQ "Sat, 01 December 2012 08:02:03 in GMT", "Europe/London should be +0, was: #g11n.formatDateTime(dInUTC, "EEE, dd MMMM yyyy HH:mm:ss 'in' z")#") />
		
	
		<!--- switch to a DST date in British Summer Time which is GMT+1 --->
		<cfset dInUTC = createDateTime(2012, 7, 1, 8, 2, 3) />

		<cfset assertTrue(g11n.formatDateTime(dInUTC, "short") EQ "01/07/12 9:02", "Europe/London should be +1 for BST, was: #g11n.formatDateTime(dInUTC, "short")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "medium") EQ "01-Jul-2012 9:02:03", "Europe/London should be +1 for BST, was: #g11n.formatDateTime(dInUTC, "medium")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "long") EQ "01 July 2012 09:02:03 BST", "Europe/London should be +1 for BST, was: #g11n.formatDateTime(dInUTC, "long")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "full") EQ "Sunday, 1 July 2012 09:02:03 o'clock BST", "Europe/London should be +1 for BST, was: #g11n.formatDateTime(dInUTC, "full")#") />

	</cffunction>
	

	<cffunction name="DateTimeFormatPatternTest_fr_FR" output="false">

		<cfset var dInUTC = createDateTime(2012, 12, 1, 8, 2, 3) /><!--- November 1st, 2012 at 8:02:03 AM in GMT/UTC --->

		<cfset g11n.setDefaultLocale("fr_FR") />
		<cfset g11n.setDefaultTimezone("Europe/Paris") />
		
		<cfset assertTrue(g11n.getDateTimeMask("short") EQ "dd/MM/yy HH:mm", "fr_FR short timemask was: #g11n.getDateTimeMask("short")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "short") EQ "01/12/12 9:02", "Europe/Paris should be +1, was: #g11n.formatDateTime(dInUTC, "short")#") />

		<cfset assertTrue(g11n.getDateTimeMask("medium") EQ "d MMM yyyy HH:mm:ss", "fr_FR medium timemask was: #g11n.getDateTimeMask("medium")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "medium") EQ "1 déc. 2012 09:02:03", "Europe/Paris should be +1, was: #g11n.formatDateTime(dInUTC, "medium")#") />

		<cfset assertTrue(g11n.getDateTimeMask("long") EQ "d MMMM yyyy HH:mm:ss z", "fr_FR long timemask was: #g11n.getDateTimeMask("long")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "long") EQ "1 décembre 2012 09:02:03 CET", "Europe/Paris should be +1, was: #g11n.formatDateTime(dInUTC, "long")#") />

		<cfset assertTrue(g11n.getDateTimeMask("full") EQ "EEEE d MMMM yyyy HH' h 'mm z", "fr_FR full timemask was: #g11n.getDateTimeMask("full")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "full") EQ "samedi 1 décembre 2012 09 h 02 CET", "Europe/Paris should be +1, was: #g11n.formatDateTime(dInUTC, "full")#") />

		<!--- check arbitrary mask --->
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "EEE, dd MMMM yyyy HH:mm:ss 'in' z") EQ "sam., 01 décembre 2012 09:02:03 in CET", "Europe/Paris should be +1, was: #g11n.formatDateTime(dInUTC, "EEE, dd MMMM yyyy HH:mm:ss 'in' z")#") />
		
	
		<!--- switch to a DST date in European DST which is GMT+2 --->
		<cfset dInUTC = createDateTime(2012, 7, 1, 8, 2, 3) />

		<cfset assertTrue(g11n.formatDateTime(dInUTC, "short") EQ "01/07/12 10:02", "Europe/Paris should be +2 for WET, was: #g11n.formatDateTime(dInUTC, "short")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "medium") EQ "1 juil. 2012 10:02:03", "Europe/Paris should be +2 for WET, was: #g11n.formatDateTime(dInUTC, "medium")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "long") EQ "1 juillet 2012 10:02:03 CEST", "Europe/Paris should be +2 for WET, was: #g11n.formatDateTime(dInUTC, "long")#") />
		<cfset assertTrue(g11n.formatDateTime(dInUTC, "full") EQ "dimanche 1 juillet 2012 10 h 02 CEST", "Europe/Paris should be +2 for WET, was: #g11n.formatDateTime(dInUTC, "full")#") />

	</cffunction>
	

	<cffunction name="testGetDateAtMidnightInUTC" output="false" access="public" returntype="any" hint="Take a date (assumed to mean midnight) in a local TZ and cast it to a UTC timestamp">

		<cfset var estMidnightInUTC = createDateTime(2012, 12, 1, 5, 0, 0) />
		<cfset var pstMidnightInUTC = createDateTime(2012, 12, 1, 8, 0, 0) />
		<cfset var pdtMidnightInUTC = createDateTime(2012, 7, 1, 7, 0, 0) />

		<cfset assertTrue(g11n.getDateAtMidnightInUTC("12/1/2012", "US/Eastern") EQ estMidnightInUTC, "EST midnight failed, was: #g11n.getDateAtMidnightInUTC("12/1/2012", "US/Eastern")#") />
		<cfset assertTrue(g11n.getDateAtMidnightInUTC("12/1/2012", "US/Pacific") EQ pstMidnightInUTC, "PST midnight failed, was: #g11n.getDateAtMidnightInUTC("12/1/2012", "US/Pacific")#") />
		<cfset assertTrue(g11n.getDateAtMidnightInUTC("7/1/2012", "US/Pacific") EQ pdtMidnightInUTC, "PDT midnight failed, was: #g11n.getDateAtMidnightInUTC("7/1/2012", "US/Pacific")#") />
	
		<!--- test the defaults --->
		<cfset g11n.setDefaultTimezone("US/Eastern") />
		<cfset assertTrue(g11n.getDateAtMidnightInUTC("12/1/2012") EQ estMidnightInUTC, "EST default midnight failed, was: #g11n.getDateAtMidnightInUTC("12/1/2012")#") />
		<cfset assertTrue(g11n.getDateAtMidnightInUTC("12/1/2012") NEQ pstMidnightInUTC, "PST default midnight succeeded, was: #g11n.getDateAtMidnightInUTC("12/1/2012")#") />
	
	</cffunction>


	<cffunction name="testConvertDateOnlyToMidnightInUTC" output="false" access="public" returntype="any">
		<cfset var d = "2013-02-15" />
		<cfset g11n.setDefaultTimezone("US/Pacific") />
		<cfset assertTrue(g11n.getDateAtMidnightInUTC(d) EQ createDateTime(2013, 2, 15, 8, 0, 0), "The time should be +8 to handle PDT-UTC offset") />

		<!--- also try formatting a string date --->
		<cfset debug(g11n.formatDate(g11n.getDateAtMidnightInUTC(d), "M/d/yyyy")) />


		<cfset g11n.setDefaultTimezone("US/Eastern") />
		<cfset assertTrue(g11n.getDateAtMidnightInUTC(d) EQ createDateTime(2013, 2, 15, 5, 0, 0), "The time should be +5 to handle EDT-UTC offset") />

	</cffunction>


	<cffunction name="testFormatTime" output="false" access="public" returntype="any">
		<cfset var d = createDateTime(2012, 04, 15, 9, 0, 0) />
		<cfset var arrResults = [] />
		<cfset var res = "" />

		<cfset g11n.setDefaultTimezone("US/Pacific") />
		
		<cfset res = g11n.formatTime(d, "short") />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "2:00 AM", "The en_US interpretation in PDT failed, was: #res#") />

		<cfset res = g11n.formatTime(d, "medium") />
		<cfset arrayAppend(arrResults, res) />

		<cfset res = g11n.formatTime(d, "long") />
		<cfset arrayAppend(arrResults, res) />

		<cfset res = g11n.formatTime(d, "full") />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "2:00:00 AM PDT", "The en_US interpretation in PDT failed, was: #res#") />


		<cfset g11n.setDefaultLocale("fr_FR") />
		
		<cfset res = g11n.formatTime(d, "short") />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "02:00", "The fr_FR interpretation in PDT failed, was: #res#") />

		<cfset res = g11n.formatTime(d, "medium") />
		<cfset arrayAppend(arrResults, res) />

		<cfset res = g11n.formatTime(d, "long") />
		<cfset arrayAppend(arrResults, res) />

		<cfset res = g11n.formatTime(d, "full") />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "02 h 00 PDT", "The fr_FR interpretation in PDT failed, was: #res#") />

		<cfset debug(arrResults) />
	
	</cffunction>


	<cffunction name="testFormatDate" output="false" access="public" returntype="any">
		<cfset var d = createDateTime(2012, 04, 15, 9, 0, 0) />
		<cfset var arrResults = [] />
		<cfset var res = "" />

		<cfset g11n.setDefaultTimezone("US/Pacific") />
		
		<cfset res = g11n.formatDate(d, "short") />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "4/15/12", "The en_US interpretation in PDT failed, was: #res#") />

		<cfset res = g11n.formatDate(d, "medium") />
		<cfset arrayAppend(arrResults, res) />

		<cfset res = g11n.formatDate(d, "long") />
		<cfset arrayAppend(arrResults, res) />

		<cfset res = g11n.formatDate(d, "full") />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "Sunday, April 15, 2012", "The en_US interpretation in PDT failed, was: #res#") />

		<!--- test arbitrary non-numeric format --->
		<cfset res = g11n.formatDate(d, "MMMM - d - yyyy") />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "April - 15 - 2012", "The en_US interpretation in PDT failed, was: #res#") />

		<!--- pass a date as it comes out of postgres in yyyy-mm-dd, with no time it gets cast into 4/14/12 so we have to cast date-only values --->
		<cfset res = g11n.formatDate(g11n.castToUTC("2012-04-15"), "MMMM - d - yyyy") />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "April - 15 - 2012", "The en_US interpretation in PDT failed, was: #res#") />


		<cfset g11n.setDefaultLocale("fr_FR") />
		
		<cfset res = g11n.formatDate(d, "short") />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "15/04/12", "The fr_FR interpretation in PDT failed, was: #res#") />

		<cfset res = g11n.formatDate(d, "medium") />
		<cfset arrayAppend(arrResults, res) />

		<cfset res = g11n.formatDate(d, "long") />
		<cfset arrayAppend(arrResults, res) />

		<cfset res = g11n.formatDate(d, "full") />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "dimanche 15 avril 2012", "The fr_FR interpretation in PDT failed, was: #res#") />

		<!--- test arbitrary non-numeric format --->
		<cfset res = g11n.formatDate(d, "MMMM - d - yyyy") />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "avril - 15 - 2012", "The fr_FR interpretation in PDT failed, was: #res#") />


		<cfset debug(arrResults) />
	
	</cffunction>	


	<cffunction name="testFormatDateTimeISO" output="false" access="public" returntype="any">
		<cfset var d = createDateTime(2012, 04, 15, 2, 0, 15) /><!--- datetime in UTC = 4/14/12 7:00pm/19:00 in US/Pacific --->
		<cfset var arrResults = [] />
		<cfset var res = "" />

		<cfset g11n.setDefaultTimezone("US/Pacific") />
		
		<cfset res = g11n.formatDateTimeISO(d) />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "2012-04-14 19:00:15", "The en_US interpretation in PDT failed, was: #res#") />

		<cfset g11n.setDefaultLocale("fr_FR") />
		<cfset g11n.setDefaultTimezone("UTC") />
		
		<cfset res = g11n.formatDateTimeISO(d) />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "2012-04-15 02:00:15", "The fr_FR interpretation in PDT failed, was: #res#") />

		<cfset d = now() />
		<cfset res = g11n.formatDateTimeISO(d) />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "#dateFormat(d, 'yyyy-mm-dd')# #timeFormat(d, 'HH:mm:ss')#", "The 'now' interpretation in UTC failed, was: #res#, not #dateFormat(d, 'yyyy-mm-dd')# #timeFormat(d, 'HH:mm:ss')#") />

		<cfset debug(arrResults) />
	
	</cffunction>


	<cffunction name="testFormatDateTimeISO8601" output="false" access="public" returntype="any">
		<cfset var d = createDateTime(2012, 04, 15, 2, 0, 15) /><!--- datetime in UTC = 4/14/12 7:00pm/19:00 in US/Pacific --->
		<cfset var arrResults = [] />
		<cfset var res = "" />

		<cfset g11n.setDefaultTimezone("US/Pacific") />
		
		<cfset res = g11n.formatDateTimeISO8601(d) />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "2012-04-14T19:00:15-0700", "The en_US interpretation in PDT failed, was: #res#") />

		<cfset g11n.setDefaultLocale("fr_FR") />
		<cfset g11n.setDefaultTimezone("UTC") />
		
		<cfset res = g11n.formatDateTimeISO8601(d) />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "2012-04-15T02:00:15+0000", "The fr_FR interpretation in PDT failed, was: #res#") />

		<cfset d = now() />
		<cfset res = g11n.formatDateTimeISO8601(d) />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "#dateFormat(d, 'yyyy-mm-dd')#T#timeFormat(d, 'HH:mm:ss')#+0000", "The 'now' interpretation in UTC failed, was: #res#, not #dateFormat(d, 'yyyy-mm-dd')#T#timeFormat(d, 'HH:mm:ss')#+0000") />

		<cfset debug(arrResults) />
	
	</cffunction>	


	<cffunction name="testFormatDateISO" output="false" access="public" returntype="any">
		<cfset var d = createDateTime(2012, 04, 15, 2, 0, 0) /><!--- datetime in UTC = 4/14/12 7:00pm/19:00 in US/Pacific --->
		<cfset var arrResults = [] />
		<cfset var res = "" />

		<cfset g11n.setDefaultTimezone("US/Pacific") />
		
		<cfset res = g11n.formatDateISO(d) />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "2012-04-14", "The en_US interpretation in PDT failed, was: #res#") />

		<cfset g11n.setDefaultLocale("fr_FR") />
		<cfset g11n.setDefaultTimezone("UTC") />
		
		<cfset res = g11n.formatDateISO(d) />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "2012-04-15", "The fr_FR interpretation in PDT failed, was: #res#") />

		<cfset d = now() />
		<cfset res = g11n.formatDateISO(d) />
		<cfset arrayAppend(arrResults, res) />
		<cfset assertTrue(res EQ "#dateFormat(d, 'yyyy-mm-dd')#", "The 'now' interpretation in UTC failed, was: #res#, not #dateFormat(d, 'yyyy-mm-dd')#") />

		<cfset debug(arrResults) />
	
	</cffunction>	


	<cffunction name="testFormatMonthDayLong" output="false" access="public" returntype="any">

		<cfset var d = createDateTime(2012, 12, 1, 2, 0, 0) /><!--- December 1st, 2012 at 2:00:00 AM in GMT/UTC = November 30, 2012 at 6:00:00 PM in PDT --->
	
		<cfset g11n.setDefaultLocale("en_US") />
		<cfset assertTrue(g11n.FormatMonthDayLong(d) EQ "November 30", "en_US should be November 30, was: #g11n.FormatMonthDayLong(d)#") />

		<cfset assertTrue(g11n.FormatMonthDayLong(d, "en_CA") EQ "November 30", "en_CA should be November 30, was: #g11n.FormatMonthDayLong(d, "en_CA")#") />
		<cfset g11n.setDefaultLocale("en_CA") />
		<cfset assertTrue(g11n.FormatMonthDayLong(d) EQ "November 30", "en_CA should be November 30, was: #g11n.FormatMonthDayLong(d)#") />

		<cfset assertTrue(g11n.FormatMonthDayLong(d, "en_GB") EQ "30 November", "en_GB should be 30 November, was: #g11n.FormatMonthDayLong(d, "en_GB")#") />
		<cfset g11n.setDefaultLocale("en_GB") />
		<cfset assertTrue(g11n.FormatMonthDayLong(d) EQ "30 November", "en_GB should be 30 November, was: #g11n.FormatMonthDayLong(d)#") />

		<cfset assertTrue(g11n.FormatMonthDayLong(d, "fr_FR") EQ "30 novembre", "fr_FR should be 30 novembre, was: #g11n.FormatMonthDayLong(d, "fr_FR")#") />
		<cfset g11n.setDefaultLocale("fr_FR") />
		<cfset assertTrue(g11n.FormatMonthDayLong(d) EQ "30 novembre", "fr_FR should be 30 novembre, was: #g11n.FormatMonthDayLong(d)#") />
	
	</cffunction>


	<cffunction name="testFormatDateLongTimeShort" output="false" access="public" returntype="any">

		<cfset var d = createDateTime(2012, 12, 1, 2, 0, 0) /><!--- December 1st, 2012 at 2:00:00 AM in GMT/UTC = November 30, 2012 at 6:00:00 PM in PDT --->
	
		<cfset g11n.setDefaultLocale("en_US") />
		<cfset assertTrue(g11n.formatDateLongTimeShort(d) EQ "November 30, 2012 6:00 PM", "en_US should be November 30, 2012 6:00 PM, was: #g11n.formatDateLongTimeShort(d)#") />

		<cfset assertTrue(g11n.formatDateLongTimeShort(d, "en_CA") EQ "November 30, 2012 6:00 PM", "en_CA should be November 30, 2012 6:00 PM was: #g11n.formatDateLongTimeShort(d, "en_CA")#") />
		<cfset g11n.setDefaultLocale("en_CA") />
		<cfset assertTrue(g11n.formatDateLongTimeShort(d) EQ "November 30, 2012 6:00 PM", "en_CA should be November 30, 2012 6:00 PM, was: #g11n.formatDateLongTimeShort(d)#") />

		<cfset assertTrue(g11n.formatDateLongTimeShort(d, "en_GB") EQ "30 November 2012 18:00", "en_GB should be 30 November 2012 18:00, was: #g11n.formatDateLongTimeShort(d, "en_GB")#") />
		<cfset g11n.setDefaultLocale("en_GB") />
		<cfset assertTrue(g11n.formatDateLongTimeShort(d) EQ "30 November 2012 18:00", "en_GB should be 30 November 2012 18:00, was: #g11n.formatDateLongTimeShort(d)#") />

		<cfset assertTrue(g11n.formatDateLongTimeShort(d, "fr_FR") EQ "30 novembre 2012 18:00", "fr_FR should be 30 novembre 2012 18:00, was: #g11n.formatDateLongTimeShort(d, "fr_FR")#") />
		<cfset g11n.setDefaultLocale("fr_FR") />
		<cfset assertTrue(g11n.formatDateLongTimeShort(d) EQ "30 novembre 2012 18:00", "fr_FR should be 30 novembre 2012 18:00, was: #g11n.formatDateLongTimeShort(d)#") />
	
	</cffunction>
	

	<cffunction name="testFormatBlankString" output="false" access="public" returntype="any">

		<cfset var d = "" /><!--- December 1st, 2012 at 2:00:00 AM in GMT/UTC = November 30, 2012 at 6:00:00 PM in PDT --->
	
		<cfset g11n.setDefaultLocale("en_US") />
		<cfset assertTrue(g11n.formatDate(d) EQ "", "Invalid date in should return blank string, was: #g11n.formatDate(d)#") />

		<cfset assertTrue(g11n.formatDate('Apr') EQ "", "Invalid date in should return blank string, was: #g11n.formatDate('Apr')#") />

	</cffunction>
	

	<cffunction name="testFormatMonthDayShort" output="false" access="public" returntype="any">

		<cfset var d = createDateTime(2012, 12, 1, 2, 0, 0) /><!--- December 1st, 2012 at 2:00:00 AM in GMT/UTC = November 30, 2012 at 6:00:00 PM in PDT --->
	
		<cfset g11n.setDefaultLocale("en_US") />
		<cfset assertTrue(g11n.formatMonthDayShort(d) EQ "Nov 30", "en_US should be Nov 30, was: #g11n.formatMonthDayShort(d)#") />

		<cfset g11n.setDefaultLocale("en_CA") />
		<cfset assertTrue(g11n.formatMonthDayShort(d) EQ "Nov 30", "en_CA should be Nov 30, was: #g11n.formatMonthDayShort(d)#") />

		<cfset g11n.setDefaultLocale("en_GB") />
		<cfset assertTrue(g11n.formatMonthDayShort(d) EQ "30 Nov", "en_GB should be 30 Nov, was: #g11n.formatMonthDayShort(d)#") />

		<cfset g11n.setDefaultLocale("fr_FR") />
		<cfset assertTrue(g11n.formatMonthDayShort(d) EQ "30 nov.", "fr_FR should be 30 nov., was: #g11n.formatMonthDayShort(d)#") />
	
	</cffunction>


	<cffunction name="testFormatDateMonthDayTime24" output="false" access="public" returntype="any">

		<cfset var d = createDateTime(2012, 12, 1, 2, 0, 0) /><!--- December 1st, 2012 at 2:00:00 AM in GMT/UTC = November 30, 2012 at 18:00:00 in PDT --->
	
		<cfset g11n.setDefaultLocale("en_US") />
		<cfset assertTrue(g11n.formatDateMonthDayTime24(d) EQ "Nov 30 18:00", "en_US should be Nov 30 18:00, was: #g11n.formatDateMonthDayTime24(d)#") />

		<cfset g11n.setDefaultLocale("en_CA") />
		<cfset assertTrue(g11n.formatDateMonthDayTime24(d) EQ "Nov 30 18:00", "en_CA should be Nov 30 18:00, was: #g11n.formatDateMonthDayTime24(d)#") />

		<cfset g11n.setDefaultLocale("en_GB") />
		<cfset assertTrue(g11n.formatDateMonthDayTime24(d) EQ "30 Nov 18:00", "en_GB should be 30 Nov, was: #g11n.formatDateMonthDayTime24(d)#") />

		<cfset g11n.setDefaultLocale("fr_FR") />
		<cfset assertTrue(g11n.formatDateMonthDayTime24(d) EQ "30 nov. 18:00", "fr_FR should be 30 nov., was: #g11n.formatDateMonthDayTime24(d)#") />
	
	</cffunction>


	<cffunction name="testInvalidDatesReturnBlankStrings" access="public" output="false" returntype="void">
		
		<cfset assertTrue(g11n.formatDateTime("") EQ "", "Invalid dates should return blank strings") />
		<cfset assertTrue(g11n.formatDate("") EQ "", "Invalid dates should return blank strings") />
		<cfset assertTrue(g11n.formatTime("") EQ "", "Invalid dates should return blank strings") />
		<cfset assertTrue(g11n.formatMonthDayLong("") EQ "", "Invalid dates should return blank strings") />
		<cfset assertTrue(g11n.formatMonthDayShort("") EQ "", "Invalid dates should return blank strings") />
		<cfset assertTrue(g11n.formatDateLongTimeShort("") EQ "", "Invalid dates should return blank strings") />
		<cfset assertTrue(g11n.formatDateMonthDayTime24("") EQ "", "Invalid dates should return blank strings, was: #g11n.formatDateMonthDayTime24("")#") />
	
	</cffunction>


	<cffunction name="getTimezoneDisplayTest" output="false" access="public" returntype="any">
		<cfset g11n.setDefaultTimezone("US/Pacific") />
		<cfset assertTrue(g11n.getTimezoneDisplayName(dtm = "7/7/2013") EQ "Pacific Daylight Time", "Default should be Pacific Daylight Time, was: #g11n.getTimezoneDisplayName(dtm = "7/7/2013")#") />
		<cfset assertTrue(g11n.getTimezoneDisplayName(dtm = "12/8/2013") EQ "Pacific Standard Time", "Default should be Pacific Standard Time, was: #g11n.getTimezoneDisplayName(dtm = "12/8/2013")#") />

		<cfset g11n.setDefaultTimezone("US/Eastern")>
		<cfset assertTrue(g11n.getTimezoneDisplayName(dtm = "7/7/2013") EQ "Eastern Daylight Time", "Default should be Eastern Daylight Time, was: #g11n.getTimezoneDisplayName(dtm = "7/7/2013")#") />
		<cfset assertTrue(g11n.getTimezoneDisplayName(dtm = "12/8/2013") EQ "Eastern Standard Time", "Default should be Eastern Standard Time, was: #g11n.getTimezoneDisplayName(dtm = "12/8/2013")#") />

		<cfset assertTrue(g11n.getTimezoneDisplayName(tzid = "Europe/London", dtm = "7/7/2013") EQ "British Summer Time", "Should be British Summer Time, was: #g11n.getTimezoneDisplayName(tzid = "Europe/London", dtm = "7/7/2013")#") />
		<cfset assertTrue(g11n.getTimezoneDisplayName(tzid = "Europe/London", dtm = "12/8/2013") EQ "Greenwich Mean Time", "Should be Greenwich Mean Time, was: #g11n.getTimezoneDisplayName(tzid = "Europe/London", dtm = "12/8/2013")#") />
	</cffunction>


	<cffunction name="getTimezoneDisplayShortTest" output="false" access="public" returntype="any">
		<cfset g11n.setDefaultTimezone("US/Pacific") />
		<cfset assertTrue(g11n.getTimezoneDisplayNameShort(dtm = "7/7/2013") EQ "PDT", "Default should be Pacific Daylight Time, was: #g11n.getTimezoneDisplayName(dtm = '7/7/2013')#") />
		<cfset assertTrue(g11n.getTimezoneDisplayNameShort(dtm = "12/8/2013") EQ "PST", "Default should be Pacific Standard Time, was: #g11n.getTimezoneDisplayName(dtm = '12/8/2013')#") />

		<cfset g11n.setDefaultTimezone("US/Eastern")>
		<cfset assertTrue(g11n.getTimezoneDisplayNameShort(dtm = "7/7/2013") EQ "EDT", "Default should be Eastern Daylight Time, was: #g11n.getTimezoneDisplayName(dtm = '7/7/2013')#") />
		<cfset assertTrue(g11n.getTimezoneDisplayNameShort(dtm = "12/8/2013") EQ "EST", "Default should be Eastern Standard Time, was: #g11n.getTimezoneDisplayName(dtm = '12/8/2013')#") />

		<cfset assertTrue(g11n.getTimezoneDisplayNameShort(tzid = "Europe/London", dtm = "7/7/2013") EQ "BST", "Should be British Summer Time, was: #g11n.getTimezoneDisplayName(tzid = "Europe/London", dtm = "7/7/2013")#") />
		<cfset assertTrue(g11n.getTimezoneDisplayNameShort(tzid = "Europe/London", dtm = "12/8/2013") EQ "GMT", "Should be Greenwich Mean Time, was: #g11n.getTimezoneDisplayName(tzid = "Europe/London", dtm = "12/8/2013")#") />
	</cffunction>


	<cffunction name="getAllAvailableTimezonesTest" output="false" access="public" returntype="any">
		<cfset var res = g11n.getAvailableTimezones() />
		<cfset assertTrue(isArray(res), "Result should be an array of TZs") />
		<cfset assertTrue(arrayLen(res) GT 100, "Result should have a huge list (more than 100), was: #arrayLen(res)#") />
	</cffunction>


	<cffunction name="getPartialAvailableTimezonesTest" output="false" access="public" returntype="any">
		<cfset var res = g11n.getAvailableTimezones("US/") />
		<cfset assertTrue(isArray(res), "Result should be an array of TZs") />
		<cfset assertTrue(arrayLen(res) EQ 13, "TZ's starting with US/ should number 13, was: #arrayLen(res)#") />

		<cfset res = g11n.getAvailableTimezones("^US|^Europe|^Canada") />
		<cfset assertTrue(arrayLen(res) EQ 81, "TZ's starting with US|Europe|Canada should number 81 on JVM 1.7u71 (was 80 on JVM 1.7u65), was: #arrayLen(res)#") />
	</cffunction>


	<cffunction name="convertOldTZ2NewTZTest" output="false" access="public" returntype="any">
		<cfset var res = g11n.convertHistoricalTZ("US/Pacific") />
		<cfset assertTrue(res EQ "America/Los_Angeles", "Should have been America/Los_Angeles, was #res#") />

		<cfset res = g11n.convertHistoricalTZ("America/Denver") />
		<cfset assertTrue(res EQ "America/Denver", "Should have been America/Denver, was #res#") />
	</cffunction>

	
	<cffunction name="getTimezoneOffsetTest" output="false" access="public" returntype="any">
		<cfset var dInUTC = createDateTime(2012, 12, 1, 8, 5, 10) />

		<!--- get timezone offset should always calculate the difference between the requested (or current TZ) and specified TZ --->
		<cfset g11n.setDefaultTimezone("US/Pacific") />
		<cfset assertTrue(g11n.getTimezoneOffset("US/Pacific", dInUTC)/3600000 EQ -8, "PDT should be -8, was: #g11n.getTimezoneOffset("US/Pacific", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("US/Eastern", dInUTC)/3600000 EQ -5, "EDT should be -5, was: #g11n.getTimezoneOffset("US/Eastern", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("UTC", dInUTC)/3600000 EQ 0, "UTC should be 0, was: #g11n.getTimezoneOffset("UTC", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("Europe/London", dInUTC)/3600000 EQ 0, "GMT should be 0, was: #g11n.getTimezoneOffset("Europe/London", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("Europe/Paris", dInUTC)/3600000 EQ 1, "CET should be +1, was: #g11n.getTimezoneOffset("Europe/Paris", dInUTC)/3600000#") />
		<!--- test default = us/pacific --->
		<cfset assertTrue(g11n.getTimezoneOffset(dtm = dInUTC)/3600000 EQ -8, "PDT should be -8, was: #g11n.getTimezoneOffset(dtm = dInUTC)/3600000#") />


		<cfset g11n.setDefaultTimezone("UTC") />
		<cfset assertTrue(g11n.getTimezoneOffset("US/Pacific", dInUTC)/3600000 EQ -8, "PDT should be -8, was: #g11n.getTimezoneOffset("US/Pacific", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("US/Eastern", dInUTC)/3600000 EQ -5, "EDT should be -5, was: #g11n.getTimezoneOffset("US/Eastern", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("UTC", dInUTC)/3600000 EQ 0, "UTC should be 0, was: #g11n.getTimezoneOffset("UTC", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("Europe/London", dInUTC)/3600000 EQ 0, "GMT should be 0, was: #g11n.getTimezoneOffset("Europe/London", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("Europe/Paris", dInUTC)/3600000 EQ 1, "CET should be +1, was: #g11n.getTimezoneOffset("Europe/Paris", dInUTC)/3600000#") />
		<!--- test default = utc --->
		<cfset assertTrue(g11n.getTimezoneOffset(dtm = dInUTC)/3600000 EQ 0, "UTC should be 0, was: #g11n.getTimezoneOffset(dtm = dInUTC)/3600000#") />

		<cfset g11n.setDefaultTimezone("US/Eastern") />
		<cfset assertTrue(g11n.getTimezoneOffset("US/Pacific", dInUTC)/3600000 EQ -8, "PDT should be -8, was: #g11n.getTimezoneOffset("US/Pacific", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("US/Eastern", dInUTC)/3600000 EQ -5, "EDT should be -5, was: #g11n.getTimezoneOffset("US/Eastern", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("UTC", dInUTC)/3600000 EQ 0, "UTC should be 0, was: #g11n.getTimezoneOffset("UTC", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("Europe/London", dInUTC)/3600000 EQ 0, "GMT should be 0, was: #g11n.getTimezoneOffset("Europe/London", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("Europe/Paris", dInUTC)/3600000 EQ 1, "CET should be +1, was: #g11n.getTimezoneOffset("Europe/Paris", dInUTC)/3600000#") />
		<!--- test default = utc --->
		<cfset assertTrue(g11n.getTimezoneOffset(dtm = dInUTC)/3600000 EQ -5, "EDT should be -4, was: #g11n.getTimezoneOffset(dtm = dInUTC)/3600000#") />


		<!--- change to a STD date --->
		<cfset dInUTC = createDateTime(2012, 7, 1, 8, 5, 10) />

		<cfset g11n.setDefaultTimezone("US/Pacific") />
		<cfset assertTrue(g11n.getTimezoneOffset("US/Pacific", dInUTC)/3600000 EQ -7, "PST should be -7, was: #g11n.getTimezoneOffset("US/Pacific", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("US/Eastern", dInUTC)/3600000 EQ -4, "EST should be -4, was: #g11n.getTimezoneOffset("US/Eastern", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("UTC", dInUTC)/3600000 EQ 0, "UTC should always be 0, was: #g11n.getTimezoneOffset("UTC", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("Europe/London", dInUTC)/3600000 EQ 1, "BST should be +1, was: #g11n.getTimezoneOffset("Europe/London", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("Europe/Paris", dInUTC)/3600000 EQ 2, "CEST should be +2, was: #g11n.getTimezoneOffset("Europe/Paris", dInUTC)/3600000#") />

		<cfset g11n.setDefaultTimezone("UTC") />
		<cfset assertTrue(g11n.getTimezoneOffset("US/Pacific", dInUTC)/3600000 EQ -7, "PST should be -7, was: #g11n.getTimezoneOffset("US/Pacific", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("US/Eastern", dInUTC)/3600000 EQ -4, "EST should be -4, was: #g11n.getTimezoneOffset("US/Eastern", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("UTC", dInUTC)/3600000 EQ 0, "UTC should always be 0, was: #g11n.getTimezoneOffset("UTC", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("Europe/London", dInUTC)/3600000 EQ 1, "BST should be +1, was: #g11n.getTimezoneOffset("Europe/London", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("Europe/Paris", dInUTC)/3600000 EQ 2, "CEST should be +2, was: #g11n.getTimezoneOffset("Europe/Paris", dInUTC)/3600000#") />

		<cfset g11n.setDefaultTimezone("US/Eastern") />
		<cfset assertTrue(g11n.getTimezoneOffset("US/Pacific", dInUTC)/3600000 EQ -7, "PST should be -7, was: #g11n.getTimezoneOffset("US/Pacific", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("US/Eastern", dInUTC)/3600000 EQ -4, "EST should be -4, was: #g11n.getTimezoneOffset("US/Eastern", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("UTC", dInUTC)/3600000 EQ 0, "UTC should always be 0, was: #g11n.getTimezoneOffset("UTC", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("Europe/London", dInUTC)/3600000 EQ 1, "BST should be +1, was: #g11n.getTimezoneOffset("Europe/London", dInUTC)/3600000#") />
		<cfset assertTrue(g11n.getTimezoneOffset("Europe/Paris", dInUTC)/3600000 EQ 2, "CEST should be +2, was: #g11n.getTimezoneOffset("Europe/Paris", dInUTC)/3600000#") />


	</cffunction>


	<cffunction name="castToAndFromUTCTest" output="false" access="public" returntype="any">
		<cfset var dInUTC = createDateTime(2012, 12, 1, 8, 5, 10) />
		<cfset var dInLocalTZ = "" />
		<cfset var res = "" />
		<cfset var res2 = "" />
		<cfset var tzOffset = "" />

		<cfset g11n.setDefaultTimezone("UTC") />

		<cfset tzOffset = g11n.getTimezoneOffset("US/Pacific", dInUTC) />
		<cfset assertTrue(tzOffset/3600000 EQ -8, "PDT should be -8, was: #tzOffset/3600000#") />
		<cfset dInLocalTZ = dateAdd('l', tzOffset, dInUTC) />
		<cfset assertTrue(g11n.castFromUTC(dInUTC, "US/Pacific") EQ dInLocalTZ, "dInUTC (#dInUTC#) + tzOffset (#tzOffset/3600000#) = #g11n.castFromUTC(dInUTC, "US/Pacific")# != #dInLocalTZ#") />

		<!--- repeat after changing default --->		
		<cfset g11n.setDefaultTimezone("US/Pacific") />

		<cfset tzOffset = g11n.getTimezoneOffset("US/Pacific", dInUTC) />
		<cfset assertTrue(tzOffset/3600000 EQ -8, "PDT should be -8, was: #tzOffset/3600000#") />
		<cfset dInLocalTZ = dateAdd('l', tzOffset, dInUTC) />
		<cfset assertTrue(g11n.castFromUTC(dInUTC, "US/Pacific") EQ dInLocalTZ, "dInUTC (#dInUTC#) + tzOffset (#tzOffset/3600000#) = #g11n.castFromUTC(dInUTC, "US/Pacific")# != #dInLocalTZ#") />
	

		<cfset tzOffset = g11n.getTimezoneOffset("US/Eastern", dInUTC) />
		<cfset assertTrue(tzOffset/3600000 EQ -5, "EDT should be -5, was: #tzOffset/3600000#") />
		<cfset dInLocalTZ = dateAdd('l', tzOffset, dInUTC) />
		<cfset assertTrue(g11n.castFromUTC(dInUTC, "US/Eastern") EQ dInLocalTZ, "dInUTC (#dInUTC#) + tzOffset (#tzOffset/3600000#) = #g11n.castFromUTC(dInUTC, "US/Pacific")# != #dInLocalTZ#") />

		<!--- repeat after changing default --->
		<cfset g11n.setDefaultTimezone("US/Eastern") />
		<cfset tzOffset = g11n.getTimezoneOffset("US/Eastern", dInUTC) />
		<cfset assertTrue(tzOffset/3600000 EQ -5, "EDT should be -5, was: #tzOffset/3600000#") />
		<cfset dInLocalTZ = dateAdd('l', tzOffset, dInUTC) />
		<cfset assertTrue(g11n.castFromUTC(dInUTC, "US/Eastern") EQ dInLocalTZ, "dInUTC (#dInUTC#) + tzOffset (#tzOffset/3600000#) = #g11n.castFromUTC(dInUTC, "US/Pacific")# != #dInLocalTZ#") />


		<cfset tzOffset = g11n.getTimezoneOffset("UTC", dInUTC) />
		<cfset assertTrue(tzOffset/3600000 EQ 0, "UTC should be 0, was: #tzOffset/3600000#") />
		<cfset dInLocalTZ = dateAdd('l', tzOffset, dInUTC) />
		<cfset assertTrue(g11n.castFromUTC(dInUTC, "UTC") EQ dInLocalTZ, "dInUTC (#dInUTC#) + tzOffset (#tzOffset/3600000#) = #g11n.castFromUTC(dInUTC, "US/Pacific")# != #dInLocalTZ#") />
	
	</cffunction>
	
	
	<cffunction name="castToAndFromUTCInvalidDateTest" output="false" access="public" returntype="any">
		<cfset var res = "" />

		<cfset assertTrue(NOT len(g11n.castFromUTC("")), "Invalid date should cast to an empty string?") />
		<cfset assertTrue(NOT len(g11n.castToUTC("")), "Invalid date should cast to an empty string?") />
	
	</cffunction>
		
	
	<cffunction name="getNowTest" output="false" access="public" returntype="any">
		<cfset var n = g11n.getNowInUTC() />
		<cfset debug("Now in UTC = #n#") />
	
		<cfset n = g11n.getNowInTZ() />
		<cfset debug("Now in #g11n.getDefaultTimezone()# = #n#, should be -8 for PST") />

		<cfset n = g11n.getNowInTZ("US/Eastern") />
		<cfset debug("Now in US/Eastern = #n#, should be +3") />

		<cfset n = g11n.getNowInTZ("UTC") />
		<cfset debug("Now in UTC = #n#, should be +0") />
		
		<!--- change the default --->		
		<cfset g11n.setDefaultTimezone("UTC") />
		<cfset n = g11n.getNowInUTC() />
		<cfset debug("Now in (default) UTC = #n#, should be + 0") />

	</cffunction>
	
	
	<cffunction name="testInvalidTimezoneRevertsToGMT" output="false" access="public" returntype="any">
		<cfset g11n.setDefaultTimezone("Europe/Foobar") /><!--- don't waste the resources on set, but will throw on get --->
		<cfset assertTrue(g11n.getTimezoneDisplayNameShort() EQ "GMT", "Invalid TZ results in resetting to GMT, was: #g11n.getTimezoneDisplayNameShort()#") />

		<cfset g11n.setDefaultTimezone("US/Undefined") />
		<cfset assertTrue(g11n.getTimezoneDisplayNameShort() EQ "GMT", "Invalid TZ results in resetting to GMT, was: #g11n.getTimezoneDisplayNameShort()#") />

		<cfset g11n.setDefaultTimezone("en_US") />
		<cfset assertTrue(g11n.getTimezoneDisplayNameShort() EQ "GMT", "Invalid TZ results in resetting to GMT, was: #g11n.getTimezoneDisplayNameShort()#") />
	</cffunction>


	<cffunction name="testEquivalentLsDateFormat" output="false" access="public" returntype="any">
		<cfset var dtmRegOpen = createDateTime(2010, 6, 15, 7, 0, 0) /><!--- 6/15 00:00 in PST --->
		<cfset var arrResults = [] />
		
		<!--- old way --->
		<cfset arrayAppend(arrResults, "lsDateFormat short/short: #lsDateFormat(g11n.castFromUTC(dtmRegOpen, "US/Pacific"), 'short')# #lsTimeFormat(g11n.castFromUTC(dtmRegOpen, "US/Pacific"), "short")# #g11n.getTimezoneDisplayNameShort("US/Pacific")#") />
		<cfset arrayAppend(arrResults, "lsDateFormat full/short: #lsDateFormat(g11n.castFromUTC(dtmRegOpen, "US/Pacific"), 'full')# #lsTimeFormat(g11n.castFromUTC(dtmRegOpen, "US/Pacific"), "short")# #g11n.getTimezoneDisplayNameShort("US/Pacific")#") />

		<!--- new way --->
		<cfset arrayAppend(arrResults, "g11n/short: #g11n.formatDateTime(dtmRegOpen, "short")#") />
		<cfset arrayAppend(arrResults, "g11n/med: #g11n.formatDateTime(dtmRegOpen, "medium")#") />
		<cfset arrayAppend(arrResults, "g11n/long: #g11n.formatDateTime(dtmRegOpen, "long")#") />
		<cfset arrayAppend(arrResults, "g11n/full: #g11n.formatDateTime(dtmRegOpen, "full")#") />
	
		<cfset arrayAppend(arrResults, "g11n/custom w/o ss: #g11n.formatDateTime(dtmRegOpen, reReplace(g11n.getDateTimeMask("full"), "[:]?ss", ""))#") />
	
	
		<!--- auto-converts based on locale/tzid --->	
		<cfset g11n.setDefaultLocale("fr_FR") />
		<cfset g11n.setDefaultTimezone("Europe/Paris") />
		<cfset arrayAppend(arrResults, "g11n/short: #g11n.formatDateTime(dtmRegOpen, "short")#") />
		<cfset arrayAppend(arrResults, "g11n/med: #g11n.formatDateTime(dtmRegOpen, "medium")#") />
		<cfset arrayAppend(arrResults, "g11n/long: #g11n.formatDateTime(dtmRegOpen, "long")#") />
		<cfset arrayAppend(arrResults, "g11n/full: #g11n.formatDateTime(dtmRegOpen, "full")#") />
		<cfset arrayAppend(arrResults, "g11n/custom w/o ss: #g11n.formatDateTime(dtmRegOpen, reReplace(g11n.getDateTimeMask("full"), "[:]?ss", ""))#") />
	
		<cfset debug(arrResults) />
	
	</cffunction>
	
	
	<cffunction name="testStringDateTimeParse" output="false" access="public" returntype="any">
		<cfset var res = g11n.dateTimeParse(dtm = "5/6/12 5:00 AM", locale = "en_US") />
		<cfset assertTrue(res EQ createDateTime(2012, 5, 6, 5, 0, 0), "The parsed date should have been May 6, 2012, was: #res#") />

		<cfset res = g11n.dateTimeParse(dtm = "5/6/12 5:00 AM", locale = "en_CA") />
		<cfset assertTrue(res EQ createDateTime(2012, 6, 5, 5, 0, 0), "The parsed date should have been June 5, 2012, was: #res#") />

		<!--- handle submitted dtmRegOpen/dtmRegClose times --->
		<cfset res = g11n.dateTimeParse(dtm = "05/06/12 5:00 AM", locale = "en_US") />
		<cfset assertTrue(res EQ createDateTime(2012, 5, 6, 5, 0, 0), "The parsed date should have been May 6, 2012, was: #res#") />

		<cfset res = g11n.dateTimeParse(dtm = "05/06/12 5:00 AM", locale = "en_CA") />
		<cfset assertTrue(res EQ createDateTime(2012, 6, 5, 5, 0, 0), "The parsed date should have been June 5, 2012, was: #res#") />

		<cfset res = g11n.dateTimeParse(dtm = "Wed, 31 May 2006 14:33:52 GMT", locale = "en_US", mask = "EEE, dd MMM yyyy HH:mm:ss Z") />	
		<cfset assertTrue(res EQ createDateTime(2006, 5, 31, 14, 33, 52), "The parsed date should have been May 31, 2006 GMT, was: #res#") />

		<cfset res = g11n.dateTimeParse(dtm = "Wed, 31 May 2006 14:33:52 PST", locale = "en_US", mask = "EEE, dd MMM yyyy HH:mm:ss Z") />	
		<cfset assertTrue(res EQ createDateTime(2006, 5, 31, 22, 33, 52), "The parsed date should be TZ-sensitive and cast to UTC for May 31, 2006 PST, was: #res#") />
	
	</cffunction>
	
	
	<cffunction name="testFormatCurrency" access="public" output="false" returntype="void">

		<cfset g11n.setDefaultLocale("en_US") />		
		<cfset assertTrue(g11n.formatCurrency(50) EQ "$50.00", "USD 50 failed, was: #g11n.formatCurrency(50)#") />
		<cfset assertTrue(g11n.formatCurrency(-50) EQ "($50.00)", "USD -50 failed, was: #g11n.formatCurrency(-50)#") />
		
		<cfset g11n.setDefaultLocale("en_GB") />
		<cfset assertTrue(g11n.formatCurrency(50) EQ "£50.00", "GBP 50 failed, was: #g11n.formatCurrency(50)#") />
		<cfset assertTrue(g11n.formatCurrency(-50) EQ "-£50.00", "GBP -50 failed, was: #g11n.formatCurrency(-50)#") />

		<cfset g11n.setDefaultLocale("fr_FR") />
		<cfset assertTrue(g11n.formatCurrency(50) EQ "50,00 €", "EUR 50 failed, was: #g11n.formatCurrency(50)#") />
		<cfset assertTrue(g11n.formatCurrency(-50) EQ "-50,00 €", "EUR -50 failed, was: #g11n.formatCurrency(-50)#") />
	
	</cffunction>
	

	<cffunction name="testFormatCurrencyWithoutSymbol" access="public" output="false" returntype="void">

		<cfset g11n.setDefaultLocale("en_US") />		
		<cfset assertTrue(g11n.formatCurrency(amount = 50, symbol = false) EQ "50.00", "USD 50 failed, was: #g11n.formatCurrency(amount = 50, symbol = false)#") />
		<cfset assertTrue(g11n.formatCurrency(amount = -50, symbol = false) EQ "-50.00", "USD -50 failed, was: #g11n.formatCurrency(amount = -50, symbol = false)#") />
		
		<cfset g11n.setDefaultLocale("en_GB") />
		<cfset assertTrue(g11n.formatCurrency(amount = 50, symbol = false) EQ "50.00", "GBP 50 failed, was: #g11n.formatCurrency(amount = 50, symbol = false)#") />
		<cfset assertTrue(g11n.formatCurrency(amount = -50, symbol = false) EQ "-50.00", "GBP -50 failed, was: #g11n.formatCurrency(amount = -50, symbol = false)#") />

		<cfset g11n.setDefaultLocale("fr_FR") />
		<cfset assertTrue(g11n.formatCurrency(amount = 50, symbol = false) EQ "50,00", "EUR 50 failed, was: #g11n.formatCurrency(amount = 50, symbol = false)#") />
		<cfset assertTrue(g11n.formatCurrency(amount = -50, symbol = false) EQ "-50,00", "EUR -50 failed, was: #g11n.formatCurrency(amount = -50, symbol = false)#") />
	
	</cffunction>
	
	
	<cffunction name="testGetCurrencyCode" access="public" output="false" returntype="void">

		<cfset g11n.setDefaultLocale("en_US") />		
		<cfset assertTrue(g11n.getCurrencyCode() EQ "USD", "#g11n.getDefaultLocale()# should be USD, was: #g11n.getCurrencyCode()#") />

		<cfset g11n.setDefaultLocale("en_CA") />		
		<cfset assertTrue(g11n.getCurrencyCode() EQ "CAD", "#g11n.getDefaultLocale()# should be CAD, was: #g11n.getCurrencyCode()#") />

		<cfset g11n.setDefaultLocale("fr_CA") />
		<cfset assertTrue(g11n.getCurrencyCode() EQ "CAD", "#g11n.getDefaultLocale()# should be CAD, was: #g11n.getCurrencyCode()#") />
		
		<cfset g11n.setDefaultLocale("en_GB") />
		<cfset assertTrue(g11n.getCurrencyCode() EQ "GBP", "#g11n.getDefaultLocale()# should be GBP, was: #g11n.getCurrencyCode()#") />

		<cfset g11n.setDefaultLocale("fr_FR") />
		<cfset assertTrue(g11n.getCurrencyCode() EQ "EUR", "#g11n.getDefaultLocale()# should be EUR, was: #g11n.getCurrencyCode()#") />
	
	</cffunction>


	<cffunction name="testGetCurrencySymbol" access="public" output="false" returntype="void">

		<cfset g11n.setDefaultLocale("en_US") />		
		<cfset assertTrue(g11n.getCurrencySymbol() EQ "$", "#g11n.getDefaultLocale()# should be $, was: #g11n.getCurrencySymbol()#") />

		<cfset g11n.setDefaultLocale("en_CA") />		
		<cfset assertTrue(g11n.getCurrencySymbol() EQ "$", "#g11n.getDefaultLocale()# should be $, was: #g11n.getCurrencySymbol()#") />

		<cfset g11n.setDefaultLocale("fr_CA") />
		<cfset assertTrue(g11n.getCurrencySymbol() EQ "$", "#g11n.getDefaultLocale()# should be $, was: #g11n.getCurrencySymbol()#") />
		
		<cfset g11n.setDefaultLocale("en_GB") />
		<cfset assertTrue(g11n.getCurrencySymbol() EQ "£", "#g11n.getDefaultLocale()# should be £, was: #g11n.getCurrencySymbol()#") />

		<cfset g11n.setDefaultLocale("fr_FR") />
		<cfset assertTrue(g11n.getCurrencySymbol() EQ "€", "#g11n.getDefaultLocale()# should be €, was: #g11n.getCurrencySymbol()#") />
	
	</cffunction>
	

	<cffunction name="castToAndFromUTCWithEmptyDefaultTZID" output="false" access="public" returntype="any">
		<cfset var res = "" />


		<cfset g11n.setDefaultLocale("en_US") />
		<cfset g11n.setDefaultTimezone("") /><!--- somehow this happens, not sure how? --->

		<cfset local.input = "16/01/2014 18:00" />
		<cfset local.dtm = g11n.dateTimeParse(dtm = local.input, mask = "#g11n.getDateMask('short')# HH:mm") />
		<cfset local.utc = g11n.castToUTC(dtm = local.dtm, tzid = "Canada/Eastern") />
		
		<cfset debug(local.input) />
		<cfset debug(local.dtm) />
		<cfset debug(local.utc) />
	
	</cffunction>
		
	
	<cffunction name="testCascCanadaDates" access="public" output="false" returntype="void">
		
		<cfset var res = "" />
		
		<cfset local.g11nCA = createObject("component", "model.g11n.g11n").init() />
		<cfset local.g11nUS = createObject("component", "model.g11n.g11n").init() />	
		
		<!--- mirror what is in ThemeController.doSetLocaleAndTimezoneToCurrentclub --->
		<cfset g11nCA.setDefaultLocale("en_CA") />
		<cfset g11nCA.setDefaultTimezone("Canada/Eastern") />
		<cfset debug(g11nCA.getDateMask('short')) />

		<cfset local.mask = g11nCA.getDateMask(mask = 'short') />
		<cfset res = g11nCA.dateTimeParse(dtm = "26/04/2014", mask = local.mask) />
		<cfset assertTrue(res EQ createDateTime(2014, 04, 26, 0, 0, 0), "The date was #res#, should have been Apr 26, 2014") />

		<cfset g11nUS.setDefaultLocale("en_US") />
		<cfset g11nUS.setDefaultTimezone("US/Pacific") />
		<cfset local.mask = g11nUS.getDateMask(mask = 'short') />
		<cfset res = g11nUS.dateTimeParse(dtm = "04/26/2014", mask = local.mask) />
		<cfset assertTrue(res EQ createDateTime(2014, 04, 26, 0, 0, 0), "The US date was #res#, should have been Apr 26, 2014") />
		<cfset debug(g11nUS.getDateMask('short')) />

		<cfset local.mask = g11nCA.getDateMask(mask = 'short') />
		<cfset res = g11nCA.dateTimeParse(dtm = "26/04/2014", mask = local.mask) />
		<cfset assertTrue(res EQ createDateTime(2014, 04, 26, 0, 0, 0), "The date after a new g11nUS was created was #res#, should have been Apr 26, 2014") />

	</cffunction>


	<cffunction name="testMissingDefaultLocaleThrowsException" access="public" output="false" returntype="void" mxunit:expectedException="Application">
		<cfset g11n.setDefaultLocale() />
	</cffunction>


	<cffunction name="testBlankDefaultLocaleThrowsException" access="public" output="false" returntype="void" mxunit:expectedException="Application">
		<cfset local.g11n = createObject("component", "model.g11n.g11n").init("en_CA") /><!--- default is en_US --->
		<cfset local.g11n.setDefaultLocale("") />
	</cffunction>


	<cffunction name="testDefaultLocaleWithEmptyInitIsEnUS" access="public" output="false" returntype="void">
		<cfset assertTrue(g11n.getDefaultLocale() EQ "en_US", "The default locale wasn't en_US, was: #g11n.getDefaultLocale()#") />
	</cffunction>


	<cffunction name="testDefaultLocaleWithExplicitBlankInitThrowsException" access="public" output="false" returntype="void" mxunit:expectedException="Application">
		<cfset local.g11n = createObject("component", "model.g11n.g11n").init("") />
		<cfset assertTrue(g11n.getDefaultLocale() EQ "", "While the g11n is inited with a blank default locale, we don't accept intentionally setting one, was: #g11n.getDefaultLocale()#") />
	</cffunction>


</cfcomponent>
