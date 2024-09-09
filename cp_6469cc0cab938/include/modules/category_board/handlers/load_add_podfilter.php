<?php

define('cms', true);
session_start();

$config = require "../../../../../config.php";
include_once( $config["basePath"] . "/systems/classes/Site.php");
include_once( $config["basePath"] . "/" . $config["folder_admin"] . "/lang/" . $settings["lang_admin_default"].".php" );

if( !(new Admin())->accessAdmin($_SESSION['cp_control_board']) ){
   $_SESSION["CheckMessage"]["warning"] = "Ограничение прав доступа!";
   exit;
}
include_once("../fn.php");

if(isAjax() == true){

$id_filter = (int)$_POST["id"];

?>

<div class="form-group row d-flex align-items-center mb-5">
  <label class="col-lg-3 form-control-label">Название фильтра</label>
  <div class="col-lg-9">
      <input type="text" name="name" class="form-control setTranslate" value="" /> 
  </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
  <label class="col-lg-3 form-control-label">Алиас</label>
  <div class="col-lg-9">
      <input type="text" name="alias" class="form-control outTranslate" value="" /> 
  </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
  <label class="col-lg-3 form-control-label">Вид при подаче объявления</label>
  <div class="col-lg-9">
      <select class="filter-list-cat-select selectpicker" name="type_filter" >
        <option value="select" >Выпадающий список с одиночным выбором</option>
        <option value="select_multi" >Выпадающий список с множественным выбором</option>
		<option value="input_btn" >Кнопки с одиночным выбором Да | Нет</option>
        <option value="input_multi_btn" >Кнопки с множественным выбором</option>
        <option value="input_btn_color" >Кнопки выбора цвета</option>
        <option value="switch_btn" >Переключатель</option>
		<option value="input_checkbox" >Чекбокс</option>
        <option value="input" >Поле ввода цифр</option>
      </select>
  </div>
</div>

<div class="form-group row d-flex mb-5">
  <label class="col-lg-3 form-control-label">Фильтр активен</label>
  <div class="col-lg-9">
      <label>
        <input class="toggle-checkbox-sm toolbat-toggle" type="checkbox" name="visible" value="1" checked="" >
        <span><span></span></span>
      </label>
  </div>
</div>

<div class="form-group row d-flex mb-5">
  <label class="col-lg-3 form-control-label">Обязательный фильтр</label>
  <div class="col-lg-9">
      <label>
        <input class="toggle-checkbox-sm toolbat-toggle" type="checkbox" name="required" value="1" checked=""  >
        <span><span></span></span>
      </label>
  </div>
</div>

<input type="hidden" name="id_parent" value="<?php echo $id_filter; ?>" >

<?php
} 
?>