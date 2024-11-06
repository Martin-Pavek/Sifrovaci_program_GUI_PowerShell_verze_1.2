cls

# Base 16 vypis znaku

echo "Base 16"
sleep 3

$pole_output=@()

for ($int = 0; $int -le 255; $int++){
$hexa = "{0:x}" -f $int
$hexa = $hexa.ToUpper()
if ( $hexa.Length -lt 2 ){
$hexa = "0" + $hexa
}
$out = [string] $int + " " + $hexa
echo $out
$pole_output+=$out
}

sleep 1
Set-Content -Path "R:\Base_16.txt" -Encoding ASCII -Value $pole_output
sleep 5

