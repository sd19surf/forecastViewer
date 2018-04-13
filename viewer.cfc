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
    
    
  <cffunction name="getStations" access="remote" returnType="any">
        
    <cfreturn createJSON()/>      
        
  </cffunction>  
    

    <cffunction name="createJSON" access="private" returnType="string">
    
    
        
    <cfquery name="getData" datasource="MySQL" >
        SELECT station_name, lat, lon, icao
        FROM web.station_list
        WHERE END > '20170101' AND CTRY = "IZ"
        ORDER BY ICAO
    </cfquery>
        
        
    <!---build a geoJSON file with all the output from the query --->
     <cfset counter = 1 />  
    <cfsavecontent variable="myJSON">
    <cfoutput>
[{
    "type": "FeatureCollection",
        "features": [
        
        <cfloop query="getData">
        {
          "type": "Feature",
          "properties": {
		  "icao": "#icao#",
		  "station name":"#station_name#"
            },
            "geometry": {
                "type": "Point",
                        "coordinates": [#lon#, #lat#]
            }
        }
       
      <cfif getData.recordcount neq counter>
          
            ,
        <cfelse>
            ]
        </cfif>
          <cfset counter++>
     </cfloop>
        }]
    </cfoutput>
    </cfsavecontent> 
        
    <cfprocessingdirective suppresswhitespace="Yes"> 
      <cfoutput> 
    <cfreturn #serializeJSON(myJSON,"struct")# />
      </cfoutput>
        </cfprocessingdirective> 
    </cffunction>



</cfcomponent>