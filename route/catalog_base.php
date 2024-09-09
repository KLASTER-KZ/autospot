<?php
$config = require "./config.php";
$static_msg = require "./static/msg.php";
$route_name = "catalog_base";
$visible_footer = true;
$visible_cities = true;

$Main = new Main();
$settings = $Main->settings();

$CategoryBoard = new CategoryBoard();
$Ads = new Ads();
$Seo = new Seo();
$Geo = new Geo();
$Profile = new Profile();
$Filters = new Filters();
$Banners = new Banners();
$Elastic = new Elastic();
$Shop = new Shop();
$ULang = new ULang();

cleanFiltersVars();




unset($_SESSION["temp_change_category"]);
$getCategoryBoard = $CategoryBoard->getCategories("where category_board_visible=1");
if ($data['newcatalog']) {
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

    $newCatalog = $getAd;
} else {
    $newCatalog = [];
}

if ($generation) {
    $data_model = $found[0];
} else if(!$data['filter_found']) {
    $data_model = $found[0][0];
}

$filters_data = $CategoryBoard->get_filters_base_data();

echo $Main->tpl("catalog_base.tpl", compact('filters_data','Seo', 'complectation', 'key_complect', 'Geo', 'found', 'Main', 'newCatalog', 'getCategoryBoard', 'data', 'data_model', 'generation', 'visible_footer', 'Ads', 'route_name', 'Profile', 'settings', 'CategoryBoard', 'Filters', 'Banners', 'ULang', 'visible_cities', 'Shop', 'riddle', 'model','model_filter','mark_filter'));
