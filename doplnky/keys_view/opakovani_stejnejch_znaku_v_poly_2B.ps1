cls
# poror toho pocita i opkovani stejneho znaku v jednom sloupci

Remove-Variable pole, x, item, x, qq, suma -ErrorAction SilentlyContinue

$str="1qDXd2mx9xwLBQCehgHONcukGtLSWkXB0L8VfbAlMZ6dRlvz7aztN20yLvv2U8GB6VDgxIgf3weHsaOVtiWS376m0I2LUzCwfjxvjCZYUBrABPDWSFt4P8VDLTSLLDmV3F9Y1R2FQZEKbVHUHtBR0LxRMDGJN4XIZUnqj74uEabGK7yNt2F3XCRN1WeOyAO6blsNykUQ2gmdY9TBF817bolOSIzxlvxWgYTMh4Z88Lo2ByISuKPP1wZ0YTqOER3Y"
# novy_klic_1 radek 1

echo $str.Length
$pole = $str.ToCharArray()

$x=@()
$x += $pole | Group -CaseSensitive | Where{$_.Count -gt 1} | Select-Object Count
# paklize nejni prepinac "-CaseSensitive" povazuje napr. "d" a "D" za stejnej znak !
# takze default je CaseSensitive  off
echo $pole | Group -CaseSensitive #| Select-Object Count, Group
echo $x.Length

$suma=0
if ( $x.Length -ne 0 ) {
foreach ( $item in $x ) {
#echo $item
[string] $qq = $item
echo $qq"<"
$suma += [int32] $qq.Substring(8,$qq.Length -9)
}
}

echo $suma"<--stejnejch znaku v poly celkem"
echo "I Z OPAKOVANIM stejnych znaku v jednom slopci"
sleep 10

