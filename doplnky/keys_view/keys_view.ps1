﻿cls
Remove-Variable matrix,volba_klice,nazev_klice -ErrorAction SilentlyContinue

# tady editovat sestu do slaozky "keys" podle svoji situace
#$cesta_do_adresare_keys="C:\Users\DELL\Documents\ps1\_GUI\Sifrovaci_program_GUI_PowerShell_verze_1.2\keys\" # absolutni cesta
$cesta_do_adresare_keys = "..\..\keys\" # relativni cesta, odsud ( soubory museji zustat na svem miste kde sou ted,jinak upravit )
#

echo "zadej nazev klice z adresare"
echo "$cesta_do_adresare_keys"
echo "napr. novy_klic_1"
echo "?"
[string] $volba_klice = Read-Host
echo $volba_klice
$nazev_klice = $cesta_do_adresare_keys + $volba_klice
echo $nazev_klice

# test jestli existuje zvoleny soubor

$file_exist_test = Test-Path $nazev_klice
if ($file_exist_test -clike "False"){
Write-host -ForegroundColor red "nenalezen soubor $nazev_klice"
echo "konec programu"
sleep 5
exit
}

$matrix=[System.Collections.ArrayList]::new()

for ( $aa = 0; $aa -le 125; $aa++ ) { # 0-125 radek pod sebou
#delka 256
$vv=@()
for ( $bb = 0; $bb -le 255; $bb++ ) { # 0-72 je radek
$vv+=""
}
$matrix.Add($vv) > $null
# bez > $null vypise 0-125 radek
}

$stream_reader_1 = [System.IO.StreamReader]::new($nazev_klice)

# zde nacita klic to matice
for ( $dd = 0; $dd -le 125; $dd++){
for ( $ee = 0; $ee -le 255; $ee++){ # stary v1.1 bylo 10-71
$line_read = ($stream_reader_1.ReadLine()) 
<# zdrzovalo
$in = ""
$in = '$matrix'
$in += "["
$in += $dd
$in += "]["
$in += $ee
$in += ']="'
$in += $matrix[$dd][$ee]
$in += $line_read
$in +='"'
echo $in
#>
$matrix[$dd][$ee]=$line_read
}
}
$stream_reader_1.close()
sleep 3

# matrix do souboru

$pole_out=@()

# easter egg ( velikonocni vajicko ) 01.11.2024
if (( $volba_klice -clike "dexovo" ) -or ( $volba_klice -clike "fery" )) {
echo "ATARI 8-BIT FOREVER !"
$pole_out+="ATARI 8-BIT FOREVER !"
}
#

Write-host -ForegroundColor Yellow "keys view v1.2 $volba_klice"
$pole_out+="keys view v1.2 - $volba_klice"
#echo ""
$pole_out+=""

$h0 = "     0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
$h1 = "     0000000000111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999"
$h2 = "     0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
$h3 = "     ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
$h0 += "1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
$h1 += "0000000000111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999"
$h2 += "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
$h3 += "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
$h0 += "22222222222222222222222222222222222222222222222222222222"
$h1 += "00000000001111111111222222222233333333334444444444555555"
$h2 += "01234567890123456789012345678901234567890123456789012345"
$h3 += "||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
#         zatim takto ^^^ pozdeji mozna jinak
<# neveslo se vodorovne na obrazovku (zalamovany radky uz) 
echo $h0
echo $h1
echo $h2
echo $h3
#>

$pole_out+=$h0
$pole_out+=$h1
$pole_out+=$h2
$pole_out+=$h3

$poc_1=1
$jeden_radek="000--"
for ( $ff = 0; $ff -le 125; $ff++){ # 126 znaku hesla, radky 0-125
for ( $gg = 0; $gg -le 255; $gg++){ # delka kazdeho radku je 256 znaku ( 0-255 v1.2 )
$jeden_radek+=$matrix[$ff][$gg]
}
#echo $jeden_radek
$pole_out+=$jeden_radek

if ( $poc_1 -lt 10 ) { 
$jeden_radek="00"
$jeden_radek+=[string]$poc_1
$jeden_radek+="--"
}
elseif ( $poc_1 -gt 9 -and $poc_1 -lt 100 ) {
$jeden_radek="0"
$jeden_radek+=[string]$poc_1
$jeden_radek+="--"
}
elseif ( $poc_1 -gt 99 ) {
$jeden_radek=""
$jeden_radek+=[string]$poc_1
$jeden_radek+="--"
}

$poc_1++
}

<#
echo $h3
echo $h0
echo $h1
echo $h2
#>

$pole_out+=$h3
$pole_out+=$h0
$pole_out+=$h1
$pole_out+=$h2

#echo ""
# ulozeni vystupu do souboru
echo "ulozeno do souboru:"
$out_file_name="keys_view-"+$volba_klice+".txt"
Write-host -ForegroundColor Cyan $out_file_name

Set-Content -Path $out_file_name -Encoding ASCII -Value $pole_out

# ceka v pauze na ukonceni
sleep 10

