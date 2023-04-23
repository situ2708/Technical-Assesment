function Get-NestedObjectValue($object, $key) {
    $keys = $key -split '/'
    $val = $object
    foreach ($a in $keys) {
        if ($val.$a) {
            $val = $val.$a
        }
        else {
            return $null
        }
    }
    return $val
}
