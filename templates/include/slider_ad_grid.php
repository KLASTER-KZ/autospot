<?php 
	$images = $Ads->getImages($value["ads_images"]);
	$service = $Ads->adServices($value["ads_id"]);
	$getShop = $Shop->getUserShop( $value["ads_id_user"] );
	
	$ads_id = $value['ads_id'];
	$filters = [
	'312' => 'query_1',
	'310' => 'query_2',
	'314' => 'query_3',];
	foreach ($filters as $filterId => $varName) {$$varName = getAll("SELECT ads_filters_variants_product_id, ads_filters_variants_val FROM uni_ads_filters_variants WHERE ads_filters_variants_product_id = $ads_id AND ads_filters_variants_id_filter = $filterId;");}
	
?>

<div class="item-grid <?php echo isset($service[2]) || isset($service[3]) ? "ads-highlight" : ""; ?>" title="<?php echo $value["ads_title"]; ?>" >
	
	<div class="item-grid-img" >
		<a href="<?php echo $Ads->alias($value); ?>" title="<?php echo $value["ads_title"]; ?>">
			
			<div class="item-labels" >
				<?php echo $Ads->outStatus($service, $value); ?>
			</div>
			
			<?php echo $Ads->CatalogOutAdGallery($images, $value); ?>
			
		</a>
		<?php echo $Ads->adActionFavorite($value, "catalog", "item-grid-favorite"); ?>
	</div>
	
	<div class="item-grid-info" >
        
        <div class="item-grid-price" >
            <!-- Блок с ценой в USD -->
			<div id="usdPriceBlock_<?php echo $value['ads_id']; ?>">
				<?php
					echo $Ads->outPrice( [ "data"=>$value,"class_price"=>"item-grid-price-now","class_price_old"=>"item-grid-price-old", "shop"=>$getShop, "abbreviation_million" => true ] );
				?>  
			</div>
			
			<!-- Блок с ценой в LARI (скрыт по умолчанию) -->
			<div class="item-grid-price-now" id="lariPriceBlock_<?php echo $value['ads_id']; ?>" style="display: none;">
				<?php echo ($value["ads_price"] == 0 || $param["data"]["ads_currency"] == '₾') ? "". $ULang->t("Договорная") ."" : "{$Main->price($value['ads_price'], $param['data']['ads_currency'])} {$param['data']['ads_currency']}";
				?>
			</div>          
		</div> 
		
		<a href="<?php echo $Ads->alias($value); ?>" ><?php
			$datas = custom_substr($value["ads_title"], 35, "...");
			$parts = explode(" ", $datas);
			
			for ($i = 0; $i <= min(count($parts), 100); $i++) {
				echo '<span class="tag' . $i . '"> '.$ULang->t($parts[$i], ["table" => "uni_ads_filters", "field" => "ads_filters_items_value"]).' </span>';
			}
		?></a>
	</div>
</div>
<script>
	$(document).ready(function () {
		// Получить значение выбранной кнопки из Local Storage
		var selectedButton = localStorage.getItem('selectedButton');
		
		// При загрузке страницы восстановить состояние кнопок
		if (selectedButton === 'lari') {
			$("#usdPriceBlock_<?php echo $value['ads_id']; ?>").hide();
			$("#lariPriceBlock_<?php echo $value['ads_id']; ?>").show();
			} else {
			$("#usdPriceBlock_<?php echo $value['ads_id']; ?>").show();
			$("#lariPriceBlock_<?php echo $value['ads_id']; ?>").hide();
		}
		
		// При нажатии на кнопку "USD"
		$("#btnUSD").on("click", function () {
			// Показать блок с ценой в USD
			$("#usdPriceBlock_<?php echo $value['ads_id']; ?>").show();
			// Скрыть блок с ценой в LARI
		$("#lariPriceBlock_<?php echo $value['ads_id']; ?>").hide();
		// Сохранить выбранную кнопку в Local Storage
		localStorage.setItem('selectedButton', 'usd');
		});
		
		// При нажатии на кнопку "LARI"
		$("#btnLARI").on("click", function () {
		// Скрыть блок с ценой в USD
		$("#usdPriceBlock_<?php echo $value['ads_id']; ?>").hide();
		// Показать блок с ценой в LARI
		$("#lariPriceBlock_<?php echo $value['ads_id']; ?>").show();
		// Сохранить выбранную кнопку в Local Storage
		localStorage.setItem('selectedButton', 'lari');
		});
		// При нажатии на кнопку "USD"
		$("#btnUSD2").on("click", function () {
		// Показать блок с ценой в USD
		$("#usdPriceBlock_<?php echo $value['ads_id']; ?>").show();
		// Скрыть блок с ценой в LARI
		$("#lariPriceBlock_<?php echo $value['ads_id']; ?>").hide();
		// Сохранить выбранную кнопку в Local Storage
		localStorage.setItem('selectedButton', 'usd');
		});
		
		// При нажатии на кнопку "LARI"
		$("#btnLARI2").on("click", function () {
		// Скрыть блок с ценой в USD
		$("#usdPriceBlock_<?php echo $value['ads_id']; ?>").hide();
		// Показать блок с ценой в LARI
		$("#lariPriceBlock_<?php echo $value['ads_id']; ?>").show();
		// Сохранить выбранную кнопку в Local Storage
		localStorage.setItem('selectedButton', 'lari');
		});
		});
		</script>
				