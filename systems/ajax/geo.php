<?php

session_start();
define('cms', true);

$config = require "./../../config.php";
include_once( $config["basePath"] . "/systems/classes/Site.php" );

verify_csrf_token();

$Ads = new Ads();
$Main = new Main();
$Geo = new Geo();
$ULang = new ULang();

if(isAjax() == true){


    if($_POST["action"] == "change-city"){

		$Geo->set( array( "city_id" => intval($_POST["city_id"]) , "region_id" => intval($_POST["region_id"]) , "country_id" => intval($_POST["country_id"]), "action" => "modal" ) );

    }

    if($_POST["action"] == "search-city-region"){
        
        $query = clearSearch( $_POST["q"] );

		if($query && mb_strlen($query, "UTF-8") >= 2 ){

			$results = $Geo->search($query);

		    if(count($results)){

		       foreach($results AS $data){
                     
                     if($data["region_name"]){
			       	 $list["region"][$data["region_name"]] = '
			            <div class="item-city" data-name="'.$data["region_name"].'" id-country="0"  id-city="0"  id-region="'.$data["region_id"].'" >
			            	<strong>'.$ULang->t( $data["region_name"], [ "table" => "geo", "field" => "geo_name" ] ).'</strong>
			            </div>
			       	 ';
			       	 }
                     
                     if($data["city_name"]){
			       	 $list["city"][] = '
			            <div class="item-city"  data-name="'.$data["city_name"].'" id-country="0" id-region="0" id-city="'.$data["city_id"].'" >
			            	<strong>'.$ULang->t( $data["city_name"], [ "table" => "geo", "field" => "geo_name" ] ).'</strong> <span class="span-subtitle" >'.$ULang->t( $data["region_name"], [ "table" => "geo", "field" => "geo_name" ] ).', '.$ULang->t( $data["country_name"], [ "table" => "geo", "field" => "geo_name" ] ).'</span>
			            </div>
			       	 ';
			       	 }
			       	 
			       	 if($data["country_name"]){
			       	 $list["country"][$data["country_name"]] = '
			            <div class="item-city" data-name="'.$data["country_name"].'"  id-city="0"  id-region="0" id-country="'.$data["country_id"].'" >
			            	<strong>'.$ULang->t( $data["country_name"], [ "table" => "geo", "field" => "geo_name" ] ).'</strong>
			            </div>
			       	 ';
			       	 }

		       }


		       if($list["region"]) echo implode("", $list["region"]);
		       echo implode("", $list["city"]);
		       if($list["country"]) echo implode("", $list["country"]);

   

		    }else{
		    	echo false;
		    }

		}else{
			echo false;
		}       

    }

    if($_POST["action"] == "search-cities-city"){
        
        $query = clearSearch( $_POST["q"] );

		if($query && mb_strlen($query, "UTF-8") >= 2 ){

			if($settings["region_id"]) $where_region = "and `uni_region`.region_id = '{$settings["region_id"]}'"; else $where_region = "";
            
		    $get = getAll("SELECT *, uni_city.name_1, uni_city.name_2, uni_city.name_3, uni_city.name_4, uni_city.name_5, uni_city.name_6, uni_city.name_7, uni_city.name_8, uni_city.name_9, uni_city.name_10
              FROM uni_city 
              INNER JOIN `uni_country` ON `uni_country`.country_id = `uni_city`.country_id 
              INNER JOIN `uni_region` ON `uni_region`.region_id = `uni_city`.region_id 
              WHERE `uni_country`.country_status = '1' $where_region 
              AND (`uni_city`.city_name LIKE '%".$query."%' 
              OR `uni_city`.name_1 LIKE '%".$query."%'
              OR `uni_city`.name_2 LIKE '%".$query."%'
              OR `uni_city`.name_3 LIKE '%".$query."%'
              OR `uni_city`.name_4 LIKE '%".$query."%'
              OR `uni_city`.name_5 LIKE '%".$query."%'
              OR `uni_city`.name_6 LIKE '%".$query."%'
              OR `uni_city`.name_7 LIKE '%".$query."%'
              OR `uni_city`.name_8 LIKE '%".$query."%'
              OR `uni_city`.name_9 LIKE '%".$query."%'
              OR `uni_city`.name_10 LIKE '%".$query."%') 
              ORDER BY city_name ASC");
			  
		    if($get){

	           ?>
	           <div class="row" >
	           <?php

			       foreach($get AS $data){

                     if($_SESSION["temp_change_category"]["category_board_chain"]){
                        $alias = _link( $data["city_alias"] . "/" . $_SESSION["temp_change_category"]["category_board_chain"] );
                     }else{
                        $alias = _link( $data["city_alias"] );
                     }

                     ?>
                     <div class="col-12" >
	                     <div class="row" >
			                  <div class="col-lg-3 col-md-3 col-sm-4 col-12" >
			                      <a href="<?php echo $alias; ?>" ><?php echo $ULang->t( $data["city_name"], [ "table" => "geo", "field" => "geo_name" ] ); ?></a>
			                  </div> 
		                 </div> 
	                 </div>                   
                     <?php

			       }   

               ?>
               </div>                   
               <?php

		    }

		}else{

		   if($settings["region_id"]) $where_region = "and `uni_region`.region_id = '{$settings["region_id"]}'"; else $where_region = "";

           if( $_SESSION["geo"]["data"] ){
               $country_alias = $_SESSION["geo"]["data"]["country_alias"];
           }else{
               $country_alias = $settings["country_default"];
           }

		   $getCities = getAll("SELECT * FROM uni_city INNER JOIN `uni_country` ON `uni_country`.country_id = `uni_city`.country_id WHERE `uni_country`.country_status = '1' and `uni_country`.country_alias='".$country_alias."' and `uni_city`.city_default = '1' $where_region order by city_count_view desc");

	       if(count($getCities)){

	            ?>
	            <div class="row" >
	            <?php

	            foreach ($getCities as $key => $value) {

	                  $value["city_name"] = $ULang->t( $value["city_name"], [ "table" => "geo", "field" => "geo_name" ] );
	                  
	                  if($_SESSION["temp_change_category"]["category_board_chain"]){
	                     $alias = _link( $value["city_alias"] . "/" . $_SESSION["temp_change_category"]["category_board_chain"] );
	                  }else{
	                     $alias = _link( $value["city_alias"] );
	                  }

	                  ?>
	                  <div class="col-lg-3 col-md-3 col-sm-4 col-12" >
	                      <a href="<?php echo $alias; ?>" ><?php echo $value["city_name"]; ?></a>
	                  </div>
	                  <?php

	            }

	            ?>
	            </div>                   
	            <?php

	       }		   

		}       

    }

    if($_POST["action"] == "search-city"){
        
        $query = clearSearch( $_POST["q"] );

		if($query && mb_strlen($query, "UTF-8") >= 2 ){

			if($settings["region_id"]) $where_region = "and `uni_region`.region_id = '{$settings["region_id"]}'"; else $where_region = "";
            
		    $get = getAll("SELECT *, uni_city.name_1, uni_city.name_2, uni_city.name_3, uni_city.name_4, uni_city.name_5, uni_city.name_6, uni_city.name_7, uni_city.name_8, uni_city.name_9, uni_city.name_10
              FROM uni_city 
              INNER JOIN `uni_country` ON `uni_country`.country_id = `uni_city`.country_id 
              INNER JOIN `uni_region` ON `uni_region`.region_id = `uni_city`.region_id 
              WHERE `uni_country`.country_status = '1' $where_region 
              AND (`uni_city`.city_name LIKE '%".$query."%' 
              OR `uni_city`.name_1 LIKE '%".$query."%'
              OR `uni_city`.name_2 LIKE '%".$query."%'
              OR `uni_city`.name_3 LIKE '%".$query."%'
              OR `uni_city`.name_4 LIKE '%".$query."%'
              OR `uni_city`.name_5 LIKE '%".$query."%'
              OR `uni_city`.name_6 LIKE '%".$query."%'
              OR `uni_city`.name_7 LIKE '%".$query."%'
              OR `uni_city`.name_8 LIKE '%".$query."%'
              OR `uni_city`.name_9 LIKE '%".$query."%'
              OR `uni_city`.name_10 LIKE '%".$query."%') 
              ORDER BY city_name ASC");
			  
		    if($get){

		       foreach($get AS $data){

		        if($data["region_name"] == $data["country_name"]){

			          ?>
			            <div class="item-city" data-city="<?php echo $ULang->t( $data["city_name"], [ "table" => "geo", "field" => "geo_name" ] ); ?>"  id-city="<?php echo $data["city_id"]; ?>" >
			            	<strong><?php echo $ULang->t( $data["city_name"], [ "table" => "geo", "field" => "geo_name" ] ); ?></strong> <span class="span-subtitle" ><?php echo $ULang->t( $data["country_name"], [ "table" => "geo", "field" => "geo_name" ] ); ?></span>
			            </div>
			          <?php

		        }else{

			          ?>
			            <div class="item-city"  data-city="<?php echo $ULang->t( $data["city_name"], [ "table" => "geo", "field" => "geo_name" ] ); ?>"  id-city="<?php echo $data["city_id"]; ?>" >
			            	<strong><?php echo $ULang->t( $data["city_name"], [ "table" => "geo", "field" => "geo_name" ] ); ?></strong> <span class="span-subtitle" ><?php echo $ULang->t( $data["region_name"], [ "table" => "geo", "field" => "geo_name" ] ); ?>, <?php echo $ULang->t( $data["country_name"], [ "table" => "geo", "field" => "geo_name" ] ); ?></span>
			            </div>
			          <?php

		        }


		       }   

		    }else{
		    	echo false;
		    }

		}else{
			echo false;
		}       

    }

    if($_POST["action"] == "city-options"){

       $id = (int)$_POST["id"];

       $get_metro = getOne("SELECT count(*) as total FROM uni_metro WHERE city_id = '$id'")["total"];
       $get_area = getAll("SELECT * FROM uni_city_area WHERE city_area_id_city = '$id' order by city_area_name asc");

       if($get_area){

       	  foreach ($get_area as $key => $value) {
       	  	
             $items .= '<label> <input type="radio" name="area[]" value="'.$value["city_area_id"].'" > <span>'.$ULang->t( $value["city_area_name"], [ "table" => "uni_city_area", "field" => "city_area_name" ] ).'</span> <i class="la la-check"></i> </label>';

       	  }

       	  $data .= '
            <div class="ads-create-main-data-box-item" >      
            <p class="ads-create-subtitle" >'.$ULang->t("Район").'</p> 

	       	     <div class="ads-create-main-data-city-options-area" >
	                <div class="uni-select" data-status="0" >

		                 <div class="uni-select-name" data-name="'.$ULang->t("Не выбрано").'" > <span>'.$ULang->t("Не выбрано").'</span> <i class="la la-angle-down"></i> </div>
		                 <div class="uni-select-list" >
		                     '.$items.'
		                 </div>
	                
	                </div>
	             </div>

            </div>
       	  ';
       }

       if($get_metro){

       	  $data .= '
            <div class="ads-create-main-data-box-item" >      
            <p class="ads-create-subtitle" >'.$ULang->t("Ближайшее метро").'</p>

	       	     <div class="ads-create-main-data-city-options-metro" >
		            <div class="container-custom-search" >
		              <input type="text" class="ads-create-input action-input-search-metro" placeholder="'.$ULang->t("Начните вводить станции, а потом выберите ее из списка").'" >
		              <div class="custom-results SearchMetroResults" ></div>
		            </div>

		            <div class="ads-container-metro-station" ></div>
		         </div>

	        </div>
       	  ';

       }
       
       echo $data; 

    }

    if($_POST["action"] == "search_metro"){

    	$search = clear( $_POST["search"] );
    	$city_id = (int)$_POST["city_id"];
        
        if($search){

	    	$getAll = getAll("select * from uni_metro where name like '%$search%' and parent_id!=0 and city_id='".$city_id."'");

	    	if(count($getAll)){
	    		foreach ($getAll as $key => $value) {
	    			$main = findOne("uni_metro", "id=?", [$value["parent_id"]]);
	    			?>
		            <div  data-name="<?php echo $value["name"]; ?>" data-id="<?php echo $value["id"]; ?>" data-color="<?php echo $main["color"]; ?>" >
		            	<strong><i style="background-color:<?php echo $main["color"]; ?>;"></i> <?php echo $value["name"]; ?></strong> <span class="span-subtitle" ><?php echo $main["name"]; ?></span>
		            </div>    			
	    			<?php
	    		}
	    	}else{
	    		echo false;
	    	}

        }else{
        	echo false;
        }

    }

    if($_POST["action"] == "load_country_city"){

    	$country_alias = clear($_POST["alias"]);
        
        echo $Geo->cityDefault($country_alias,30,false);

    }

    if($_POST["action"] == "mobile_menu_load_geo"){

		  $Geo->set( array( "city_id" => intval($_POST["city_id"]) , "region_id" => intval($_POST["region_id"]) , "country_id" => intval($_POST["country_id"]), "action" => "modal" ) );

		  $city_areas = getAll("select * from uni_city_area where city_area_id_city=? order by city_area_name asc", [ intval($_SESSION["geo"]["data"]["city_id"]) ]);
		  $city_metro = getAll("select * from uni_metro where city_id=? and parent_id!=0 Order by name ASC", [ intval($_SESSION["geo"]["data"]["city_id"]) ]); 

		  if($city_areas){
		  ?>

		      <div class="uni-select" data-status="0" >

		           <div class="uni-select-name" data-name="<?php echo $ULang->t("Район"); ?>" > <span><?php echo $ULang->t("Район"); ?></span> <i class="la la-angle-down"></i> </div>
		           <div class="uni-select-list" >
		               <?php
		               foreach ($city_areas as $value) {
		                  ?>
		                  <label> <input type="checkbox" name="filter[area][]" value="<?php echo $value["city_area_id"]; ?>" > <span><?php echo $ULang->t( $value["city_area_name"], [ "table" => "uni_city_area", "field" => "city_area_name" ] ); ?></span> <i class="la la-check"></i> </label>
		                  <?php
		               }
		               ?>
		           </div>
		      
		      </div>

		  <?php
		  }

		  if($city_metro){
		  ?>

		      <div class="container-custom-search">
		        <input type="text" class="ads-create-input action-input-search-metro" placeholder="<?php echo $ULang->t("Поиск станций метро"); ?>">
		        <div class="custom-results SearchMetroResults" style="display: none;"></div>
		      </div>

		      <div class="ads-container-metro-station"></div>

		  <?php
		  }

    }

	if($_POST["action"] == "searchAddressByApi"){

		$query = urlencode(trim(clearSearch($_POST["query"])));
		$city_id = (int)$_POST["city_id"];
		$results = [];
		$concat = [];

		if($query){

			if($settings["map_vendor"] == "yandex"){

				$curl=curl_init('https://geocode-maps.yandex.ru/1.x/?apikey='.$settings["map_yandex_key"].'&format=json&geocode='.$query);

				curl_setopt_array($curl,array(
						CURLOPT_USERAGENT=>'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:60.0) Gecko/20100101 Firefox/60.0',
						CURLOPT_ENCODING=>'gzip, deflate',
						CURLOPT_RETURNTRANSFER=>1,
						CURLOPT_HTTPHEADER=>array(
								'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
								'Accept-Language: en-US,en;q=0.5',
								'Accept-Encoding: gzip, deflate',
								'Connection: keep-alive',
								'Upgrade-Insecure-Requests: 1',
						),
				));

				$results_decode = json_decode(curl_exec($curl), true);

				if($results_decode){

					foreach ($results_decode['response']['GeoObjectCollection']['featureMember'] as $value) { 

						$concat = [];
						$data = $value['GeoObject']['metaDataProperty']['GeocoderMetaData']['Address']['Components'];

						if(isset($data)){	

							foreach ($data as $item) {
							  if($item["kind"] == "street"){
							  	$concat[] = $item["name"];
							  }
							  if($item["kind"] == "house"){
							  	$concat[] = $item["name"];
							  }							  
							  if($item["kind"] == "area"){
							  	$concat[] = $item["name"];
							  }	
							  if($item["kind"] == "province"){
							  	$concat[] = $item["name"];
							  }	
							  if($item["kind"] == "locality"){
							  	$concat[] = $item["name"];
							  }								  
							  if($item["kind"] == "other"){
							  	$concat[] = $item["name"];
							  }							  						  						  
							}

							$coordinates = explode(' ', $value['GeoObject']['Point']['pos']);

							if($concat && $coordinates) $results[implode(', ',$concat)] = '<div class="item-city" data-lat="'.$coordinates[1].'" data-lon="'.$coordinates[0].'" >'.implode(', ',$concat).'</div>';											
						}
					}

					if($results){
						echo implode('',$results);
					}
					
				}

			}else{

				$curl=curl_init('https://nominatim.openstreetmap.org/search?q='.$query.'&format=json&polygon=1&addressdetails=1&accept-language=ru');

				curl_setopt_array($curl,array(
						CURLOPT_USERAGENT=>'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:60.0) Gecko/20100101 Firefox/60.0',
						CURLOPT_ENCODING=>'gzip, deflate',
						CURLOPT_RETURNTRANSFER=>1,
						CURLOPT_HTTPHEADER=>array(
								'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
								'Accept-Language: en-US,en;q=0.5',
								'Accept-Encoding: gzip, deflate',
								'Connection: keep-alive',
								'Upgrade-Insecure-Requests: 1',
						),
				));

				$results_decode = json_decode(curl_exec($curl), true);

				if($results_decode){

					foreach ($results_decode as $value) { 
						if(isset($value["address"])){	
							if(isset($value["address"]["country_code"])) unset($value["address"]["country_code"]);
							if(isset($value["address"]["country"])) unset($value["address"]["country"]);
							if(isset($value["address"]["postcode"])) unset($value["address"]["postcode"]);
							if(isset($value["address"]["region"]))  unset($value["address"]["region"]);
							if(isset($value["address"]["state"])) unset($value["address"]["state"]);
							if(isset($value["address"]["city"])) unset($value["address"]["city"]);
							if(isset($value["address"]["region"])) unset($value["address"]["region"]);
							if(isset($value["address"]["ISO3166-2-lvl3"])) unset($value["address"]["ISO3166-2-lvl3"]);
							if(isset($value["address"]["ISO3166-2-lvl4"])) unset($value["address"]["ISO3166-2-lvl4"]);
							if($value["address"]) $results[implode(', ',$value["address"])] = '<div class="item-city" data-lat="'.$value['lat'].'" data-lon="'.$value['lon'].'" >'.implode(', ',$value["address"]).'</div>';											
						}
					}

					if($results){
						echo implode('',$results);
					}
					
				}

			}

		}

	}



}

?>