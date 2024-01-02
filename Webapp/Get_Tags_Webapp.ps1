$webapp = Get-AzWebApp

function tags{
    param([System.Array]$webapp)

    $keys = @()
    $values = @()

    foreach ($i in $webapp.Tags.Values){
        $tags = "" | Select value
        $tags.value = $i
        $values += $tags
    }

    foreach ($f in $webapp.Tags.Keys){
        $tags = "" | Select key
        $tags.key = $f
        $keys += $tags
   }

   $tags = "" | Select Application, StartDate, ServiceClass, BusinessUnit, Environment, Provider, Owner

   for($i=0; $i -lt $keys.Count; $i++){
  
      if ($keys[$i].key -eq "Application"){
         $tags.Application = $values[$i].value
      }
      if ($keys[$i].key -eq "StartDate"){
         $tags.StartDate = $values[$i].value
      }
      if ($keys[$i].key -eq "ServiceClass"){
         $tags.ServiceClass = $values[$i].value
      }
      if ($keys[$i].key -eq "BusinessUnit"){
         $tags.BusinessUnit = $values[$i].value
      }
      if ($keys[$i].key -eq "Environment"){
         $tags.Environment = $values[$i].value
      }
      if ($keys[$i].key -eq "Provider"){
         $tags.Provider = $values[$i].value
      }
      if ($keys[$i].key -eq "Owner"){
         $tags.Owner = $values[$i].value
      }
    }
  return $tags

}

foreach ( $azwebapp in $webapp) {
$tags = tags -webapp $azwebapp
        foreach ($aztags in $tags)  {
        $info = $aztags.Application + ";" + $aztags.BusinessUnit + ";" + $aztags.provider + ";"
        }
        $info += $azwebapp.name
        $info | Out-file "C:\webapp_devqa.csv" -Append
        $info
        
}
