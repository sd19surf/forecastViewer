<cfcomponent name="forecastViewer">

    
    <cffunction name="getCountryICAOS" access="remote" returnType="any">
        
    <cfargument name="countryCode" required="true" type="string" />
    <cfargument name="stateCode" required="false" type="string" />
        
    <cfif IsDefined('stateCode')>
        <cfreturn getCountry(countryCode,stateCode) />      
    <cfelse>
        <cfreturn getCountry(countryCode) />
    </cfif>    
    

    
    
    </cffunction>
    
    
    <cffunction name = "getCountry" access="private" returnType="any">
        
        <cfargument name="country" required="true" type="string" />
        <cfargument name="state" required="false" type="string" />
    
        <cfquery name="countryQ" datasource="MySQL">
        
            SELECT Station_name,Lat,Lon
            FROM web.station_list
            WHERE CTRY = '#country#'
            <cfif IsDefined('state')>AND STATE = '#state#'</cfif>
            AND END > '20170101' 
            ORDER BY ICAO
        
        
        </cfquery>

    <cfprocessingdirective suppresswhitespace="Yes"> 
        <cfoutput>
            #serializeJSON(countryQ,"struct")#
        </cfoutput>
    </cfprocessingdirective>

    <cfsetting enablecfoutputonly="No" showdebugoutput="No" />
    </cffunction>
    
    
    
    
    <cffunction name="getMember" access="private" returnType="any">
    
    <cfargument name="lastName" required="true" type="string" />
        
    
       <cfquery name="selectMember" datasource="MySQL">
        SELECT user_id,first_name,last_name,dob,email
        FROM inbox.deacon_roster
        WHERE LAST_NAME LIKE "#lastName#"
        
        </cfquery>   
        

    <cfoutput query="selectMember" group="LAST_NAME">
       <cfoutput> 
           <cfset obj = {
            "USER_ID" = USER_ID,
            "FIRST_NAME" = FIRST_NAME,
            "LAST_NAME" = LAST_NAME,
            "DOB" = DOB,
            "EMAIL" = EMAIL
         } />
        </cfoutput>
    </cfoutput>

    <cfprocessingdirective suppresswhitespace="Yes"> 
        <cfoutput>
            #serializeJSON(selectMember,"struct")#
        </cfoutput>
    </cfprocessingdirective>

    <cfsetting enablecfoutputonly="No" showdebugoutput="No" />
</cffunction>
        
    
    
    <cffunction name="insertMember" access="private" returnType="any">
    
    <cfargument name="firstName" required="true" type="string" />
    <cfargument name="lastName" required="true" type="string" />
    <cfargument name="DOB" required="true" type="date" />
    <cfargument name="email" required="true" type="string" />
        
    <cfset userID = CreateUUID() />
    
        
    <cfquery name="insertMember" datasource="MySQL" >
        INSERT INTO inbox.deacon_roster
        (user_id,first_name,last_name,dob,email)
        VALUES(
            <cfqueryparam cfsqltype="cf_sql_char" value="#userID#" />,
            <cfqueryparam cfsqltype="cf_sql_char" value="#firstName#" />,
            <cfqueryparam cfsqltype="cf_sql_char" value="#lastName#" />,
            <cfqueryparam cfsqltype="cf_sql_char" value="#DOB#" />,
            <cfqueryparam cfsqltype="cf_sql_char" value="#email#" />            
                )
    </cfquery>
    
        
    
    </cffunction>
    
    





</cfcomponent>