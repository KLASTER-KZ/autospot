<?php 
	$images = $Ads->getImages($value["ads_images"]);
	$service = $Ads->adServices($value["ads_id"]);
	$getShop = $Shop->getUserShop( $value["ads_id_user"] );
	
	$ads_id = $value['ads_id'];
	$filters = [
	'312' => 'query_1',
	'310' => 'query_2',
	'314' => 'query_3',
	'89' => 'query_4',
	];
	foreach ($filters as $filterId => $varName) {$$varName = getAll("SELECT ads_filters_variants_product_id, ads_filters_variants_val FROM uni_ads_filters_variants WHERE ads_filters_variants_product_id = $ads_id AND ads_filters_variants_id_filter = $filterId;");}
	
?>
<div class="col-lg-4th col-md-2 col-sm-6 col-6" >
	<div class="item-grid <?php echo $service[2] || $service[3] ? "" : ""; ?>" title="<?php echo $value["ads_title"]; ?>" >
		
		<div class="item-grid-img" >
			<a href="<?php echo $Ads->alias($value); ?>" title="<?php echo $value["ads_title"]; ?>" >
				
				<div class="item-labels" >
					<?php echo $Ads->outStatus( $service, $value ); ?>
				</div>
				
				<?php echo $Ads->CatalogOutAdGallery($images, $value); ?>
				
			</a>
			<?php echo $Ads->adActionFavorite($value, "catalog", "item-grid-favorite"); ?>
		</div>
		
		<div class="item-grid-info" >
			<div class="item-grid-price" >
				
				<!-- Блок с ценой в USD -->
				<div id="usdPriceBlock_<?php echo $value['ads_id']; ?>">
					<?php echo $Ads->outPrice(["data"=>$value,"class_price"=>"item-grid-price-now","class_price_old"=>"item-grid-price-old", "shop"=>$getShop, "abbreviation_million" => true]); ?>
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
			<div class="property-list">
				<div>
					<?php foreach ($query_2 AS $value2): ?>
					<svg fill="#242424" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 512 512" xml:space="preserve" width="18px" height="18px"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g> <g> <path d="M437.02,74.98C388.667,26.628,324.38,0,256,0S123.333,26.628,74.98,74.98C26.628,123.333,0,187.62,0,256 s26.628,132.667,74.98,181.02C123.333,485.372,187.62,512,256,512s132.667-26.628,181.02-74.98 C485.372,388.667,512,324.38,512,256S485.372,123.333,437.02,74.98z M256,478.609c-122.746,0-222.609-99.862-222.609-222.609 S133.254,33.391,256,33.391S478.609,133.254,478.609,256S378.746,478.609,256,478.609z"></path> </g> </g> <g> <g> <rect x="239.304" y="66.445" width="33.391" height="54.973"></rect> </g> </g> <g> <g> <rect x="144.041" y="97.397" transform="matrix(0.809 -0.5878 0.5878 0.809 -42.7066 118.3336)" width="33.391" height="54.973"></rect> </g> </g> <g> <g> <rect x="85.16" y="178.422" transform="matrix(0.309 -0.9511 0.9511 0.309 -125.4502 239.1576)" width="33.392" height="54.975"></rect> </g> </g> <g> <g> <rect x="74.387" y="289.382" transform="matrix(0.9511 -0.309 0.309 0.9511 -89.5896 46.456)" width="54.975" height="33.392"></rect> </g> </g> <g> <g> <rect x="393.426" y="278.583" transform="matrix(0.309 -0.9511 0.9511 0.309 -7.6944 601.5519)" width="33.393" height="54.975"></rect> </g> </g> <g> <g> <rect x="382.634" y="189.215" transform="matrix(0.9511 -0.309 0.309 0.9511 -43.5552 136.799)" width="54.975" height="33.393"></rect> </g> </g> <g> <g> <rect x="323.78" y="108.202" transform="matrix(0.5878 -0.809 0.809 0.5878 43.7479 335.6581)" width="54.973" height="33.391"></rect> </g> </g> <g> <g> <path d="M169.275,335.566v102.047h173.449V335.566H169.275z M309.333,404.222H202.666v-35.265h0h106.666V404.222z"></path> </g> </g> <g> <g> <path d="M272.696,233.859v-82.237h-33.391v82.237c-15.303,6.516-26.06,21.704-26.06,39.359c0,23.575,19.18,42.755,42.755,42.755 s42.755-19.18,42.755-42.755C298.755,255.564,287.999,240.376,272.696,233.859z M256,282.583c-5.163,0-9.364-4.201-9.364-9.364 c0-5.163,4.201-9.364,9.364-9.364c5.163,0,9.364,4.201,9.364,9.364C265.364,278.382,261.163,282.583,256,282.583z"></path> </g> </g> </g></svg>
					
					<?php
						$value2 = $value2['ads_filters_variants_val'];
						$formatted_value = ($value2 >= 1000) ? number_format($value2 / 1000, 0, '', ' ') . ' ' . $ULang->t("тыс. км") : number_format($value2, 0, '', ' ') . ' ' . $ULang->t("км");
						echo $formatted_value;
					?>
					<?php endforeach; ?>
					
					<?php foreach ($query_4 as $value1): ?>
					<svg width="20px" height="20px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <circle cx="12" cy="12" r="10" stroke="#474747" stroke-width="1.5"></circle> <circle cx="12" cy="12" r="6" stroke="#474747" stroke-width="1.5"></circle> <circle cx="12" cy="12" r="2" stroke="#474747" stroke-width="1.5"></circle> <path d="M6 12L10 12" stroke="#474747" stroke-width="1.5" stroke-linecap="round"></path> <path d="M14 12L18 12" stroke="#474747" stroke-width="1.5" stroke-linecap="round"></path> <path d="M9 17.1963L11 13.7322" stroke="#474747" stroke-width="1.5" stroke-linecap="round"></path> <path d="M13 10.2681L15 6.80396" stroke="#474747" stroke-width="1.5" stroke-linecap="round"></path> <path d="M15 17.1963L13 13.7322" stroke="#474747" stroke-width="1.5" stroke-linecap="round"></path> <path d="M11 10.2681L9 6.80396" stroke="#474747" stroke-width="1.5" stroke-linecap="round"></path> </g></svg>
					<?php
						$get2 = getAll("SELECT ads_filters_items_value FROM uni_ads_filters_items WHERE ads_filters_items_id = " . $value1['ads_filters_variants_val'] . ";");
						foreach ($get2 as $value2) {
							echo $ULang->t($value2['ads_filters_items_value']);
						}
					?>
					<?php endforeach; ?> 
				</div>
				<div>
					<?php foreach ($query_3 AS $value3): ?>
					<svg fill="#575757" height="20px" width="20px" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 511.999 511.999" xml:space="preserve"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g> <g> <path d="M494.32,196.801l-4.858-8.131h-85.516v39.564h-8.557v-57.371h-44.32l-28.138-24.95h-46.53v-22.695h14.966V89.827H172.742 v33.391h14.966v22.695h-48.443l-28.138,24.95H55.791v16.696v66.236h-22.4v-42.616H0v118.625h33.391v-42.617h22.4v66.236v16.696 h83.474l58.709,52.054h197.414v-58.444h8.557v39.565h85.516l4.858-8.132c1.81-3.027,17.68-31.537,17.68-99.181 S496.13,199.829,494.32,196.801z M221.101,123.22h21.909v22.695h-21.909V123.22z M468.927,369.902h-31.59v-39.565h-75.34v58.444 H210.646l-58.709-52.054H89.183V204.255h34.617l28.138-24.95h158.32l28.138,24.95h23.601v57.371h75.34v-39.564h31.59 c3.873,11.386,9.681,34.956,9.681,73.921C478.609,334.947,472.801,358.516,468.927,369.902z"></path> </g> </g> </g></svg>
					<?php
						$originalValue = $value3['ads_filters_variants_val'];
						$formattedValue = number_format($originalValue, 1);
						echo $formattedValue;
					?>
				<?php endforeach; ?>
				
				<?php foreach ($query_1 as $value4): ?>
				<?php
                $get2 = getAll("SELECT ads_filters_items_value FROM uni_ads_filters_items WHERE ads_filters_items_id = " . $value4['ads_filters_variants_val'] . ";");
                foreach ($get2 as $value4) {
				echo $ULang->t($value4['ads_filters_items_value']);
                }
				?>
				<?php endforeach; ?> 
				
				</div>
				</div>
				
				
				</div>
				</div>
				</div>
				<script>
				$(document).ready(function() {
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
				$("#btnUSD").on("click", function() {
				// Показать блок с ценой в USD
				$("#usdPriceBlock_<?php echo $value['ads_id']; ?>").show();
				// Скрыть блок с ценой в LARI
				$("#lariPriceBlock_<?php echo $value['ads_id']; ?>").hide();
				// Сохранить выбранную кнопку в Local Storage
				localStorage.setItem('selectedButton', 'usd');
				});
				
				// При нажатии на кнопку "LARI"
				$("#btnLARI").on("click", function() {
				// Скрыть блок с ценой в USD
				$("#usdPriceBlock_<?php echo $value['ads_id']; ?>").hide();
				// Показать блок с ценой в LARI
				$("#lariPriceBlock_<?php echo $value['ads_id']; ?>").show();
				// Сохранить выбранную кнопку в Local Storage
				localStorage.setItem('selectedButton', 'lari');
				});
				// При нажатии на кнопку "USD"
				$("#btnUSD2").on("click", function() {
				// Показать блок с ценой в USD
				$("#usdPriceBlock_<?php echo $value['ads_id']; ?>").show();
				// Скрыть блок с ценой в LARI
				$("#lariPriceBlock_<?php echo $value['ads_id']; ?>").hide();
				// Сохранить выбранную кнопку в Local Storage
				localStorage.setItem('selectedButton', 'usd');
				});
				
				// При нажатии на кнопку "LARI"
				$("#btnLARI2").on("click", function() {
				// Скрыть блок с ценой в USD
				$("#usdPriceBlock_<?php echo $value['ads_id']; ?>").hide();
				// Показать блок с ценой в LARI
				$("#lariPriceBlock_<?php echo $value['ads_id']; ?>").show();
				// Сохранить выбранную кнопку в Local Storage
				localStorage.setItem('selectedButton', 'lari');
				});
				});
				</script>
				
								