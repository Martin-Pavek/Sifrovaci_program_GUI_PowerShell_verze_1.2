cls

Remove-Variable delka_args,nazev_adresare_klice,nazev_adresare_klice_exist,nazev_klice, matrix, d_nazev_klice, nazev_adresare_klice -ErrorAction SilentlyContinue

$nazev_adresare_klice = "./keys"
# kontrola existuje li folder keys
$nazev_adresare_klice_exist = Test-Path $nazev_adresare_klice
if ($nazev_adresare_klice_exist -clike "False"){
Write-host -ForegroundColor yellow "byl vytvoren adresar $nazev_adresare_klice"
#Write-host -ForegroundColor yellow $pole_tipy[9]
$null = New-Item -Path $nazev_adresare_klice -ItemType Directory -Force
#echo "spust program znovu"
sleep 5
#exit
}

$delka_args = $args.length
#echo "celkem args $delka_args"
if ($delka_args -clike 0) {
Write-host -ForegroundColor red "zadej nazev klice jako args[0]"
Write-host -ForegroundColor red "konec programu"
sleep 5
Exit 1
}

$nazev_adresare_klice = "./keys" # adresar se soubory klicu

$nazev_adresare_klice_exist = Test-Path $nazev_adresare_klice
if ($nazev_adresare_klice_exist -clike "False"){
Write-host -ForegroundColor red "neni adresar $nazev_adresare_klice"
Write-host -ForegroundColor red "konec programu"
sleep 5
Exit 1
}

[string] $args_0 = $args[0]
#echo $args_0
#exit 1
$nazev_klice = $nazev_adresare_klice
$nazev_klice += "/"
$nazev_klice += $args_0
echo $nazev_klice
#echo $nazev_klice.GetTypeCode()
# ne delsi nazev klice nez 73 znaku
$d_args_0 = $args_0.Length
#echo $d_args_0.GetType()
#echo $d_args_0
if ( $d_args_0 -gt 73 ) {
Write-host -ForegroundColor red "delka nazvu klice presahuje 73 znaku, zkrate nazev klice a puste program znovu"
Write-host -ForegroundColor red "delka tohoto klice byla $d_args_0 znaku"
echo "konec programu"
sleep 10
Exit 1
}


if (-not (Test-Path $nazev_klice)) {
# soubor klice tohoto nazvu jeste nexistuje
}else{
Write-host -ForegroundColor red "soubor klice s timto nazvem jez existuje, zvolte jiny nazev a puste program znovu"
echo "konec programu"
sleep 5
Exit 1
}

# zmeneno 30.10.2024, rozsireny matrix pro verzu 1.2
# prazdny matrix 256 vodorovne a 126 svisle
$matrix=[System.Collections.ArrayList]::new()

for ( $aa = 0; $aa -le 125; $aa++ ) { # radku pod sebou
# delka 256 klicu na kazdym radku
$vv=@()
for ( $aa2 = 0; $aa2 -le 255; $aa2++ ) { # 0-255 celkem 256 bunek cislovanych v referenci v hexa
$vv += ""
}
$matrix.Add($vv) > $null # pozor musi bej odeslat do > null jinak pise radky cisla a zdrzuje to
# bez > $null vypise 0-125 radek
}
# konec 30.10.2024


# A=65, Z=90, a=97, z=122, 0=48, 1=49, 9=57
#$pole=@(48,57,65,90,97,122) # 0-9, A-Z, a-z 
$pole=@(97,122,65,90,49,57)
$d_pole=$pole.Length
$table=@()
for ( $aa = 0; $aa -le $d_pole -2; $aa++ ) {
$od = $pole[$aa]
$do = $pole[$aa+1]
for ( $bb = $od; $bb -le $do; $bb++ ) {
$z = [char] $bb
$table+=$z
}
$aa++
}
$table+="0"
# az sem novy 20.10.2024
#echo $table
#sleep 20

$delka_table = $table.Length #62 znaku ( na na radku ale znaky pro funkci Get-Random )
# 7812 klicu musi byt celkem
$poc = 1
$stream_writer_1 = [System.IO.StreamWriter]::new($nazev_klice)

for ( $aa = 0; $aa -le 125; $aa++){
for ( $bb = 0; $bb -le 255; $bb++){ # puvodene verze 1.1 bylo 10-71

$rnd = Get-Random -Minimum 0 -Maximum $delka_table # vybere nahodne jeden klic z pole $table
$matrix[$aa][$bb]=$table[$rnd]
<# zdrzovalo
$out = ""
$out = '$matrix'
$out += "["
$out += $aa
$out += "]["
$out += $bb
$out += ']="'
$out += $matrix[$aa][$bb]
$out +='"'
echo $out
#>
#$stream_writer_1.WriteLine("$out")
$out_2=$table[$rnd]
#echo $out_2
$stream_writer_1.WriteLine("$out_2")
$poc++
}
}

$stream_writer_1.close()

# kontrola nacteni klice
# spocita delku krajnich klicu nacteneho matrixu
$kraje_matrix=0
$kraje_matrix+=$matrix[0][0].Length
$kraje_matrix+=$matrix[0][255].Length
$kraje_matrix+=$matrix[125][0].Length
$kraje_matrix+=$matrix[125][255].Length
#echo $kraje_matrix

#$kraje_matrix=1 test
if ( $kraje_matrix -ne 4 ) { # musi bejt 4
Write-Host -ForegroundColor Red "chyba pri nacitani klice"
echo "konec programu"
sleep 3
exit 1
}

# levy horni roh, pravi horni roh, levy dolni roh a pravy dolni roh
echo ""
$hl_1=$matrix[0][0]+" . . . . . " + $matrix[0][255]
echo $hl_1
for ($i1 = 1; $i1 -le 2; $i1++){ 
echo ". . . . . . ." 
}
$hl_2=$matrix[125][0]+" . . . . . "+$matrix[125][255]
echo $hl_2
echo ""

sleep 3

