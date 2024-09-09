<?php

class CategoryBoard
{

  function alias($category_alias = "", $geo_alias = "")
  {
    global $settings;

    if ($settings["main_type_products"] == 'physical') {
      if ($geo_alias) {
        return _link($geo_alias . "/" . $category_alias);
      } else {
        if (isset($_SESSION["geo"]["alias"])) {
          return _link($_SESSION["geo"]["alias"] . "/" . $category_alias);
        } else {
          return _link($category_alias);
        }
      }
    } else {
      return _link($category_alias);
    }

  }

  function allMain()
  {

    $ULang = new ULang();

    $getCategories = $this->getCategories("where category_board_visible=1");

    if ($getCategories["category_board_id_parent"][0]) {
      foreach ($getCategories["category_board_id_parent"][0] as $key => $value) {
        $out[] = $ULang->t($value["category_board_name"], ["table" => "uni_category_board", "field" => "category_board_name"]);
      }
      return implode(",", $out);
    }

  }


  function GetCar($mark = '', $model = '', $page = 1, $output = 12, $generation = 0, $filters = [])
  {

    if (count($filters)) {
      // $getAd = getAll("select * from `model` where 1 LIMIT " . $output . " OFFSET " . ($page - 1) * $output . "", array());



      $str_filter = '';
      $array_filter = [];

      if (isset($filters['transmission'])) {
        $str_filter .= 'and `specifications`.`transmission`=? ';
        array_push($array_filter, $filters['transmission']);
      }
      if (isset($filters['engine_type'])) {
        $str_filter .= 'and `specifications`.`engine-type`=? ';
        array_push($array_filter, $filters['engine_type']);
      }
      if (isset($filters['drive'])) {
        $str_filter .= 'and `specifications`.`drive`=? ';
        array_push($array_filter, $filters['drive']);
      }

      if (isset($filters['body-type'])) {
        $str_filter .= 'and `configuration`.`body-type`=? ';
        array_push($array_filter, $filters['body-type']);
      }

      if (isset($filters['mark'])) {
        $str_filter .= 'and `mark`.`name`=? ';
        array_push($array_filter, $filters['mark']);
      }

      if (isset($filters['model'])) {
        $str_filter .= 'and `model`.`name`=? ';
        array_push($array_filter, $filters['model']);
      }

      
      if (isset($filters['year_from'])) {
        $str_filter .= 'and `model`.`year-from`>=? ';
        array_push($array_filter, $filters['year_from']);
        $str_filter .= 'and `model`.`year-to`>=? ';
        array_push($array_filter, $filters['year_from']);
      }
      if (isset($filters['year_to'])) {
        $str_filter .= 'and `model`.`year-to`<=? ';
        $str_filter .= 'and `model`.`year-from`<=? ';
        array_push($array_filter, $filters['year_to']);
        array_push($array_filter, $filters['year_to']);
      }
      if (isset($filters['volume-litres-from']) && $filters['volume-litres-from'] > 0) {
        $str_filter .= 'and `specifications`.`volume-litres`>=? ';
        array_push($array_filter, $filters['volume-litres-from']);
      }
      if (isset($filters['volume-litres-to']) && $filters['volume-litres-to'] > 0) {
        $str_filter .= 'and `specifications`.`volume-litres`<=? ';
        array_push($array_filter, $filters['volume-litres-to']);
      }
      if (isset($filters['horse-power-from']) && $filters['horse-power-from'] > 0) {
        $str_filter .= 'and `specifications`.`horse-power`>=? ';
        array_push($array_filter, $filters['horse-power-from']);
      }
      if (isset($filters['horse-power-to']) && $filters['horse-power-to'] > 0) {
        $str_filter .= 'and `specifications`.`horse-power`<=? ';
        array_push($array_filter, $filters['horse-power-to']);
      }

      if($str_filter == '') {
        $str_filter = 1;
      } else {
        $str_filter = ltrim($str_filter, "and");
      }

      $getAd = getAll("select DISTINCT 
      `configuration`.`id` as `img`,
      `mark`.`id` as `mark_id`,
      `mark`.`name` as `mark_name`,
      `model`.`id` as `model_id`,
      `model`.`name` as `model_name`,
      `generation`.`name` as `generation_name`,
      `generation`.`year-start` as `year-start`,
      `generation`.`year-stop` as `year-stop`,
      `configuration`.`body-type` as `body-type`
      from `mark` 
      join `model` on `model`.`mark_id` = `mark`.`id`
      join `generation` on `generation`.`model_id` = `model`.`id`
      join `configuration` on `configuration`.`generation_id` = `generation`.`id`
      join `modification` on `modification`.`configuration_id` = `configuration`.`id`
      join `specifications` on `specifications`.`complectation_id` = `modification`.`complectation-id`
      where ". $str_filter . "  LIMIT " . $output . " OFFSET " . ($page - 1) * $output, $array_filter);

      $found = getAll("select  
      COUNT(DISTINCT `configuration`.`id`) from `mark` 
      join `model` on `model`.`mark_id` = `mark`.`id`
      join `generation` on `generation`.`model_id` = `model`.`id`
      join `configuration` on `configuration`.`generation_id` = `generation`.`id`
      join `modification` on `modification`.`configuration_id` = `configuration`.`id`
      join `specifications` on `specifications`.`complectation_id` = `modification`.`complectation-id`
      where ". $str_filter, $array_filter)[0]['COUNT(DISTINCT `configuration`.`id`)'] ;

      

    } else {
      if ($model == '') {

        $getAd = getAll("select * from `model` where `mark_id`=? LIMIT " . $output . " OFFSET " . ($page - 1) * $output . "", array($mark));
        $found = getAll("select COUNT(*) from `model` where `mark_id`=? ", array($mark))[0]['COUNT(*)'] ;

      } else {

        $getAd = getAll("select * from `model` where `mark_id`=? and `id`=? LIMIT " . $output . " OFFSET " . ($page - 1) * $output . "", array($mark, $model));
        $found = getAll("select COUNT(*) from `model` where `mark_id`=? and `id`=? ", array($mark, $model))[0]['COUNT(*)'] ;

      }

      foreach ($getAd as $key => $value) {


        $getMark = findOne("mark", "id =?", array($value['mark_id']));

        if ($generation == 0) {

          $getGeneration = getAll("select * from `generation` where `model_id`=?", array($value['id']));

        } else {

          $getGeneration = getAll("select * from `generation` where `model_id`=? and `year-start`=? ", array($value['id'], $generation));

        }

        $configurationArr = [];
        $modificationArr = [];
        $optionsArr = [];
        $specificationsArr = [];

        foreach ($getGeneration as $keygen => $Generation) {
          if ($generation != 0) {
            $getConfiguration = getAll("select * from `configuration` where `generation_id`=?", array($Generation['id']));
          } else {
            $getConfiguration = getAll("select `id` from `configuration` where `generation_id`=?", array($Generation['id']));
          }
          array_push($configurationArr, $getConfiguration);

          foreach ($getConfiguration as $keyconf => $configuration) {

            if ($generation != 0) {
              $getModification = getAll("select * from `modification` where `configuration_id`=?", array($configuration['id']));
              $modificationArr = $getModification;
              foreach ($getModification as $keymod => $modification) {

                $getOptions = findOne("options", "complectation_id =?", array($modification['complectation-id']));

                array_push($optionsArr, $getOptions);

                $getSpecifications = findOne("specifications", "complectation_id =?", array($modification['complectation-id']));

                array_push($specificationsArr, $getSpecifications);
              }
            }
          }

        }
        
        

        $getAd[$key]['generation'] = $getGeneration;
        $getAd[$key]['mark'] = $getMark;
        $getAd[$key]['configuration'] = $configurationArr;
        $getAd[$key]['modification'] = $modificationArr;
        $getAd[$key]['options'] = $optionsArr;
        $getAd[$key]['specifications'] = $specificationsArr;
      }


    }

    $pages = ceil($found / $output);
    

    if (count($getAd)) {
      $found = true;
    } else {
      $found = false;
    }

    return [$getAd, $found, 'pages' => $pages]; 
  }

  function get_filters_base_data()
  {
    $body_type = getAll("select DISTINCT `body-type` from `configuration`");
    $transmission = getAll("select DISTINCT `transmission` from `specifications`");
    $engine_type = getAll("select DISTINCT `engine-type` from `specifications`");
    $drive = getAll("select DISTINCT `drive` from `specifications`");
    $mark = getAll("select DISTINCT `name`,`id` from `mark`");    
    $year_min = getAll("select MIN(`year-from`) from `model`");
    $year_min = $year_min[0]["MIN(`year-from`)"];

    $return['body_type'] = $body_type;
    $return['transmission'] = $transmission;
    $return['engine_type'] = $engine_type;
    $return['drive'] = $drive;
    $return['mark'] = $mark;
    $return['year_min'] = $year_min;
    return $return;
  }

  function get_filters_base_models($mark) {
    $models = getAll("select DISTINCT `name` from `model` where `mark_id`=?", [$mark]);
    return $models;
  }


  function FilterData()
  {
    $getAd = getAll("select * from `model` where `year-from`=?", array(date("Y")));
    foreach ($getAd as $key => $value) {
      $getMark = findOne("mark", "id =?", array($value['mark_id']));
      $getGeneration = getAll("select * from `generation` where `model_id`=?", array($value['id']));

      $configurationArr = [];
      $modificationArr = [];
      $optionsArr = [];
      $specificationsArr = [];

      foreach ($getGeneration as $keygen => $Generation) {

        $getConfiguration = getAll("select * from `configuration` where `generation_id`=?", array($Generation['id']));
        array_push($configurationArr, $getConfiguration);

        foreach ($getConfiguration as $keyconf => $configuration) {

          $getModification = getAll("select * from `modification` where `configuration_id`=?", array($configuration['id']));
          array_push($modificationArr, $getModification);

          foreach ($getModification as $keymod => $modification) {

            $getOptions = getAll("select * from `options` where `complectation_id`=?", array($modification['complectation-id']));
            array_push($optionsArr, $getOptions);

            $getSpecifications = getAll("select * from `specifications` where `complectation_id`=?", array($modification['complectation-id']));
            array_push($specificationsArr, $getSpecifications);
          }
        }
      }

      $getAd[$key]['generation'] = $getGeneration;
      $getAd[$key]['mark'] = $getMark;
      $getAd[$key]['configuration'] = $configurationArr;
      $getAd[$key]['modification'] = $modificationArr;
      $getAd[$key]['options'] = $optionsArr;
      $getAd[$key]['specifications'] = $specificationsArr;
    }
    return $getAd;
  }

  function getCategories($query = "")
  {
    global $settings;

    $array = array();

    $Cache = new Cache();
    /* $Cache->get( [ "table" => "uni_category_board", "key" => $query ] ) */
    if (0) {

      return $Cache->get(["table" => "uni_category_board", "key" => $query]);

    } else {

      $get = getAll("SELECT * FROM uni_category_board $query ORDER By category_board_id_position ASC");
      if (count($get)) {

        foreach ($get as $result) {

          if ($result['category_board_id_parent']) {
            $result['category_board_chain'] = $this->aliasBuild($result['category_board_id']);
          } else {
            $result['category_board_chain'] = $result['category_board_alias'];
          }

          $array['category_board_chain1'][$result['category_board_chain']] = $result['category_board_chain'];
          $array['category_board_chain'][$result['category_board_chain']] = $result;
          $array['category_board_id_parent'][$result['category_board_id_parent']][$result['category_board_id']] = $result;
          $array['category_board_id'][$result['category_board_id']]['category_board_id_parent'] = $result['category_board_id_parent'];
          $array['category_board_id'][$result['category_board_id']]['category_board_name'] = $result['category_board_name'];
          $array['category_board_id'][$result['category_board_id']]['category_board_title'] = $result['category_board_title'];
          $array['category_board_id'][$result['category_board_id']]['category_board_description'] = $result['category_board_description'];
          $array['category_board_id'][$result['category_board_id']]['category_board_image'] = $result['category_board_image'];
          $array['category_board_id'][$result['category_board_id']]['category_board_text'] = $result['category_board_text'];
          $array['category_board_id'][$result['category_board_id']]['category_board_alias'] = $result['category_board_alias'];
          $array['category_board_id'][$result['category_board_id']]['category_board_id'] = $result['category_board_id'];
          $array['category_board_id'][$result['category_board_id']]['category_board_chain'] = $result['category_board_chain'];
          $array['category_board_id'][$result['category_board_id']]['category_board_price'] = $result['category_board_price'];
          $array['category_board_id'][$result['category_board_id']]['category_board_count_free'] = $result['category_board_count_free'];
          $array['category_board_id'][$result['category_board_id']]['category_board_status_paid'] = $result['category_board_status_paid'];
          $array['category_board_id'][$result['category_board_id']]['category_board_display_price'] = $result['category_board_display_price'];
          $array['category_board_id'][$result['category_board_id']]['category_board_variant_price_id'] = $result['category_board_variant_price_id'];
          $array['category_board_id'][$result['category_board_id']]['category_board_measures_price'] = $result['category_board_measures_price'];
          $array['category_board_id'][$result['category_board_id']]['category_board_auto_title'] = $result['category_board_auto_title'];
          $array['category_board_id'][$result['category_board_id']]['category_board_online_view'] = $result['category_board_online_view'];
          $array['category_board_id'][$result['category_board_id']]['category_board_status_maps'] = $result['category_board_status_maps'];
          $array['category_board_id'][$result['category_board_id']]['category_board_h1'] = $result['category_board_h1'];
          $array['category_board_id'][$result['category_board_id']]['category_board_auto_title_template'] = $result['category_board_auto_title_template'];
          $array['category_board_id'][$result['category_board_id']]['category_board_show_index'] = $result['category_board_show_index'];
          $array['category_board_id'][$result['category_board_id']]['category_board_booking'] = $result['category_board_booking'];
          $array['category_board_id'][$result['category_board_id']]['category_board_booking_variant'] = $result['category_board_booking_variant'];

          if (isset($result['category_board_rules'])) {
            $category_board_rules = $result['category_board_rules'] ? json_decode($result['category_board_rules'], true) : [];
            if ($category_board_rules) {
              foreach ($category_board_rules as $value_key) {
                $array['category_board_id'][$result['category_board_id']]['category_board_rules'][$value_key] = 1;
              }
            }
          }

          $array['category_board_id'][$result['category_board_id']]['category_board_secure'] = $result['category_board_secure'];

          if (isset($settings["functionality"]["auction"])) {
            $array['category_board_id'][$result['category_board_id']]['category_board_auction'] = $result['category_board_auction'];
          } else {
            $array['category_board_id'][$result['category_board_id']]['category_board_auction'] = 0;
          }

          if (isset($settings["functionality"]["marketplace"])) {
            $array['category_board_id'][$result['category_board_id']]['category_board_marketplace'] = $result['category_board_marketplace'];
          } else {
            $array['category_board_id'][$result['category_board_id']]['category_board_marketplace'] = 0;
          }

          if (isset($settings["functionality"]["booking"])) {
            $array['category_board_id'][$result['category_board_id']]['category_board_booking'] = $result['category_board_booking'];
          } else {
            $array['category_board_id'][$result['category_board_id']]['category_board_booking'] = 0;
          }

        }

        $Cache->set(["table" => "uni_category_board", "key" => $query, "data" => $array]);

      }

      return $array;

    }

  }

  function aliasBuild($id = 0)
  {

    $out = "";

    $get = getOne("SELECT * FROM uni_category_board where category_board_id=?", array($id));

    if ($get['category_board_id_parent'] != 0) {
      $out .= $this->aliasBuild($get['category_board_id_parent']) . "/";
    }
    $out .= $get['category_board_alias'];

    return $out;

  }

  function outParent($getCategories = [], $param = [])
  {
    global $config;

    $Ads = new Ads();
    $ULang = new ULang();
    $return = '';

    if ($Ads->queryGeo()) {
      $queryGeo = " and " . $Ads->queryGeo();
    }

    if ($param["category"]["category_board_id"]) {

      if (isset($getCategories["category_board_id_parent"][$param["category"]["category_board_id"]])) {
        foreach ($getCategories["category_board_id_parent"][$param["category"]["category_board_id"]] as $parent_value) {

          $countAd = $this->getCountAd($parent_value["category_board_id"]);

          $parent[] = replace(array("{PARENT_LINK}", "{PARENT_IMAGE}", "{PARENT_NAME}", "{COUNT_AD}"), array($this->alias($parent_value["category_board_chain"]), Exists($config["media"]["other"], $parent_value["category_board_image"], $config["media"]["no_image"]), $ULang->t($parent_value["category_board_name"], ["table" => "uni_category_board", "field" => "category_board_name"]), $countAd), $param["tpl_parent"]);

          $return .= replace(array("{PARENT_CATEGORY}"), array(implode($param["sep"], $parent)), $param["tpl"]);
          $parent = array();

        }
      } else {

        $id_parent = $getCategories["category_board_id"][$param["category"]["category_board_id_parent"]];

        if (isset($getCategories["category_board_id_parent"][$id_parent["category_board_id"]])) {
          foreach ($getCategories["category_board_id_parent"][$id_parent["category_board_id"]] as $parent_value) {

            if ($parent_value["category_board_id"] == $param["category"]["category_board_id"]) {
              $active = 'class="active"';
            } else {
              $active = '';
            }

            $countAd = $this->getCountAd($parent_value["category_board_id"]);

            $parent[] = replace(array("{PARENT_LINK}", "{PARENT_IMAGE}", "{PARENT_NAME}", "{ACTIVE}", "{COUNT_AD}"), array($this->alias($parent_value["category_board_chain"]), Exists($config["media"]["other"], $parent_value["category_board_image"], $config["media"]["no_image"]), $ULang->t($parent_value["category_board_name"], ["table" => "uni_category_board", "field" => "category_board_name"]), $active, $countAd), $param["tpl_parent"]);

            $return .= replace(array("{PARENT_CATEGORY}"), array(implode($param["sep"], $parent)), $param["tpl"]);
            $parent = array();

          }
        }
      }


    } else {

      /* if (isset($getCategories["category_board_id_parent"][0])) {
           foreach ($getCategories["category_board_id_parent"][0] as $value) {
              
              $countAd = $this->getCountAd( $value["category_board_id"] );
             
              $parent[] = replace(array("{PARENT_LINK}", "{PARENT_IMAGE}", "{PARENT_NAME}","{COUNT_AD}"),array($this->alias($value["category_board_chain"]),Exists($config["media"]["other"],$value["category_board_image"],$config["media"]["no_image"]),$ULang->t( $value["category_board_name"], [ "table" => "uni_category_board", "field" => "category_board_name" ] ),$countAd),$param["tpl_parent"]);

              $return .=  replace(array("{PARENT_CATEGORY}"),array(implode($param["sep"],$parent)),$param["tpl"]);
              $parent = array();

           }
       }*/

    }

    return $return;

  }

  function outMainCategory($tpl, $tpl_parent = "", $sep = "")
  {

    $getCategories = $this->getCategories("where category_board_visible=1");
    $Ads = new Ads();
    $ULang = new ULang();

    $return = "";
    $parent = array();
    if (isset($getCategories["category_board_id_parent"][0])) {
      foreach ($getCategories["category_board_id_parent"][0] as $value) {

        if ($getCategories["category_board_id_parent"][$value["category_board_id"]] && $tpl_parent) {
          foreach (array_slice($getCategories["category_board_id_parent"][$value["category_board_id"]], 0, 6) as $parent_value) {
            $parent[] = replace(array("{PARENT_LINK}", "{PARENT_IMAGE}", "{PARENT_NAME}"), array($this->alias($parent_value["category_board_chain"]), Exists($image_category, $parent_value["category_board_image"], $no_image), $ULang->t($parent_value["category_board_name"], ["table" => "uni_category_board", "field" => "category_board_name"])), $tpl_parent);
          }
        }

        $return .= replace(array("{LINK}", "{IMAGE}", "{NAME}", "{PARENT_CATEGORY}"), array($this->alias($value["category_board_alias"]), Exists($image_category, $value["category_board_image"], $no_image), $ULang->t($value["category_board_name"], ["table" => "uni_category_board", "field" => "category_board_name"]), implode($sep, $parent)), $tpl);
        $parent = array();
      }
    }
    return $return;
  }

  function idsBuild($parent_id = 0, $categories = [])
  {

    if (isset($categories['category_board_id_parent'][$parent_id])) {

      foreach ($categories['category_board_id_parent'][$parent_id] as $cat) {

        $ids[] = $cat['category_board_id'];

        if (isset($categories['category_board_id_parent'][$cat['category_board_id']])) {
          $ids[] = $this->idsBuild($cat['category_board_id'], $categories);
        }

      }

    }

    return isset($ids) ? implode(",", $ids) : '';

  }


  function viewCategory($id = 0)
  {
    if (detectRobots($_SERVER['HTTP_USER_AGENT']) == false) {
      if ($id) {
        if (!isset($_SESSION["view-category-ads"][$id])) {
          update("UPDATE uni_category_board SET category_board_count_view=category_board_count_view+1,category_board_datetime_view=? WHERE category_board_id=?", array(date("Y-m-d H:i:s"), $id));
          $_SESSION["view-category-ads"][$id] = 1;
        }
      }
    }
  }

  function breadcrumb($getCategories = array(), $id = 0, $tpl = "", $sep = "")
  {

    $ULang = new ULang();

    if ($getCategories) {

      if ($getCategories["category_board_id"][$id]['category_board_id_parent'] != 0) {
        $return[] = $this->breadcrumb($getCategories, $getCategories["category_board_id"][$id]['category_board_id_parent'], $tpl, $sep);
      }

      $return[] = replace(array("{LINK}", "{NAME}"), array($this->alias($getCategories["category_board_id"][$id]["category_board_chain"]), $ULang->t($getCategories["category_board_id"][$id]['category_board_name'], ["table" => "uni_category_board", "field" => "category_board_name"])), $tpl);

      return implode($sep, $return);

    }

  }

  function breadcrumbShop($getCategories = array(), $id = 0, $tpl = "", $shop_id_hash = "")
  {

    $ULang = new ULang();
    $Shop = new Shop();

    if ($getCategories) {

      if ($getCategories["category_board_id"][$id]['category_board_id_parent'] != 0) {
        $return[] = $this->breadcrumbShop($getCategories, $getCategories["category_board_id"][$id]['category_board_id_parent'], $tpl, $shop_id_hash);
      }

      $return[] = replace(array("{LINK}", "{NAME}"), array($Shop->aliasCategory($shop_id_hash, $getCategories["category_board_id"][$id]["category_board_chain"]), $ULang->t($getCategories["category_board_id"][$id]['category_board_name'], ["table" => "uni_category_board", "field" => "category_board_name"])), $tpl);

      return implode('', $return);

    }

  }

  function reverseId($getCategories = array(), $id = 0)
  {

    if ($getCategories) {

      if ($getCategories["category_board_id"][$id]['category_board_id_parent'] != 0) {
        $return[] = $this->reverseId($getCategories, $getCategories["category_board_id"][$id]['category_board_id_parent']);
      }

      $return[] = $getCategories["category_board_id"][$id]["category_board_id"];

      return implode(',', $return);

    }

  }

  function reverseMainIds($getCategories = array(), $id = 0)
  {

    if ($getCategories) {

      if ($getCategories["category_board_id"][$id]['category_board_id_parent'] != 0) {
        $return[] = $this->reverseMainIds($getCategories, $getCategories["category_board_id"][$id]['category_board_id_parent']);
      }

      $return[] = $getCategories["category_board_id"][$id]["category_board_id"];

      return implode(',', $return);

    }

  }

  function reverseMainId($getCategories = array(), $id = 0)
  {

    if ($getCategories) {

      if ($getCategories["category_board_id"][$id]['category_board_id_parent'] != 0) {
        $return[] = $this->reverseMainId($getCategories, $getCategories["category_board_id"][$id]['category_board_id_parent']);
      }

      $return[] = $getCategories["category_board_id"][$id]["category_board_id"];

      return $return[0];

    }

  }

  function getCountAd($id = 0, $user_id = 0)
  {
    global $settings;

    if ($settings['display_count_ads_categories']) {

      $count = 0;

      $Cache = new Cache();

      $getCache = $Cache->get(["table" => "count_ads", "key" => "count_ads"]);

      if ($getCache !== false) {

        if (!$user_id) {

          if ($_SESSION["geo"]["data"]["city_id"]) {
            $count = (int) $getCache['geo'][$id][$_SESSION["geo"]["data"]["city_id"]];
          } elseif ($_SESSION["geo"]["data"]["region_id"]) {
            $count = (int) $getCache['geo'][$id][$_SESSION["geo"]["data"]["region_id"]];
          } elseif ($_SESSION["geo"]["data"]["country_id"]) {
            $count = (int) $getCache['geo'][$id][$_SESSION["geo"]["data"]["country_id"]];
          } else {
            $count = (int) $getCache['category'][$id];
          }

        } else {
          $count = (int) $getCache['user'][$id][$user_id];
        }

      }

      if ($settings['count_ad_show_zero']) {
        return $count;
      } else {
        if ($count) {
          return $count;
        }
      }

    }

  }


}


?>