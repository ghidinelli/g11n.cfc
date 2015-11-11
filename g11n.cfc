<cfcomponent displayname="Globalization Manager" hint="Request-level component that supports i18n, l10n and g11n requirements of MSR" output="false">

	<cfset variables.jTimeZone = createObject("java","java.util.TimeZone") />
	<cfset variables.utcTZ = createObject("java", "java.util.TimeZone").getTimeZone("UTC") />
	<cfset variables.jLocale = createObject("java","java.util.Locale") />
	<cfset variables.jCalendar = createObject("java", "java.util.GregorianCalendar") />
	<cfset variables.jDateSymbols = createObject("java","java.text.DateFormatSymbols") />
	<cfset variables.jDateFormat = createObject("java","java.text.DateFormat") />
	<cfset variables.jCurrency = createObject("java", "java.util.Currency") />
	<cfset variables.jNumberFormat = createObject("java", "java.text.NumberFormat") />

	<cfset variables.currentLocale = "" >
	<cfset variables.defaultLocale = "" />
	<cfset variables.defaultTZID = "" />

	<cffunction name="init" output="false" access="public" returntype="any">
		<cfargument name="locale" type="string" required="false" default="en_US" />
		<cfargument name="tzid" type="string" required="false" default="US/Pacific" />
		
		<cfset setDefaultLocale(arguments.locale) />
		<cfset setDefaultTimezone(arguments.tzid) />

		<cfreturn this />
	</cffunction>


	<cffunction name="getDefaultTimezone" output="false" access="public" returntype="any">
		<cfreturn variables.defaultTZID />	
	</cffunction>
	<cffunction name="setDefaultTimezone" output="false" access="public" returntype="any">
		<cfargument name="tzid" type="any" required="true" />
		<cfset variables.defaultTZID = arguments.tzid />
	</cffunction>
	<cffunction name="getTimezoneDisplayName" output="false" access="public" returntype="string">  
		<cfargument name="tzid" required="no" default="#getDefaultTimezone()#" />
		<cfargument name="dtm" type="any" required="false" default="#now()#" />
		<cfargument name="locale" type="string" required="false" default="#getDefaultLocale()#" />

		<cfset var thisTZ = variables.jTimeZone.getTimeZone(arguments.tzid) />
		<cfset var thisLocale = initLocale(arguments.locale) />
		<cfset var isDST = thisTZ.inDaylightTime(arguments.dtm) />

		<cfreturn variables.jTimezone.getTimezone(arguments.tzid).getDisplayName(isDST, variables.jTimezone.LONG, thisLocale) />
	</cffunction>
	<cffunction name="getTimezoneDisplayNameShort" output="false" access="public" returntype="string">
		<cfargument name="tzid" required="no" default="#getDefaultTimezone()#" />
		<cfargument name="dtm" type="any" required="false" default="#now()#" />
		<cfargument name="locale" type="string" required="false" default="#getDefaultLocale()#" />

		<cfset var thisTZ = variables.jTimeZone.getTimeZone(arguments.tzid) />
		<cfset var thisLocale = initLocale(arguments.locale) />
		<cfset var isDST = thisTZ.inDaylightTime(arguments.dtm) />

		<cfreturn variables.jTimezone.getTimezone(arguments.tzid).getDisplayName(isDST, variables.jTimezone.SHORT, thisLocale) />
	</cffunction>	
	<cffunction name="getAvailableTimezones" output="false" returntype="array" access="public">  
		<cfargument name="regexp" type="string" required="false" />

		<cfset var tz = variables.jTimezone.getAvailableIDs() />
		<cfset var len = "" />
		<cfset var ii = "" />

		<cfif structKeyExists(arguments, "regexp") AND len(trim(arguments.regexp))>
			<!--- the underlying java array type doesn't support removing, so we filter by type conversion --->
			<cfset tz = listToArray(arrayToList(tz)) />
			<cfset len = arrayLen(tz) />
			<cfloop from="#len#" to="1" index="ii" step="-1">
				<cfif NOT reFind(arguments.regexp, tz[ii], 1, false)>
					<cfset arrayDeleteAt(tz, ii) />
				</cfif>
			</cfloop>
		</cfif>

		<cfreturn tz />
	</cffunction>
	
	
	<cffunction name="getDefaultLocale" output="false" access="public" returntype="any">
		<cfreturn variables.defaultLocale />
	</cffunction>
	<cffunction name="setDefaultLocale" output="false" access="public" returntype="void">
		<cfargument name="locale" type="any" required="true" />

		<cfif NOT len(trim(arguments.locale))>
			<cfthrow message="Invalid Locale" detail="Where in the world are you Carmen San Diego?  A blank locale is not a valid answer.  We need something like en_US or en_GB" />
		</cfif>

		<!--- if we are already initialized to this locale, don't bother --->
		<cfif compare(variables.defaultLocale, arguments.locale)>
			<cfset variables.currentLocale = initLocale(arguments.locale) />
			<cfset variables.defaultLocale = arguments.locale />
	
			<cfif find("_", arguments.locale)>
				<cfset variables.defaultLocaleLanguage = listFirst(arguments.locale, "_") />
				<cfset variables.defaultLocaleVariant = listLast(arguments.locale, "_") />
			<cfelse>
				<cfset variables.defaultLocaleLanguage = arguments.locale />
				<cfset variables.defaultLocaleVariant = "" />
			</cfif>
		</cfif>
	</cffunction>

	
	<!--- returns UTC from a local date in given/default TZ, takes DST into account --->
	<cffunction name="castToUTC" output="false" access="public" returntype="any">
		<cfargument name="dtm" required="yes" type="any" />
		<cfargument name="tzid" required="no" default="#getDefaultTimezone()#" />

		<cfscript>
			var timezone = ''; var tYear = ''; var tMonth = ''; var tDay = ''; var tDOW = ''; var thisOffset = ''; 
		</cfscript>

		<cfif NOT isDate(arguments.dtm)><cfreturn "" /></cfif>

		<cfscript>
			timezone = jTimeZone.getTimeZone(arguments.tzid);
			tYear = javacast("int", Year(arguments.dtm));
			tMonth = javacast("int", month(arguments.dtm)-1); //java months are 0 based
			tDay = javacast("int", Day(dtm));
			tDOW = javacast("int", DayOfWeek(dtm));	//day of week
			thisOffset = (timezone.getOffset(1, tYear, tMonth, tDay, tDOW, 0) / 1000) * -1.00;
			return dateAdd("s", thisOffset, arguments.dtm);
		</cfscript>
	</cffunction>
	
	<!--- returns date in given TZ from given UTC date, takes DST into account --->
	<cffunction name="castFromUTC" output="false" access="public" returntype="any">  
		<cfargument name="dtm" required="yes" type="any" />
		<cfargument name="tzid" required="no" default="#getDefaultTimezone()#" />

		<cfscript>
			var timezone = ''; var tYear = ''; var tMonth = ''; var tDay = ''; var tDOW = ''; var thisOffset = ''; 
		</cfscript>

		<cfif NOT isDate(arguments.dtm)><cfreturn "" /></cfif>

		<cfscript>
			timezone = jTimeZone.getTimeZone(arguments.tzid);
			tYear = javacast("int", Year(arguments.dtm));
			tMonth = javacast("int", month(arguments.dtm)-1); //java months are 0 based
			tDay = javacast("int", Day(dtm));
			tDOW = javacast("int", DayOfWeek(dtm));	//day of week
			thisOffset = timezone.getOffset(1, tYear, tMonth, tDay, tDOW, 0) / 1000;
			return dateAdd("s", thisOffset, arguments.dtm);
		</cfscript>
	</cffunction>
	



	<cffunction name="formatDateTime" output="false" access="public" returntype="any" hint="will be replaced by CF10 native version">
		<cfargument name="dtm" type="any" required="true" />
		<cfargument name="mask" type="string" required="false" default="short" hint="supports Java SimpleDateFormat masks or one of short, medium, long, full" />
		<cfargument name="locale" type="string" required="false" default="#getDefaultLocale()#" />
		<cfargument name="tzid" type="any" required="false" default="#getDefaultTimezone()#" />
		
		<!--- format the date using java, incorporate the tz if needed --->
		<cfset var thisTZ = variables.jTimeZone.getTimeZone(arguments.tzid) />
		<cfset var thisLocale = initLocale(arguments.locale) />
		<cfset var thisCalendar = variables.jCalendar.init(thisTZ, thisLocale) />
		<cfset var formatter = "" />

		<cfif NOT isDate(arguments.dtm)><cfreturn "" /></cfif>

		<!--- allow the use of formatting strings like short/medium/long/full and convert to the localized patterns --->
		<cfif listFindNoCase("short,medium,long,full", arguments.mask)>
			<cfset arguments.mask = getDateTimeMask(arguments.mask, arguments.locale) />
		</cfif>
		
		<cfset formatter = variables.jDateFormat.getDateTimeInstance(javaCast("int", 0), javaCast("int", 0), thisLocale) />
		<cfset formatter.setCalendar(thisCalendar) />
		<cfset formatter.applyPattern(arguments.mask) />
		<cfreturn formatter.format(parseDateTime(arguments.dtm)) />
	</cffunction>
	
	
	<cffunction name="formatDate" output="false" access="public" returntype="any">
		<cfargument name="dtm" type="any" required="true" />
		<cfargument name="mask" type="string" required="false" default="short" hint="supports Java SimpleDateFormat masks or one of short, medium, long, full" />
		<cfargument name="locale" type="string" required="false" default="#getDefaultLocale()#" />
		<cfargument name="tzid" type="any" required="false" default="#getDefaultTimezone()#" />

		<!--- because it will pass an actual mask (not short/medium/etc), it should pass right thru into formatDateTime() --->
		<cfreturn formatDateTime(mask = getDateMask(argumentCollection = arguments), argumentCollection = arguments) />
	</cffunction>


	<cffunction name="formatDateISO" output="false" access="public" returntype="any">
		<cfargument name="dtm" type="any" required="true" />
		<cfargument name="tzid" type="any" required="false" default="#getDefaultTimezone()#" />

		<cfreturn formatDateTime(dtm = arguments.dtm, tzid = arguments.tzid, mask = "yyyy-MM-dd") />
	</cffunction>
	

	<cffunction name="formatDateTimeISO" output="false" access="public" returntype="any">
		<cfargument name="dtm" type="any" required="true" />
		<cfargument name="tzid" type="any" required="false" default="#getDefaultTimezone()#" />

		<cfreturn formatDateTime(dtm = arguments.dtm, tzid = arguments.tzid, mask = "yyyy-MM-dd HH:mm:ss") />
	</cffunction>


	<cffunction name="formatDateTimeISO8601" output="false" access="public" returntype="any">
		<cfargument name="dtm" type="any" required="true" />
		<cfargument name="tzid" type="any" required="false" default="#getDefaultTimezone()#" />

		<cfreturn formatDateTime(dtm = arguments.dtm, tzid = arguments.tzid, mask = "yyyy-MM-dd'T'HH:mm:ssZ") />
	</cffunction>


	<cffunction name="formatTime" output="false" access="public" returntype="any">
		<cfargument name="dtm" type="any" required="true" />
		<cfargument name="mask" type="string" required="false" default="short" hint="supports Java SimpleDateFormat masks or one of short, medium, long, full" />
		<cfargument name="locale" type="string" required="false" default="#getDefaultLocale()#" />
		<cfargument name="tzid" type="any" required="false" default="#getDefaultTimezone()#" />

		<!--- because it will pass an actual mask (not short/medium/etc), it should pass right thru into formatDateTime() --->
		<cfreturn formatDateTime(mask = getTimeMask(argumentCollection = arguments), argumentCollection = arguments) />
	</cffunction>
	

	<cffunction name="formatMonthDayLong" access="public" output="false" returntype="string" hint="formats a month/day or day/month string depending on passed locale">
		<cfargument name="dtm" required="yes" type="any" />	
		<cfargument name="locale" required="false" type="string" default="#getDefaultLocale()#" />
		<cfargument name="tzid" type="string" required="false" default="#getDefaultTimezone()#" />
		
		<cfif hasDayFirstFormat(arguments.locale)>
			<cfreturn formatDateTime(dtm = arguments.dtm, mask = "d MMMM", locale = arguments.locale, tzid = arguments.tzid) />
		<cfelse>
			<cfreturn formatDateTime(dtm = arguments.dtm, mask = "MMMM d", locale = arguments.locale, tzid = arguments.tzid) />
		</cfif>
	</cffunction>


	<cffunction name="formatMonthDayShort" access="public" output="false" returntype="string" hint="formats a month/day or day/month string depending on passed locale">
		<cfargument name="dtm" required="yes" type="any" />	
		<cfargument name="locale" required="false" type="string" default="#getDefaultLocale()#" />
		<cfargument name="tzid" type="string" required="false" default="#getDefaultTimezone()#" />
		
		<cfif hasDayFirstFormat(arguments.locale)>
			<cfreturn formatDateTime(dtm = arguments.dtm, mask = "d MMM", locale = arguments.locale, tzid = arguments.tzid) />
		<cfelse>
			<cfreturn formatDateTime(dtm = arguments.dtm, mask = "MMM d", locale = arguments.locale, tzid = arguments.tzid) />
		</cfif>
	</cffunction>


	<cffunction name="formatDateLongTimeShort" output="false" access="public" returntype="any">
		<cfargument name="dtm" type="any" required="true" />
		<cfargument name="locale" type="string" required="false" default="#getDefaultLocale()#" />
		<cfargument name="tzid" type="string" required="false" default="#getDefaultTimezone()#" />

		<!--- because it will pass an actual mask (not short/medium/etc), it should pass right thru into formatDateTime() --->
		<cfreturn formatDateTime(mask = getDateMask(mask = "long", argumentCollection = arguments) & " " & getTimeMask(mask = "short", argumentCollection = arguments), argumentCollection = arguments) />
	</cffunction>


	<cffunction name="formatDateMonthDayTime24" output="false" access="public" returntype="any">
		<cfargument name="dtm" type="any" required="true" />
		<cfargument name="locale" type="string" required="false" default="#getDefaultLocale()#" />
		<cfargument name="tzid" type="string" required="false" default="#getDefaultTimezone()#" />

		<cfif NOT isDate(arguments.dtm)><cfreturn "" /></cfif>

		<cfreturn formatMonthDayShort(dtm = arguments.dtm, locale = arguments.locale) & " " & formatTime(argumentCollection = arguments, mask = "H:mm") />
	</cffunction>


	<cffunction name="getDateTimeMask" access="public" output="false" returntype="string">
		<cfargument name="mask" type="string" required="false" default="short" hint="One of short, medium, long, full" />
		<cfargument name="locale" type="string" required="false" default="#getDefaultLocale()#" hint="ISO standard like en_US" />

		<cfset var thisLocale = initLocale(arguments.locale) />
		<cfset var fmt = decodeMask(arguments.mask) />

		<cfif NOT isNumeric(fmt)>
			<!--- this is an arbitrary simpledateformat mask --->
			<cfreturn fmt />
		<cfelse>
			<cfreturn variables.jDateFormat.getDateTimeInstance(javaCast("int", fmt), javaCast("int", fmt), thisLocale).toPattern() />
		</cfif>
	</cffunction>


	<cffunction name="getDateMask" access="public" output="false" returntype="string">
		<cfargument name="mask" type="string" required="false" default="short" hint="One of short, medium, long, full" />
		<cfargument name="locale" type="string" required="false" default="#getDefaultLocale()#" hint="ISO standard like en_US" />

		<cfset var thisLocale = initLocale(arguments.locale) />
		<cfset var fmt = decodeMask(arguments.mask) />

		<cfif NOT isNumeric(fmt)>
			<!--- this is an arbitrary simpledateformat mask --->
			<cfreturn fmt />
		<cfelse>
			<cfreturn variables.jDateFormat.getDateInstance(javaCast("int", fmt), thisLocale).toPattern() />
		</cfif>
	</cffunction>


	<cffunction name="getTimeMask" access="public" output="false" returntype="string">
		<cfargument name="mask" type="string" required="false" default="short" hint="One of short, medium, long, full" />
		<cfargument name="locale" type="string" required="false" default="#getDefaultLocale()#" hint="ISO standard like en_US" />

		<cfset var thisLocale = initLocale(arguments.locale) />
		<cfset var fmt = decodeMask(arguments.mask) />

		<cfif NOT isNumeric(fmt)>
			<!--- this is an arbitrary simpledateformat mask --->
			<cfreturn fmt />
		<cfelse>
			<cfreturn variables.jDateFormat.getTimeInstance(javacast("int", fmt), thisLocale).toPattern() />
		</cfif>
	</cffunction>

	
	<cffunction name="getDateAtMidnightInUTC" output="false" access="public" returntype="any" hint="takes a date '1/16/2010' and returns a TZ-adjusted midnight in UTC">
		<cfargument name="dtm" type="any" required="true" />
		<cfargument name="tzid" type="string" required="false" default="#getDefaultTimezone()#" />
	
		<cfreturn castToUTC(createDateTime(datePart("yyyy", dtm), datePart("m", dtm), datePart("d", dtm), 0, 0, 0), arguments.tzid) />
	</cffunction>


	<cffunction name="dateTimeParse" access="public" output="false" returntype="string"> 
		<cfargument name="dtm" required="true" type="string" />
		<cfargument name="locale" type="string" required="false" default="#getDefaultLocale()#" hint="ISO standard like en_US" />
		<cfargument name="mask" type="string" required="false" default="#getDateTimeMask(mask = 'short', locale = arguments.locale)#" hint="One of short, medium, long, full or a mask" />

		<cfset var sdf = createObject("java", "java.text.SimpleDateFormat").init(javaCast("string", arguments.mask)) />
		<cfreturn sdf.parse(arguments.dtm) />

		<!--- parse automatically converts to server time (UTC in my case) so we convert it back to local time --->
		<cfreturn parsedDate />
	</cffunction>


	<cffunction name="hasDayFirstFormat" access="public" output="false" returntype="boolean" hint="Return true if the locale formats short dates like D/M/YY vs. M/D/YY">
		<cfargument name="locale" type="string" required="false" default="#getDefaultLocale()#" />
		<cfreturn left(getDateMask("short", arguments.locale), 1) EQ "d" />
	</cffunction>
			
	
	<cffunction name="has24HourFormat" access="public" output="false" returntype="numeric" hint="determines if given locale use military sytle 24 hour timeformat & which format it uses returns 0 if not 24 hour timeformat, 1 if timeformat is 0-23 and 2 if 0-24">
		<cfargument name="locale" required="false" type="string" default="#getDefaultLocale()#" />
		
		<cfset var localTF = getTimeMask(format = "short", locale = arguments.locale) />

		<!--- CASE senstive --->
		<cfif find("H", localTF, 1)>
			<cfreturn 1 /> <!--- 0-23 --->
		<cfelseif find("k", localTF, 1)>	
			<cfreturn 2 /> <!--- 0-24 --->
		<cfelse>
			<cfreturn 0 /> <!--- not 24 hour format --->
		</cfif>

	</cffunction> 


	<cffunction name="hasDST" output="false" returntype="boolean" access="public">
		<cfargument name="tzid" required="no" default="#getDefaultTimezone()#" />
		<cfreturn variables.jTimeZone.getTimezone(arguments.tzid).useDaylightTime() />
	</cffunction>


	<cffunction name="getTimezoneOffset" access="public" output="false" returntype="numeric" hint="returns TZ offset between an arbitrary TZ and UTC">
		<cfargument name="tzid" type="string" required="false" default="#getDefaultTimezone()#" />
		<cfargument name="dtm" type="date" required="false" default="#now()#" />

		<cfscript>
			var timezone = jTimeZone.getTimeZone(arguments.tzid);
			var tYear = javacast("int", Year(dtm));
			var tMonth = javacast("int", month(dtm)-1); //java months are 0 based
			var tDay = javacast("int", Day(dtm));
			var tDOW = javacast("int", DayOfWeek(dtm));	//day of week
			var thisOffset = timezone.getOffset(1, tYear, tMonth, tDay, tDOW, 0);
			return thisOffset;
		</cfscript>		

	</cffunction> 
	
	
	<cffunction name="getNowInUTC" output="false" access="public" returntype="any">
		<cfreturn castToUTC(now(), "UTC") />
	</cffunction>
	

	<cffunction name="getNowInTZ" output="false" access="public" returntype="any">
		<cfargument name="tzid" type="string" required="false" default="#getDefaultTimezone()#" />
		<cfreturn castFromUTC(castToUTC(now(), "UTC"), arguments.tzid) />
	</cffunction>
	

	<cffunction name="initLocale" output="false" access="private" returntype="any">
		<cfargument name="thisLocale" type="any" required="true" hint="A locale string like en_US or blank meaning 'default'" />

		<cfif NOT len(trim(arguments.thisLocale)) OR arguments.thisLocale EQ getDefaultLocale()>
			<cfreturn variables.currentLocale />
		<cfelse>
			<cfif find("_", arguments.thisLocale)>
				<cfreturn variables.jLocale.init(listFirst(arguments.thisLocale, "_"), listLast(arguments.thisLocale,  "_")) />
			<cfelse>
				<cfreturn variables.jLocale.init(arguments.thisLocale) />
			</cfif>
		</cfif>
	</cffunction>


	<cffunction name="decodeMask" output="false" access="private" returntype="string">
		<cfargument name="mask" type="any" required="true" />

		<cfif isNumeric(mask)>
			<cfreturn mask />
		<cfelseif mask EQ "short">
			<cfreturn 3 />
		<cfelseif mask EQ "medium">
			<cfreturn 2 />
		<cfelseif mask EQ "long">
			<cfreturn 1 />
		<cfelseif mask EQ "full">
			<cfreturn 0 />
		<cfelse>
			<!--- assumes a manually crafted SimpleDateFormat mask --->
			<cfreturn mask />
		</cfif>
	
	</cffunction>
	

	<cffunction name="formatCurrency" output="false" access="public" returntype="any">
		<cfargument name="amount" type="numeric" required="true" />
		<cfargument name="locale" type="string" required="false" default="#getDefaultLocale()#" hint="ISO standard like en_US" />
		<cfargument name="symbol" type="boolean" required="true" default="true" />

		<cfset local.thisLocale = initLocale(arguments.locale) />

		<!--- we can optionally format the currency as a locale-specific DecimalFormat without symbols or parenthesis --->
		<cfif arguments.symbol>
			<cfset local.formatter = variables.jNumberFormat.getCurrencyInstance(thisLocale) />
		<cfelse>
			<cfset local.formatter = variables.jNumberFormat.getInstance(thisLocale) />
			<cfset local.currency = variables.jCurrency.getInstance(thisLocale) />
			<cfset formatter.setMinimumFractionDigits(currency.getDefaultFractionDigits()) />
			<cfset formatter.setMaximumFractionDigits(currency.getDefaultFractionDigits()) />
			<cfset formatter.setCurrency(local.currency) />
		</cfif>
		
		<cfreturn formatter.format(javaCast("double", arguments.amount)) />
		
	</cffunction>


	<cffunction name="getCurrencyCode" output="false" access="public" returntype="string" hint="Returns a value like USD, CAD, GBP">
		<cfargument name="locale" type="string" required="false" default="#getDefaultLocale()#" hint="ISO standard like en_US" />

		<cfset var thisLocale = initLocale(arguments.locale) />
		<cfset var currency = variables.jCurrency.getInstance(thisLocale) />
		<cfreturn currency.getCurrencyCode() />
	</cffunction>


	<cffunction name="getCurrencySymbol" output="false" access="public" returntype="string" hint="Returns a symbol character like $, £, etc">
		<cfargument name="locale" type="string" required="false" default="#getDefaultLocale()#" hint="ISO standard like en_US" />

		<cfset var thisLocale = initLocale(arguments.locale) />
		<cfset var currency = variables.jCurrency.getInstance(thisLocale) />
		<cfreturn currency.getSymbol(thisLocale) />
	</cffunction>
	

	<cffunction name="convertHistoricalTZ" output="false" access="public" returntype="any">
		<cfargument name="tzid" type="string" required="false" default="#getDefaultTimezone()#" />

		<!--- from https://raw.githubusercontent.com/eggert/tz/master/backward 
		
			# This file is in the public domain, so clarified as of
			# 2009-05-17 by Arthur David Olson.
			
			# This file provides links between current names for time zones
			# and their old names.  Many names changed in late 1993.
		
		--->
		<cfset local.strTZ = {"Africa/Asmera": "Africa/Asmara"
			,"Africa/Timbuktu": "Africa/Bamako"
			,"America/Argentina/ComodRivadavia": "America/Argentina/Catamarca"
			,"America/Atka": "America/Adak"
			,"America/Buenos_Aires": "America/Argentina/Buenos_Aires"
			,"America/Catamarca": "America/Argentina/Catamarca"
			,"America/Coral_Harbour": "America/Atikokan"
			,"America/Cordoba": "America/Argentina/Cordoba"
			,"America/Ensenada": "America/Tijuana"
			,"America/Fort_Wayne": "America/Indiana/Indianapolis"
			,"America/Indianapolis": "America/Indiana/Indianapolis"
			,"America/Jujuy": "America/Argentina/Jujuy"
			,"America/Knox_IN": "America/Indiana/Knox"
			,"America/Louisville": "America/Kentucky/Louisville"
			,"America/Mendoza": "America/Argentina/Mendoza"
			,"America/Porto_Acre": "America/Rio_Branco"
			,"America/Rosario": "America/Argentina/Cordoba"
			,"America/Shiprock": "America/Denver"
			,"America/Virgin": "America/Port_of_Spain"
			,"Antarctica/South_Pole": "Pacific/Auckland"
			,"Asia/Ashkhabad": "Asia/Ashgabat"
			,"Asia/Calcutta": "Asia/Kolkata"
			,"Asia/Chungking": "Asia/Chongqing"
			,"Asia/Dacca": "Asia/Dhaka"
			,"Asia/Katmandu": "Asia/Kathmandu"
			,"Asia/Macao": "Asia/Macau"
			,"Asia/Saigon": "Asia/Ho_Chi_Minh"
			,"Asia/Tel_Aviv": "Asia/Jerusalem"
			,"Asia/Thimbu": "Asia/Thimphu"
			,"Asia/Ujung_Pandang": "Asia/Makassar"
			,"Asia/Ulan_Bator": "Asia/Ulaanbaatar"
			,"Atlantic/Faeroe": "Atlantic/Faroe"
			,"Atlantic/Jan_Mayen": "Europe/Oslo"
			,"Australia/ACT": "Australia/Sydney"
			,"Australia/Canberra": "Australia/Sydney"
			,"Australia/LHI": "Australia/Lord_Howe"
			,"Australia/NSW": "Australia/Sydney"
			,"Australia/North": "Australia/Darwin"
			,"Australia/Queensland": "Australia/Brisbane"
			,"Australia/South": "Australia/Adelaide"
			,"Australia/Tasmania": "Australia/Hobart"
			,"Australia/Victoria": "Australia/Melbourne"
			,"Australia/West": "Australia/Perth"
			,"Australia/Yancowinna": "Australia/Broken_Hill"
			,"Brazil/Acre": "America/Rio_Branco"
			,"Brazil/DeNoronha": "America/Noronha"
			,"Brazil/East": "America/Sao_Paulo"
			,"Brazil/West": "America/Manaus"
			,"Canada/Atlantic": "America/Halifax"
			,"Canada/Central": "America/Winnipeg"
			,"Canada/East-Saskatchewan": "America/Regina"
			,"Canada/Eastern": "America/Toronto"
			,"Canada/Mountain": "America/Edmonton"
			,"Canada/Newfoundland": "America/St_Johns"
			,"Canada/Pacific": "America/Vancouver"
			,"Canada/Saskatchewan": "America/Regina"
			,"Canada/Yukon": "America/Whitehorse"
			,"Chile/Continental": "America/Santiago"
			,"Chile/EasterIsland": "Pacific/Easter"
			,"Cuba": "America/Havana"
			,"Egypt": "Africa/Cairo"
			,"Eire": "Europe/Dublin"
			,"Europe/Belfast": "Europe/London"
			,"Europe/Tiraspol": "Europe/Chisinau"
			,"GB": "Europe/London"
			,"GB-Eire": "Europe/London"
			,"GMT+0": "Etc/GMT"
			,"GMT-0": "Etc/GMT"
			,"GMT0": "Etc/GMT"
			,"Greenwich": "Etc/GMT"
			,"Hongkong": "Asia/Hong_Kong"
			,"Iceland": "Atlantic/Reykjavik"
			,"Iran": "Asia/Tehran"
			,"Israel": "Asia/Jerusalem"
			,"Jamaica": "America/Jamaica"
			,"Japan": "Asia/Tokyo"
			,"Kwajalein": "Pacific/Kwajalein"
			,"Libya": "Africa/Tripoli"
			,"Mexico/BajaNorte": "America/Tijuana"
			,"Mexico/BajaSur": "America/Mazatlan"
			,"Mexico/General": "America/Mexico_City"
			,"NZ": "Pacific/Auckland"
			,"NZ-CHAT": "Pacific/Chatham"
			,"Navajo": "America/Denver"
			,"PRC": "Asia/Shanghai"
			,"Pacific/Ponape": "Pacific/Pohnpei"
			,"Pacific/Samoa": "Pacific/Pago_Pago"
			,"Pacific/Truk": "Pacific/Chuuk"
			,"Pacific/Yap": "Pacific/Chuuk"
			,"Poland": "Europe/Warsaw"
			,"Portugal": "Europe/Lisbon"
			,"ROC": "Asia/Taipei"
			,"ROK": "Asia/Seoul"
			,"Singapore": "Asia/Singapore"
			,"Turkey": "Europe/Istanbul"
			,"UCT": "Etc/UCT"
			,"US/Alaska": "America/Anchorage"
			,"US/Aleutian": "America/Adak"
			,"US/Arizona": "America/Phoenix"
			,"US/Central": "America/Chicago"
			,"US/East-Indiana": "America/Indiana/Indianapolis"
			,"US/Eastern": "America/New_York"
			,"US/Hawaii": "Pacific/Honolulu"
			,"US/Indiana-Starke": "America/Indiana/Knox"
			,"US/Michigan": "America/Detroit"
			,"US/Mountain": "America/Denver"
			,"US/Pacific": "America/Los_Angeles"
			,"US/Samoa": "Pacific/Pago_Pago"
			,"UTC": "Etc/UTC"
			,"Universal": "Etc/UTC"
			,"W-SU": "Europe/Moscow"
			,"Zulu": "Etc/UTC" } />
	
		<cfreturn structKeyExists(local.strTZ, arguments.tzid) ? local.strTZ[arguments.tzid] : arguments.tzid />
	</cffunction>

</cfcomponent>
