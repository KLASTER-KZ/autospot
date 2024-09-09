<?php
defined('unisitecms') or exit();

if( !$settings["demo_view"] ){
$getModules = "booking,marketplace,secure,auction,import,multilang";
update("UPDATE uni_settings SET value=? WHERE name=?", array($getModules,'available_functionality'));
}
?>