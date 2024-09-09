<?php
defined('unisitecms') or exit();

if($settings['delivery_api_key']){

update('TRUNCATE TABLE `uni_boxberry_cities`');

$getCities = json_decode(file_get_contents('https://api.boxberry.ru/json.php?token='.decrypt($settings['delivery_api_key']).'&method=ListCities&CountryCode=643'), true);

if($getCities){

    foreach ($getCities as $value) {
        $getCity = findOne('uni_city', 'city_name=?', [$value['Name']]);
        if($getCity){
            insert("INSERT INTO uni_boxberry_cities(boxberry_cities_name,boxberry_cities_code,boxberry_cities_region,boxberry_cities_lat,boxberry_cities_lon)VALUES(?,?,?,?,?)", [$value['Name'],$value['Code'],$value['Region'],$getCity['city_lat'],$getCity['city_lng']]);
        }
    }

}

update('TRUNCATE TABLE `uni_boxberry_points`');

$getPoints = json_decode(file_get_contents('https://api.boxberry.ru/json.php?token='.decrypt($settings['delivery_api_key']).'&method=ListPoints'), true);

if($getPoints){

    foreach ($getPoints as $value) {
        $latlon = explode(',', $value['GPS']);
        insert("INSERT INTO uni_boxberry_points(boxberry_points_code,boxberry_points_address,boxberry_points_phone,boxberry_points_workshedule,boxberry_points_gps,boxberry_points_city_code,boxberry_points_lat,boxberry_points_lon)VALUES(?,?,?,?,?,?,?,?)", [$value['Code'],$value['Address'],$value['Phone'],$value['WorkShedule'],$value['GPS'],$value['CityCode'],$latlon[0],$latlon[1]]);
    }

}

$getPoints = json_decode(file_get_contents('https://api.boxberry.ru/json.php?token='.decrypt($settings['delivery_api_key']).'&method=PointsForParcels'), true);

if($getPoints){

    foreach ($getPoints as $value) {
        update('update uni_boxberry_points set boxberry_points_send=? where boxberry_points_code=?', [1,$value['Code']]);
    }

}

}
?>