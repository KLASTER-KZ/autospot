<?php

define('cms', true);
session_start();

$config = require "../../../../../config.php";
include_once( $config["basePath"] . "/systems/classes/Site.php");
include_once( $config["basePath"] . "/" . $config["folder_admin"] . "/lang/" . $settings["lang_admin_default"].".php" );

if( !(new Admin())->accessAdmin($_SESSION['cp_control_city']) ){
   $_SESSION["CheckMessage"]["warning"] = "Ограничение прав доступа!";
   exit;
}

if(isAjax() == true){

$Cache = new Cache();

$error = [];

$id = intval($_POST["id"]);
$name = clear($_POST["name"]);

for ($i = 1; $i <= 10; $i++) {
${"name_" . $i} = clear($_POST["name_" . $i]);
}

$alias = translite($_POST["alias"]);
$desc = clear($_POST["desc"]);

$lat = clear($_POST["lat"]);
$lng = clear($_POST["lng"]);

if(!$_POST["alias"]){
	$alias = translite($_POST["name"]);
}

if(!$name){
	$error[] = "Пожалуйста, укажите название";
}

if(!$lat){
	$error[] = "Пожалуйста, укажите широту";
}

if(!$lng){
	$error[] = "Пожалуйста, укажите долготу";
}

if(count($error) == 0){

update("UPDATE uni_city SET city_name=?,name_1=?,name_2=?,name_3=?,name_4=?,name_5=?,name_6=?,name_7=?,name_8=?,name_9=?,name_10=?, city_alias = ?, city_desc=?, city_declination=?, city_lat=?, city_lng=? WHERE city_id=?", array($name,$name_1, $name_2,$name_3,$name_4,$name_5,$name_6,$name_7,$name_8,$name_9,$name_10,$alias,$desc,clear($_POST["declination"]),$lat,$lng,$id));  

$_SESSION["CheckMessage"]["success"] = "Действие успешно выполнено!";
echo true;
$Cache->update( "cityDefault" );

}else{
	$_SESSION["CheckMessage"]["warning"] = implode("<br/>", $error);
}


}  
?>