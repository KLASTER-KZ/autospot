<?php

define('cms', true);
session_start();

$config = require "../../../../../config.php";
include_once($config["basePath"] . "/systems/classes/Site.php");
include_once($config["basePath"] . "/" . $config["folder_admin"] . "/lang/" . $settings["lang_admin_default"] . ".php");

if (!(new Admin())->accessAdmin($_SESSION['cp_control_board'])) {
  $_SESSION["CheckMessage"]["warning"] = "Ограничение прав доступа!";
  exit;
}
include_once("../fn.php");

if (isAjax() == true) {

  $id_filter = (int) $_POST["id"];

  if (!$id_filter)
    exit;

  $getFilter = findOne("uni_ads_filters", "ads_filters_id=?", array($id_filter));
  $findItem = findOne("uni_ads_filters_items", "ads_filters_items_id_filter=? limit ?", array($id_filter, 1));

  $Filters = new Filters();

  $cat_ids = $Filters->getCategory(["id_filter" => $id_filter]);

  ?>
<style>
  .small-image-delete1 {
    position: absolute;
    color: white;
    top: 0;
    right: 0px;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 5px;
    width: 20px;
    height: 20px;
    border-radius: 50%;
    background-color: red;
}


.input-img1{
    display: none;
    position: absolute;
}

.change-img1{
  cursor: pointer;
}
</style>
  <div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-3 form-control-label">Название фильтра</label>
    <div class="col-lg-9">
      <input type="text" name="name" class="form-control setTranslate"
        value="<?php echo $getFilter->ads_filters_name; ?>" />
    </div>
  </div>

  <div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-3 form-control-label">Алиас</label>
    <div class="col-lg-9">
      <input type="text" name="alias" class="form-control outTranslate"
        value="<?php echo $getFilter->ads_filters_alias; ?>" />
    </div>
  </div>

  <?php if ($getFilter->ads_filters_id_parent == 0) { ?>
    <div class="form-group row d-flex align-items-center mb-5">
      <label class="col-lg-3 form-control-label">Категория</label>
      <div class="col-lg-9">
        <select class="selectpicker" name="id_cat[]" multiple="" title="Не выбрано" data-live-search="true">
          <?php echo outCategoryOptions(); ?>
        </select>
      </div>
    </div>
  <?php } ?>

  <div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-3 form-control-label">Вид при подаче объявления</label>
    <div class="col-lg-9">
      <select class="filter-list-cat-select selectpicker" name="type_filter">
        <option value="select" <?php if ($getFilter->ads_filters_type == "select") {
          echo 'selected=""';
        } ?>>Выпадающий
          список с одиночным выбором</option>
        <option value="select_multi" <?php if ($getFilter->ads_filters_type == "select_multi") {
          echo 'selected=""';
        } ?>>
          Выпадающий список с множественным выбором</option>
        <option value="input" <?php if ($getFilter->ads_filters_type == "input") {
          echo 'selected=""';
        } ?>>Поле ввода цифр
        </option>
        <option value="input_btn" <?php if ($getFilter->ads_filters_type == "input_btn") {
          echo 'selected=""';
        } ?>>Кнопки с
          одиночным выбором Да | Нет</option>
        <option value="input_multi_btn" <?php if ($getFilter->ads_filters_type == "input_multi_btn") {
          echo 'selected=""';
        } ?>>Кнопки с множественным выбором</option>
        <option value="input_btn_color" <?php if ($getFilter->ads_filters_type == "input_btn_color") {
          echo 'selected=""';
        } ?>>Кнопки выбора цвета</option>
        <option value="switch_btn" <?php if ($getFilter->ads_filters_type == "switch_btn") {
          echo 'selected=""';
        } ?>>
          Переключатель</option>
        <option value="input_checkbox" <?php if ($getFilter->ads_filters_type == "input_checkbox") {
          echo 'selected=""';
        } ?>>
          Чекбокс</option>
        <option value="input_text" <?php if ($getFilter->ads_filters_type == "input_text") {
          echo 'selected=""';
        } ?>>Поле
          ввода текста</option>
      </select>
    </div>
  </div>

  <div class="form-group row d-flex mb-5">
    <label class="col-lg-3 form-control-label">Фильтр активен</label>
    <div class="col-lg-9">
      <label>
        <input class="toggle-checkbox-sm toolbat-toggle" type="checkbox" name="visible" value="1" <?php if ($getFilter->ads_filters_visible) {
          echo 'checked=""';
        } ?>>
        <span><span></span></span>
      </label>
    </div>
  </div>

  <div class="form-group row d-flex">
    <label class="col-lg-3 form-control-label">Обязательный фильтр</label>
    <div class="col-lg-9">
      <label>
        <input class="toggle-checkbox-sm toolbat-toggle" type="checkbox" name="required" value="1" <?php if ($getFilter->ads_filters_required) {
          echo 'checked=""';
        } ?>>
        <span><span></span></span>
      </label>
    </div>
  </div>

  <div class="box-value-filters" <?php if ($getFilter->ads_filters_type == "input_text") {
    echo 'style="display: none;"';
  } ?>>
    <div class="form-group row d-flex mb-5">
      <label class="col-lg-3 form-control-label"></label>
      <div class="col-lg-9">

        <button class="btn btn-success btn-sm action-add-item-filter"><i class="la la-plus"></i> Добавить
          значение</button>

        <div class="alert alert-primary filter-slider-hint" style="margin-top: 15px; font-size: 12px;" role="alert">
          Добавьте 2 поля. В первом укажите значение от, а во втором поле значение до
        </div>

        <div class="list-podfilter">

          <?php

          $items = getAll("SELECT * FROM uni_ads_filters_items WHERE ads_filters_items_id_filter=? order by ads_filters_items_sort asc", array($id_filter));
          if (count($items) > 0) {

            foreach ($items as $item) {

              ?>
              <div class="form-group row d-flex align-items-center mb-5">

              <div class="col-lg-7" <?php if($id_filter != 90 && $id_filter != 309){ echo 'style="display: none;"'; } ?>>

                <div class="small-image-container" >
                  <span class="small-image-delete1" > <i class="la la-trash"></i> </span>

                  <?php   
                    if($id_filter == 90){
                      echo img(array( "img1" => array( "class" => "change-img1", "path" => $config["media"]["car_logo"] . "/" . $item["ads_filters_items_logo"], "width" => "60px" ), "img2" => array( "class" => "change-img1", "path" => $config["media"]["other"] . "/icon_photo_add.png", "width" => "60px" ) ));
                    } else if($id_filter == 309){
                      echo img(array( "img1" => array( "class" => "change-img1", "path" => $config["media"]["car_body"] . "/" . $item["ads_filters_items_logo"], "width" => "60px" ), "img2" => array( "class" => "change-img1", "path" => $config["media"]["other"] . "/icon_photo_add.png", "width" => "60px" ) ));
                    }
                    ?>

                  <input type="hidden" class="image_delete" name="image_delete<?php echo $item["ads_filters_items_id"]; ?>" value="0" >
                  <input type="file" name="image<?php echo $item["ads_filters_items_id"]; ?>" class="input-img1" id="<?php echo $item["ads_filters_items_id"]; ?>" >
                </div>

                </div>

                <div class="podfilter-item"><input type="text" class="form-control"
                    value="<?php echo $item["ads_filters_items_value"]; ?>"
                    name="value_filter[edit][<?php echo $item["ads_filters_items_id"]; ?>]" /><i
                    class="la la-arrows-v sort-move-podfilter"></i><i class="la la-times delete-podfilter"></i></div>
              </div>
              <?php

            }

          }

          ?>

        </div>

      </div>
    </div>
  </div>

  <input type="hidden" name="id_filter" value="<?php echo $id_filter; ?>">
  <input type="hidden" name="id_item" value="<?php echo $findItem->ads_filters_items_id_item_parent; ?>">


  <?php
}
?>