#Zu prüfendes Verzeichnis oder Volume:
$Verzeichnis = „c:“

#Pfad zur CSV-Datei für den Export:
$CSV = „c:\users\$env:username\desktop\export.txt“

#Warnstufe für Pfade über folgende Zeichenlaenge in eine .cSV-Datei schreiben
$Warninglevel = „250“

#———————————————–
cls
„Pfad;Laenge“ | set-content „$CSV“
$dirlist = Get-ChildItem „$Verzeichnis“ -recurse | foreach {$_.Fullname}
foreach ($dir in $dirlist)
{
$a = $dir | Measure-Object  -Character
$length = $a.characters

if ($length -gt $Warninglevel)
{
„$dir;$length“ | add-content „$CSV“
}
}
$sort = import-csv „$CSV“  -delimiter „;“ | Sort-Object -Property Laenge -Descending
„“ | set-content „$CSV“
$sort | export-csv „$CSV“ -delimiter „;“ –NoTypeInformation
