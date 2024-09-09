<?php

session_start();
define('cms', true);

$config = require "./../../config.php";
include_once( $config["basePath"] . "/systems/classes/Site.php" );

$Main = new Main();

if(isAjax() == true){

 $id_template = (int)$_POST["id_template"];
 $id_category = (int)$_POST["id_category"];

 if(!$settings['status_install_template']){

  $content = file_get_contents( $config["basePath"] . "/install_ub4/template.zip" );
 
 if( $content ){
    file_put_contents( $config["basePath"] . "/template.zip", $content );
    if( file_exists( $config["basePath"] . "/template.zip" ) ){

        $zip = new ZipArchive;
        if ($zip->open( $config["basePath"] . "/template.zip" ) === TRUE) {

            $zip->extractTo( $config["template_path"] );
            $zip->close();
            unlink( $config["basePath"] . "/template.zip" );

            $getThematics = file_get_contents( $config["basePath"] . "/install_ub4/thematics/" . $id_category . ".sql" );

            if( $getThematics ){

               file_put_contents($config["basePath"] . "/thematics.sql", $getThematics); 

               if( file_exists($config["basePath"] . "/thematics.sql") ){

                  update('drop table uni_category_board,uni_ads_filters,uni_ads_filters_alias,uni_ads_filters_items,uni_ads_filters_category');
                  table_insert($config["basePath"] . "/thematics.sql");
                  unlink($config["basePath"] . "/thematics.sql");
                  
                  $cache = new Cache();
                  $cache->reset();                  

               }

            }

            update("UPDATE uni_settings SET value=? WHERE name=?", array(1,'status_install_template'));

            echo json_encode( ["status" => true] );

        } else {
            echo json_encode( ["status" => false, "answer" => "Ошибка скачивания или распаковки шаблона."] );
        }

    }else{
        echo json_encode( ["status" => false, "answer" => "Ошибка скачивания или распаковки шаблона."] );
    }
 }else{
    echo json_encode( ["status" => false, "answer" => "Ошибка скачивания или распаковки шаблона."] );
 }

}

}

?>